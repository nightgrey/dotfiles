import * as fs from 'node:fs';
import * as path from 'node:path';
import * as util from 'util';
import { packageDirectorySync } from 'pkg-dir';
import { file, } from 'bun';
const { positionals, values } = util.parseArgs({
    args: Bun.argv,
    options: {
        inspect: {
            type: 'boolean',
            short: 'i',
            description: 'Inspect result',
        },
    },
    allowPositionals: true,
});

const CODE = positionals[2].trim();
const ROOT = packageDirectorySync();
const INSPECT = values.inspect ?? false;

const LOGS = new Set();

async function expose(x: string) {
    if (!ROOT) return undefined;
    const file = Bun.file(path.resolve(ROOT, x));
    if (!(await file.exists())) return undefined;

    try {
        const module = await import(path.resolve(ROOT, x));


        if (module) {
            for (const key in module) {
                if (key === 'default') {
                    globalThis[path.dirname(path.resolve(ROOT, x))] = module;
                    continue;
                }
                globalThis[key] = module[key];
            }

            LOGS.add(util.styleText('green', `✅ Imported ${x}`))
        }
    } catch (error) {
        LOGS.add(util.styleText('red', `❌ Did not import ${x}\n\n${error.message}`))
        return;
    }
}


await expose('./src');
await expose('./index');
LOGS.forEach(msg => process.stdout.write(msg + '\n'));

const inline = (str: string) => {
    const fence = util.styleText('white', '`');

    return `${fence}${str}${fence}`;
}
const block = (str: string) => {
    const fence = util.styleText('white', '```');

    return `${fence}\n${str}\n${fence}`;
}

const wrap = (str: string) => {
    const lines = str.split('\n').length;

    return lines > 1 ? block(str) : inline(str);
}

const run = new Function(CODE.startsWith('return') ? CODE : `return ${CODE}`)
try {
    const value = (await run()) ?? undefined;

    const output = INSPECT ? util.inspect(value) : String(value);

    const lines = output.split('\n').length;
    process.stdout.write(util.styleText('white', (wrap(output))));
} catch (error) {
    console.error(error);
    process.stderr.write(`${block(CODE)}\n\n${util.styleText('redBright', error.stack)}\n`);
}