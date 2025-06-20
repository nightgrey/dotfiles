# **`.zshenv`**
# - **When loaded**: Always, for every shell (login, non-login, interactive, non-interactive)
# - **Purpose**: Environment variables that should be available to all processes
# - **Use for**: `PATH`, `EDITOR`, `BROWSER`, etc.
# - **Note**: Keep it lightweight since it's loaded most frequently

export BROWSER="brave"
export EDITOR="${EDITOR:-nano}" # see `editor.zsh`
export LAUNCH_EDITOR="${EDITOR:-nano}" # Vite (https://www.npmjs.com/package/@open-editor/vite)
export VISUAL="${VISUAL:-nano}"
export PAGER="${PAGER:-most}"
export PATH="$PATH:$ZDOTDIR/bin"

# Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export MOZ_ENABLE_WAYLAND=1
  export QT_QPA_PLATFORM="wayland;xcb"
  export GDK_BACKEND=wayland
  export XDG_CURRENT_DESKTOP=wayland
  export XDG_SESSION_DESKTOP=wayland
  
  export ELECTRON_OZONE_PLATFORM_HINT=auto
  export WAYLAND_DISPLAY=wayland-0
fi

# Private (if available)
if [ -f "$ZDOTDIR/private.zsh" ]; then
  source $ZDOTDIR/private.zsh
fi
