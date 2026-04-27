#!/usr/bin/env bun
/**
 * Vira Theme Accent Patcher
 *
 * Usage:
 *   bun accent.ts <hex-color>        # e.g. bun accent.ts #FF669E
 *   bun accent.ts <preset-name>      # e.g. bun accent.ts Pink
 *
 * Presets: Teal, Vira, White, Tomato, Orange, Yellow, Acid Lime,
 *          Lime, Bright Teal, Cyan, Blue, Indigo, Purple, Pink
 *
 * What it does:
 *   Modifies all Vira .theme.json and scheme .xml files under
 *   ./themes/ and ./schemes/ to replace the accent color with the
 *   given one, preserving each property's original alpha transparency.
 *   This replicates the runtime logic from the Vira Theme plugin.
 */

import { existsSync, readFileSync, writeFileSync, readdirSync } from "fs";
import { join, dirname } from "path";
import { parseArgs } from "util";

// ---------------------------------------------------------------------------
// Predefined accent colors (from the decompiled ViraThemeConfigFactory)
// ---------------------------------------------------------------------------
const PRESETS: Record<string, string> = {
  Teal: "#80CBC4",
  Vira: "#E9A581",
  White: "#FFFFFF",
  Tomato: "#F85044",
  Orange: "#FF7042",
  Yellow: "#FFCF3D",
  "Acid Lime": "#C6FF00",
  Lime: "#39EA5F",
  "Bright Teal": "#64FFDA",
  Cyan: "#57D7FF",
  Blue: "#5393FF",
  Indigo: "#758AFF",
  Purple: "#B54DFF",
  Pink: "#FF669E",
};

// ---------------------------------------------------------------------------
// UI property keys whose colour gets replaced by the accent
// (from decompiled ViraThemeConfigFactory → accentsPropertiesThemes)
// ---------------------------------------------------------------------------
const ACCENT_UI_KEYS: string[] = [
  "*.underlineColor",
  "ActionButton.hoverBackground",
  "ActionButton.pressedBackground",
  "ActionButton.pressedBorderColor",
  "Button.default.startBackground",
  "Button.default.endBackground",
  "SegmentedButton.selectedButtonColor",
  "ComboBox.modifiedItemForeground",
  "Counter.background",
  "Counter.foreground",
  "Link.activeForeground",
  "Link.hoverForeground",
  "Link.pressedForeground",
  "Link.visitedForeground",
  "Link.secondaryForeground",
  "Notification.linkForeground",
  "Plugins.Button.installFillBackground",
  "Plugins.Button.installFillBorderColor",
  "Plugins.Button.installForeground",
  "CompletionPopup.matchForeground",
  "ProgressBar.progressColor",
  "ProgressBar.indeterminateStartColor",
  "ProgressBar.indeterminateEndColor",
  "Slider.buttonColor",
  "Slider.buttonBorderColor",
  "GotItTooltip.stepForeground",
  "GotItTooltip.linkForeground",
  "GotItTooltip.Button.foreground",
  "GotItTooltip.Button.startBackground",
  "GotItTooltip.Button.endBackground",
  "ToolWindow.HeaderTab.underlineColor",
  "ToolWindow.HeaderTab.inactiveUnderlineColor",
  "ToolWindow.Button.selectedForeground",
  "ToolWindow.Button.selectedBackground",
  "CodeWithMe.EndSessionPopup.link",
  "FlameGraph.Tooltip.scaleBackground",
  "FlameGraph.Tooltip.scaleColor",
  "Tree.selectionForeground",
  "Tree.selectionInactiveForeground",
];

// ---------------------------------------------------------------------------
// Keys whose foreground is computed from accent luminance (black/white)
// (from decompiled ColorCustomisations → accentForegrounds)
// ---------------------------------------------------------------------------
const ACCENT_FOREGROUND_KEYS: string[] = [
  "Button.default.foreground",
  "Plugins.Button.installFillForeground",
];

// ---------------------------------------------------------------------------
// Editor scheme colour keys replaced with accent (applied to all schemes)
// (from decompiled ColorCustomisations → globalAccentsPropertiesSchemes)
// ---------------------------------------------------------------------------
const GLOBAL_SCHEME_KEYS: string[] = [
  "Adaptive.accent",
  "MODIFIED_TAB_ICON",
  "TAB_UNDERLINE",
  "TAB_UNDERLINE_INACTIVE",
];

// ---------------------------------------------------------------------------
// Editor scheme colour keys replaced with accent (Vira schemes only)
// (from decompiled ColorCustomisations → viraAccentsPropertiesSchemes)
// ---------------------------------------------------------------------------
const VIRA_SCHEME_KEYS: string[] = [
  "Adaptive.accent",
  "DOC_COMMENT_LINK",
  "JUPYTER.GUTTER_OUTPUT_EXECUTION_COUNT",
  "MODIFIED_LINES_COLOR",
  "MODIFIED_TAB_ICON",
  "TAB_UNDERLINE",
  "TAB_UNDERLINE_INACTIVE",
  "CTRL_CLICKABLE.FOREGROUND",
  "CTRL_CLICKABLE.EFFECT_COLOR",
  "FOLLOWED_HYPERLINK_ATTRIBUTES.FOREGROUND",
  "HYPERLINK_ATTRIBUTES.FOREGROUND",
  "HYPERLINK_ATTRIBUTES.EFFECT_COLOR",
  "INACTIVE_HYPERLINK_ATTRIBUTES.EFFECT_COLOR",
  "SEARCH_RESULT_ATTRIBUTES.EFFECT_COLOR",
];

const THEMES_DIR = join(import.meta.dir, "themes");
const SCHEMES_DIR = join(import.meta.dir, "schemes");

// ---------------------------------------------------------------------------
// Colour helpers
// ---------------------------------------------------------------------------

/** Parse "#RRGGBB" or "#RRGGBBAA" → { r, g, b, a? } */
function parseHex(hex: string): { r: number; g: number; b: number; a?: number } {
  const s = hex.replace(/^#/, "");
  const len = s.length;
  if (len < 6) throw new Error(`Invalid hex colour: ${hex}`);
  const r = parseInt(s.slice(0, 2), 16);
  const g = parseInt(s.slice(2, 4), 16);
  const b = parseInt(s.slice(4, 6), 16);
  let a: number | undefined;
  if (len >= 8) {
    a = parseInt(s.slice(6, 8), 16);
  }
  return { r, g, b, a };
}

/** Format { r, g, b, a? } → "#RRGGBB" or "#RRGGBBAA" */
function formatHex(r: number, g: number, b: number, a?: number): string {
  const rr = r.toString(16).padStart(2, "0");
  const gg = g.toString(16).padStart(2, "0");
  const bb = b.toString(16).padStart(2, "0");
  if (a !== undefined) {
    return `#${rr}${gg}${bb}${a.toString(16).padStart(2, "0")}`;
  }
  return `#${rr}${gg}${bb}`;
}

/** Relative luminance (sRGB) */
function luminance(r: number, g: number, b: number): number {
  const rs = r / 255;
  const gs = g / 255;
  const bs = b / 255;
  const toLin = (c: number) =>
    c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
  return 0.2126 * toLin(rs) + 0.7152 * toLin(gs) + 0.0722 * toLin(bs);
}

/** Return "#000000" or "#FFFFFF" depending on accent luminance */
function accentForeground(hex: string): string {
  const { r, g, b } = parseHex(hex);
  // The Java code uses: (R*299 + G*587 + B*114) / 1000 > 128
  const perceived = (r * 299 + g * 587 + b * 114) / 1000;
  return perceived > 128 ? "#000000" : "#FFFFFF";
}

/**
 * Given an *existing* colour string (e.g. "#80CBC40f") and a *new* accent
 * hex (e.g. "#FF669E"), return the new colour with the original alpha
 * preserved:
 *   "#FF669E0f"
 */
function replaceColorPreservingAlpha(existing: string, newAccent: string): string {
  const existingP = parseHex(existing);
  const newP = parseHex(newAccent);
  return formatHex(newP.r, newP.g, newP.b, existingP.a);
}

// ---------------------------------------------------------------------------
// Theme JSON patching
// ---------------------------------------------------------------------------

/**
 * Resolve a dotted path into a nested object, returning the leaf value and
 * a function to set it. Returns null if the path can't be fully traversed.
 */
function resolvePath(
  obj: Record<string, unknown>,
  path: string,
): { value: unknown; set: (v: unknown) => void } | null {
  const parts = path.split(".");
  let current: Record<string, unknown> = obj;
  for (let i = 0; i < parts.length - 1; i++) {
    const seg = parts[i];
    const child = current[seg];
    if (!child || typeof child !== "object" || Array.isArray(child)) {
      return null;
    }
    current = child as Record<string, unknown>;
  }
  const last = parts[parts.length - 1];
  if (!(last in current)) return null;
  return {
    value: current[last],
    set: (v: unknown) => {
      current[last] = v;
    },
  };
}

/**
 * Recursively find all values whose key === `keyName` in a nested object,
 * and return [parentObject, keyName] tuples so callers can modify them.
 */
function findAllKeys(
  obj: Record<string, unknown>,
  keyName: string,
): Array<[Record<string, unknown>, string]> {
  const results: Array<[Record<string, unknown>, string]> = [];
  for (const [k, v] of Object.entries(obj)) {
    if (k === keyName) {
      results.push([obj, k]);
    }
    if (v && typeof v === "object" && !Array.isArray(v)) {
      results.push(...findAllKeys(v as Record<string, unknown>, keyName));
    }
  }
  return results;
}

function patchThemeJson(
  filePath: string,
  accentHex: string,
  accentHexNoHash: string,
  fgHex: string,
): boolean {
  const raw = readFileSync(filePath, "utf-8");
  const theme = JSON.parse(raw);
  const ui: Record<string, unknown> = theme.ui ?? {};
  let changed = false;

  // ----- 1. Replace colours for each accent UI key -----
  for (const key of ACCENT_UI_KEYS) {
    if (key.startsWith("*.")) {
      // wildcard: match all keys with this suffix at any depth
      const suffix = key.slice(2);
      const matches = findAllKeys(ui, suffix);
      for (const [parent, k] of matches) {
        const existing = parent[k];
        if (typeof existing !== "string") continue;
        if (!/^#[0-9A-Fa-f]/.test(existing)) continue; // skip non-hex references like "border"
        const replaced = replaceColorPreservingAlpha(existing, accentHex);
        if (replaced !== existing) {
          parent[k] = replaced;
          changed = true;
        }
      }
    } else {
      const resolved = resolvePath(ui, key);
      if (!resolved) continue;
      const existing = resolved.value;
      if (typeof existing !== "string") continue;
      if (!/^#[0-9A-Fa-f]/.test(existing)) continue;
      const replaced = replaceColorPreservingAlpha(existing, accentHex);
      if (replaced !== existing) {
        resolved.set(replaced);
        changed = true;
      }
    }
  }

  // ----- 2. Replace accent foreground keys (luminance-based black/white) -----
  for (const key of ACCENT_FOREGROUND_KEYS) {
    const resolved = resolvePath(ui, key);
    if (!resolved) continue;
    const existing = resolved.value as string;
    if (existing === fgHex) continue;
    resolved.set(fgHex);
    changed = true;
  }

  if (!changed) {
    console.log(`  ${filePath} — no changes needed`);
    return false;
  }

  theme.ui = ui;
  writeFileSync(filePath, JSON.stringify(theme, null, 4) + "\n");
  console.log(`  ✓ ${filePath}`);
  return true;
}

// ---------------------------------------------------------------------------
// Scheme XML patching
// ---------------------------------------------------------------------------

/**
 * Patch a simple flat key like:
 *   <option name="Adaptive.accent" value="80CBC4" />
 */
function patchFlatSchemeKey(
  xml: string,
  key: string,
  accentHex: string,
  accentHexNoHash: string,
): string {
  // Match: <option name="KEY" value="HEX" />
  const regex = new RegExp(
    `(<option\\s+name="${escapeXml(key)}"\\s+value=")([0-9A-Fa-f]*)("\\s*/>)`,
    "g",
  );
  return xml.replace(regex, (_match, prefix, oldVal, suffix) => {
    if (!oldVal) return _match;
    // Preserve alpha from the old value
    const oldAlpha = oldVal.length > 6 ? oldVal.slice(6) : "";
    const newVal = accentHexNoHash + oldAlpha;
    return prefix + newVal + suffix;
  });
}

/**
 * Patch a nested attribute-level key like:
 *   CTRL_CLICKABLE.FOREGROUND → inside <option name="CTRL_CLICKABLE">…
 *
 * We find the outer block, then replace the inner <option name="KEY"> value.
 */
function patchNestedSchemeKey(
  xml: string,
  dottedKey: string,
  accentHex: string,
  accentHexNoHash: string,
): string {
  const dotIdx = dottedKey.indexOf(".");
  if (dotIdx === -1) return xml;
  const outerKey = dottedKey.slice(0, dotIdx);
  const innerKey = dottedKey.slice(dotIdx + 1);

  // Find the outer block: <option name="OUTER_KEY"> ... </option>
  const outerRegex = new RegExp(
    `(<option\\s+name="${escapeXml(outerKey)}">[\\s\\S]*?</option>)`,
    "g",
  );
  return xml.replace(outerRegex, (outerMatch) => {
    // Inside the block, replace inner <option name="INNER_KEY" value="..."/>
    const innerRegex = new RegExp(
      `(<option\\s+name="${escapeXml(innerKey)}"\\s+value=")([0-9A-Fa-f]*)("\\s*/>)`,
    );
    return outerMatch.replace(innerRegex, (_m, prefix, oldVal, suffix) => {
      if (!oldVal) return _m;
      const oldAlpha = oldVal.length > 6 ? oldVal.slice(6) : "";
      const newVal = accentHexNoHash + oldAlpha;
      return prefix + newVal + suffix;
    });
  });
}

function escapeXml(s: string): string {
  return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function patchSchemeXml(
  filePath: string,
  accentHex: string,
  accentHexNoHash: string,
): boolean {
  let xml = readFileSync(filePath, "utf-8");
  const before = xml;

  // Apply flat keys
  for (const key of [...GLOBAL_SCHEME_KEYS, ...VIRA_SCHEME_KEYS]) {
    if (key.includes(".") && key.split(".").length > 2) continue; // not flat
    if (!key.includes(".")) continue; // all our keys have dots
    // Check if it's a simple flat key (no deeper nesting beyond one dot)
    const dotCount = (key.match(/\./g) || []).length;
    if (dotCount === 1) {
      xml = patchFlatSchemeKey(xml, key, accentHex, accentHexNoHash);
    }
  }

  // Apply nested attribute-level keys (CTRL_CLICKABLE.FOREGROUND etc.)
  for (const key of VIRA_SCHEME_KEYS) {
    if (!key.includes(".")) continue;
    // Keys with more than one dot are nested attributes
    const dotCount = (key.match(/\./g) || []).length;
    if (dotCount >= 2) continue;
    // Check if this key refers to a sub-attribute (not a flat option)
    // Flat keys have the subkey after one dot: "Adaptive.accent" is flat
    // Nested attribute keys: "CTRL_CLICKABLE.FOREGROUND" where CTRL_CLICKABLE is a block
    // We can detect this by checking if the key after the dot is a known attribute name
    const knownNested = ["CTRL_CLICKABLE", "FOLLOWED_HYPERLINK_ATTRIBUTES",
      "HYPERLINK_ATTRIBUTES", "INACTIVE_HYPERLINK_ATTRIBUTES",
      "SEARCH_RESULT_ATTRIBUTES"];
    const outerPart = key.split(".")[0];
    if (knownNested.includes(outerPart)) {
      xml = patchNestedSchemeKey(xml, key, accentHex, accentHexNoHash);
    }
  }

  if (xml === before) {
    console.log(`  ${filePath} — no changes needed`);
    return false;
  }

  writeFileSync(filePath, xml);
  console.log(`  ✓ ${filePath}`);
  return true;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

function main() {
  const args = process.argv.slice(2);
  if (args.length < 1) {
    console.error("Usage: bun accent.ts <hex-colour | preset-name>");
    console.error("\nPresets:");
    for (const [name, hex] of Object.entries(PRESETS)) {
      console.error(`  ${name.padEnd(14)} ${hex}`);
    }
    process.exit(1);
  }

  const input = args[0];
  const presetHex = PRESETS[input];
  let accentHex: string;
  if (presetHex) {
    accentHex = presetHex;
    console.log(`Using preset "${input}" → ${accentHex}`);
  } else {
    // Validate hex
    if (!/^#[0-9A-Fa-f]{6}$/.test(input) && !/^#[0-9A-Fa-f]{8}$/.test(input)) {
      console.error(`Error: "${input}" is not a valid hex colour (#RRGGBB) or preset.`);
      process.exit(1);
    }
    accentHex = input;
    console.log(`Using custom colour → ${accentHex}`);
  }

  const accentHexNoHash = accentHex.replace("#", "").slice(0, 6);
  const fgHex = accentForeground(accentHex);
  console.log(`Accent foreground (luminance-based): ${fgHex}`);
  console.log("");

  // ----- Patch theme JSONs -----
  if (!existsSync(THEMES_DIR)) {
    console.error(`Error: themes directory not found at ${THEMES_DIR}`);
    process.exit(1);
  }
  const themeFiles = readdirSync(THEMES_DIR)
    .filter((f) => f.endsWith(".theme.json"))
    .sort();

  console.log("── Patching theme JSONs ──");
  for (const f of themeFiles) {
    const fp = join(THEMES_DIR, f);
    patchThemeJson(fp, accentHex, accentHexNoHash, fgHex);
  }

  // ----- Patch scheme XMLs -----
  if (!existsSync(SCHEMES_DIR)) {
    console.error(`Error: schemes directory not found at ${SCHEMES_DIR}`);
    process.exit(1);
  }
  const schemeFiles = readdirSync(SCHEMES_DIR)
    .filter((f) => f.endsWith(".xml"))
    .sort();

  console.log("\n── Patching scheme XMLs ──");
  for (const f of schemeFiles) {
    const fp = join(SCHEMES_DIR, f);
    patchSchemeXml(fp, accentHex, accentHexNoHash);
  }

  console.log("\nDone.");
}

main();
