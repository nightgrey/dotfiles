source /usr/share/fish/functions/__fish_npm_helper.fish
source /usr/share/fish/functions/__fish_anypython.fish

function __bun_complete_history -a prefix
    history --null --prefix $prefix --max 100 | string split0 | string match -v '' | string replace -r "^$prefix\\s*" ""  | string split " " | string replace -r "^(--|-|\|).*" "" | string replace -r "^(\.|~)?\/.*\/.*" ""
end

function __bun_complete_bun_bins -d "Emit bun-native completions for binaries"
    string split ' ' (bun getcompletes b)
end

function __bun_complete_bun_scripts -d "Emit bun-native completions for scripts"
    set -lx SHELL bash
    string trim (string split '\n' (string split '  ' (bun getcompletes z)))
end

function __bun_complete_bun_packages -d "Emit bun-native completions for packages"
    if test (commandline -ct) != ""
        set -lx SHELL bash
        string split ' ' (bun getcompletes a (commandline -ct))
    end
end

function __bun_find_package_json
    set -l parents (__fish_parent_directories (pwd -P))

    for p in $parents
        if test -f "$p/package.json"
            echo "$p/package.json"
            return 0
        end
    end

    return 1
end

function __bun_complete_local_packages
    set -l package_json (__bun_find_package_json)
    if not test $status -eq 0
        # no package.json in tree
        return 1
    end

    if set -l python (__fish_anypython)
        $python -S -c 'import json, sys; data = json.load(sys.stdin);
print("\n".join(data.get("dependencies", []))); print("\n".join(data.get("devDependencies", [])))' <$package_json 2>/dev/null
    else if type -q jq
        jq -r '.dependencies as $a1 | .devDependencies as $a2 | ($a1 + $a2) | to_entries[] | .key' $package_json
    else
        set -l depsFound 0
        for line in (cat $package_json)
            # echo "evaluating $line"
            if test $depsFound -eq 0
                # echo "mode: noDeps"
                if string match -qr '(devD|d)ependencies"' -- $line
                    # echo "switching to mode: deps"
                    set depsFound 1
                    continue
                end
                continue
            end

            if string match -qr '\}' -- $line
                # echo "switching to mode: noDeps"
                set depsFound 0
                continue
            end

            # echo "mode: deps"

            string replace -r '^\s*"([^"]+)".*' '$1' -- $line
        end
    end
end

function __bun_complete_global_packages -d "Emit bun completions for global packages"
    set -l global "$BUN_INSTALL/install/global"
    set -l package_json "$global/package.json"

    if not test -f $package_json
        return
    end

    if set -l python (__fish_anypython)
        $python -S -c 'import json, sys; data = json.load(sys.stdin); print("\n".join(data.get("dependencies", []))); print("\n".join(data.get("devDependencies", [])))' <$package_json 2>/dev/null
    else if type -q jq
        echo jq -r '.dependencies as $a1 | .devDependencies as $a2 | ($a1 + $a2) | to_entries[] | .key' $package_json
    else

        set -l depsFound 0
        for line in (cat $package_json)
            # echo "evaluating $line"
            if test $depsFound -eq 0
                # echo "mode: noDeps"
                if string match -qr '(devD|d)ependencies"' -- $line
                    # echo "switching to mode: deps"
                    set depsFound 1
                    continue
                end
                continue
            end

            if string match -qr '\}' -- $line
                # echo "switching to mode: noDeps"
                set depsFound 0
                continue
            end

            # echo "mode: deps"

            string replace -r '^\s*"([^"]+)".*' '$1' -- $line
        end
    end
end

function __bun_complete_subcommands
    echo -e "run\tExecute a file with Bun"
    echo -e "test\tRun unit tests with Bun"
    echo -e "x\tExecute a package binary, installing if needed"
    echo -e "repl\tStart a REPL session with Bun"
    echo -e "exec\tRun a shell script directly with Bun"

    echo -e "install\tInstall packages"
    echo -e "add\tInstall packages"
    echo -e "remove\tUninstall packages"
    echo -e "update\tUpdate outdated packages"
    echo -e "audit\tCheck installed packages for vulnerabilities"
    echo -e "link\tRegister or link a local npm package"
    echo -e "unlink\tUnregister a local npm package"
    echo -e "publish\tPublish your package from local to npm"
    echo -e "patch\tPrepare a package for patching"
    echo -e "pm\tAdditional package management utilities"
    echo -e "info\tDisplay package metadata from the registry"

    echo -e "build\tTranspile and bundle one or more files"

    echo -e "init\tInitialize a Bun project in this directory"
    echo -e "create\tCreate a new project from a template"
    echo -e "upgrade\tUpgrade to latest version of Bun"
end

function __bun
    __fish_use_subcommand $argv
end

function __bun_sub
    __fish_seen_subcommand_from $argv
end

# Completions for `bun`
function __bun_complete
    __bun_complete_subcommands
    __bun_complete_bun_scripts
end

# Completions for `bun x`
function __bun_complete_x
    __bun_complete_bun_bins
    __bun_complete_bun_history "bun x"
    __bun_complete_bun_history "bunx"
end

# Completions for `bun update`
function __bun_complete_update
    __bun_complete_local_packages
    __bun_complete_bun_history "bun update"
end

# Completions for `bun uninstall`
function __bun_complete_uninstall
    __bun_complete_local_packages
    __bun_complete_history "bun uninstall"
    __bun_complete_history "bun remove"
    __bun_complete_history "bun rm"
    __bun_complete_history "bun r"
end

# Completions for `bun install`
function __bun_complete_install
    __bun_complete_local_packages
    __bun_complete_history "bun install"
    __bun_complete_history "bun i"
    __bun_complete_history "bun add"
end

# Completions for `bun run`
function __bun_complete_run
    __bun_complete_bun_scripts
end

# bun
complete -c bun -f
complete -c bun -F -k -n __bun -a '(__bun_complete)'

# Basic flags
complete -c bun -n __bun -l watch -d "Automatically restart the process on file change"
complete -c bun -n __bun -l hot -d "Enable auto reload in the Bun runtime, test runner, or bundler"
complete -c bun -n __bun -l no-clear-screen -d "Disable clearing the terminal screen on reload when --hot or --watch is enabled"
complete -c bun -n __bun -l smol -d "Use less memory, but run garbage collection, i.e.  more often"

# Preload options
complete -c bun -n __bun -s r -l preload -d "Import a module before other modules are loaded" -r -F
complete -c bun -n __bun -l require -d "Alias of --preload, for Node.js compatibility" -r -F
complete -c bun -n __bun -l import -d "Alias of --preload, for Node.js compatibility" -r -F

# __bun_is_main options
complete -c bun -n __bun -l inspect -d "Activate Bun's __bun_is_mainger" -r
complete -c bun -n __bun -l inspect-wait -d "Activate Bun's __bun_is_mainger, wait for a connection before executing" -r
complete -c bun -n __bun -l inspect-brk -d "Activate Bun's __bun_is_mainger, set breakpoint on first line of code and wait" -r

# Install options
complete -c bun -n __bun -l if-present -d "Exit without an error if the entrypoint does not exist"
complete -c bun -n __bun -l no-install -d "Disable auto install in the Bun runtime"
complete -c bun -n __bun -l install -d "Configure auto-install behavior" -r -a "auto fallback force"
complete -c bun -n __bun -s i -d "Auto-install dependencies during execution. Equivalent to --install=fallback"

# Evaluation options
complete -c bun -n __bun -s e -l eval -d "Evaluate argument as a script" -r
complete -c bun -n __bun -s p -l print -d "Evaluate argument as a script and print the result" -r

# Package resolution options
complete -c bun -n __bun -l prefer-offline -d "Skip staleness checks for packages in the Bun runtime and resolve from disk"
complete -c bun -n __bun -l prefer-latest -d "Use the latest matching versions of packages in the Bun runtime, always checking npm"

# Network and server options
complete -c bun -n __bun -l port -d "Set the default port for Bun.serve" -r
complete -c bun -n __bun -l conditions -d "Pass custom conditions to resolve" -r
complete -c bun -n __bun -l fetch-preconnect -d "Preconnect to a URL while code is loading" -r
complete -c bun -n __bun -l max-http-header-size -d "Set the maximum size of HTTP headers in bytes. Default is 16KiB" -r
complete -c bun -n __bun -l dns-result-order -d "Set the default order of DNS lookup results" -r -a "verbatim ipv4first ipv6first"
complete -c bun -n __bun -l redis-preconnect -d "Preconnect to \$REDIS_URL at startup"

# Runtime options
complete -c bun -n __bun -l expose-gc -d "Expose gc() on the global object. Has no effect on Bun.gc()."
complete -c bun -n __bun -l no-deprecation -d "Suppress all reporting of the custom deprecation"
complete -c bun -n __bun -l throw-deprecation -d "Determine whether or not deprecation warnings result in errors"
complete -c bun -n __bun -l title -d "Set the process title" -r
complete -c bun -n __bun -l zero-fill-buffers -d "Boolean to force Buffer.allocUnsafe(size) to be zero-filled"
complete -c bun -n __bun -l no-addons -d "Throw an error if process.dlopen is called, and disable export condition \"node-addons\""
complete -c bun -n __bun -l unhandled-rejections -d "Handle unhandled promise rejections" -r -a "strict throw warn none warn-with-error-code"

# Output and script options
complete -c bun -n __bun -l silent -d "Don't print the script sub"
complete -c bun -n __bun -l elide-lines -d "Number of lines of script output shown when using --filter (default: 10). Set to 0 to show all lines" -r

# Version and help
complete -c bun -n __bun -s v -l version -d "Print version and exit"
complete -c bun -n __bun -l revision -d "Print version with revision and exit"
complete -c bun -n __bun -s h -l help -d "Display this menu and exit"

# Workspace and execution options
complete -c bun -n __bun -s F -l filter -d "Run a script in all workspace packages matching the pattern" -r
complete -c bun -n __bun -s b -l bun -d "Force a script or package to use Bun's runtime instead of Node.js (via symlinking node)"
complete -c bun -n __bun -l shell -d "Control the shell used for package.json scripts" -r -a "bun system"

# Configuration options
complete -c bun -n __bun -l env-file -d "Load environment variables from the specified file(s)" -r -F
complete -c bun -n __bun -l cwd -d "Absolute path to resolve files & entry points from. This just changes the process' cwd" -r -a "(__fish_complete_directories)"
complete -c bun -n __bun -s c -l config -d "Specify path to Bun config file. Default \$subwd/bunfig.toml" -r -F

# bun run
complete -x -c bun -n "__bun_sub run" -l main-fields -d "Main fields to lookup in package.json. Defaults to --target dependent"
complete -c bun -n "__bun_sub run" -l preserve-symlinks -d "Preserve symlinks when resolving files"
complete -c bun -n "__bun_sub run" -l preserve-symlinks-main -d "Preserve symlinks when resolving the main entry point"
complete -x -c bun -n "__bun_sub run" -l extension-order -d "Defaults to: .tsx,.ts,.jsx,.js,.json"
complete -r -c bun -n "__bun_sub run" -l tsconfig-override -d "Specify custom tsconfig.json"
complete -x -c bun -n "__bun_sub run" -s d -l define -d "Substitute K:V while parsing, e.g. --define process.env.NODE_ENV:\"development\""
complete -x -c bun -n "__bun_sub run" -l drop -d "Remove function calls, e.g. --drop=console removes all console.* calls"
complete -x -c bun -n "__bun_sub run" -s l -l loader -d "Parse files with .ext:loader, e.g. --loader .js:jsx"
complete -c bun -n "__bun_sub run" -l no-macros -d "Disable macros from being executed in the bundler, transpiler and runtime"
complete -x -c bun -n "__bun_sub run" -l jsx-factory -d "Changes the function called when compiling JSX elements using the classic JSX runtime"
complete -x -c bun -n "__bun_sub run" -l jsx-fragment -d "Changes the function called when compiling JSX fragments"
complete -x -c bun -n "__bun_sub run" -l jsx-import-source -d "Declares the module specifier to be used for importing the jsx and jsxs factory functions"
complete -x -c bun -n "__bun_sub run" -l jsx-runtime -a "automatic classic" -d "JSX runtime mode"
complete -c bun -n "__bun_sub run" -l ignore-dce-annotations -d "Ignore tree-shaking annotations such as @__PURE__"

complete -c bun -F -n '__bun_sub run' -a '(__bun_complete_run)' -k -r

# bun link
complete -c bun -n '__bun_sub link'

# bun unlink
complete -c bun -n "__bun_sub unlink"

# bun pm
complete -c bun -n "__bun_sub pm"

# bun publish
complete -c bun -n "__bun_sub publish"

# bun install
for sub in install i add
    # Lockfile and package.json behavior
    complete -c bun -n "__bun_sub $sub" -s y -l yarn -d 'Write a yarn.lock file (yarn v1)'
    complete -c bun -n "__bun_sub $sub" -l no-save -d "Don't update package.json or save a lockfile"
    complete -c bun -n "__bun_sub $sub" -l save -d 'Save to package.json (true by default)'
    complete -c bun -n "__bun_sub $sub" -l frozen-lockfile -d 'Disallow changes to lockfile'
    complete -c bun -n "__bun_sub $sub" -l save-text-lockfile -d 'Save a text-based lockfile'
    complete -c bun -n "__bun_sub $sub" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

    # Production and dependency types
    complete -c bun -n "__bun_sub $sub" -s p -l production -d "Don't install devDependencies"
    complete -c bun -n "__bun_sub $sub" -s d -l dev -d 'Add dependency to "devDependencies"'
    complete -c bun -n "__bun_sub $sub" -l optional -d 'Add dependency to "optionalDependencies"'
    complete -c bun -n "__bun_sub $sub" -l peer -d 'Add dependency to "peerDependencies"'
    complete -x -c bun -n "__bun_sub $sub" -l omit -a 'dev optional peer' -d 'Exclude dependency types from install'

    # Security and certificates
    complete -c bun -n "__bun_sub $sub" -l ca -d 'Provide a Certificate Authority signing certificate' -r
    complete -c bun -n "__bun_sub $sub" -l cafile -d 'File path to the certificate' -r
    complete -c bun -n "__bun_sub $sub" -l no-verify -d 'Skip verifying integrity of newly downloaded packages'
    complete -c bun -n "__bun_sub $sub" -l trust -d 'Add to trustedDependencies and install the package(s)'

    # Installation behavior
    complete -c bun -n "__bun_sub $sub" -l dry-run -d "Don't install anything"
    complete -c bun -n "__bun_sub $sub" -s f -l force -d 'Always request latest versions & reinstall all dependencies'
    complete -c bun -n "__bun_sub $sub" -s g -l global -d 'Install globally'
    complete -c bun -n "__bun_sub $sub" -s g -l g -d 'Install globally'

    complete -c bun -n "__bun_sub $sub" -s E -l exact -d 'Add the exact version instead of the ^range'
    complete -c bun -n "__bun_sub $sub" -l only-missing -d 'Only add dependencies to package.json if not already present'

    # Cache and performance
    complete -c bun -n "__bun_sub $sub" -l cache-dir -d 'Store & load cached data from specific directory' -r
    complete -c bun -n "__bun_sub $sub" -l no-cache -d 'Ignore manifest cache entirely'
    complete -x -c bun -n "__bun_sub $sub" -l backend -a 'hardlink symlink copyfile' -d 'Platform-specific optimizations'
    complete -x -c bun -n "__bun_sub $sub" -l concurrent-scripts -d 'Maximum concurrent jobs for lifecycle scripts (default 5)'
    complete -x -c bun -n "__bun_sub $sub" -l network-concurrency -d 'Maximum concurrent network requests (default 48)'

    # Scripts and lifecycle
    complete -c bun -n "__bun_sub $sub" -l ignore-scripts -d 'Skip lifecycle scripts in project package.json'

    # Output and logging
    complete -c bun -n "__bun_sub $sub" -l verbose -d 'Excessively verbose logging'
    complete -c bun -n "__bun_sub $sub" -l no-progress -d 'Disable the progress bar'
    complete -c bun -n "__bun_sub $sub" -l no-summary -d "Don't print a summary"

    # Workspaces and analysis
    complete -c bun -n "__bun_sub $sub" -s a -l analyze -d 'Analyze & install all dependencies of files recursively'

    # Package name completions (for installing new packages)
    complete -c bun -n "__bun_sub $sub" -a '(__bun_complete_install)'
end

# bun uninstall
for sub in uninstall remove rm r
    complete -x -c bun -n "__bun_sub $sub" -s g -l global -d 'Remove global package' -a '(__bun_complete_global_packages)'
    complete -x -c bun -n "__bun_sub $sub" -s g -l g -d 'Remove global package' -a '(__bun_complete_global_packages)'

    # Configuration flags
    complete -c bun -n "__bun_sub $sub" -s y -l yarn -d 'Write a yarn.lock file (yarn v1)'
    complete -c bun -n "__bun_sub $sub" -s p -l production -d "Don't install devDependencies"
    complete -c bun -n "__bun_sub $sub" -l no-save -d "Don't update package.json or save a lockfile"
    complete -c bun -n "__bun_sub $sub" -l save -d 'Save to package.json (true by default)'

    # Installation behavior flags
    complete -c bun -n "__bun_sub $sub" -l dry-run -d "Don't install anything"
    complete -c bun -n "__bun_sub $sub" -l frozen-lockfile -d 'Disallow changes to lockfile'
    complete -c bun -n "__bun_sub $sub" -s f -l force -d 'Always request the latest versions from the registry & reinstall all dependencies'

    # Cache and directory flags
    complete -r -c bun -n "__bun_sub $sub" -l cache-dir -d 'Store & load cached data from a specific directory path'
    complete -c bun -n "__bun_sub $sub" -l no-cache -d 'Ignore manifest cache entirely'
    complete -r -c bun -n "__bun_sub $sub" -l cwd -d 'Set a specific cwd'

    # Output control flags
    complete -c bun -n "__bun_sub $sub" -l verbose -d 'Excessively verbose logging'
    complete -c bun -n "__bun_sub $sub" -l no-progress -d 'Disable the progress bar'
    complete -c bun -n "__bun_sub $sub" -l no-summary -d "Don't print a summary"

    # Security and verification flags
    complete -c bun -n "__bun_sub $sub" -l no-verify -d 'Skip verifying integrity of newly downloaded packages'
    complete -c bun -n "__bun_sub $sub" -l ignore-scripts -d 'Skip lifecycle scripts in the project'\''s package.json'
    complete -c bun -n "__bun_sub $sub" -l trust -d 'Add to trustedDependencies in the project'\''s package.json and install the package(s)'

    # Global flag
    complete -c bun -n "__bun_sub $sub" -s g -l global -d 'Install globally'

    # Backend and registry flags
    complete -x -c bun -n "__bun_sub $sub" -l backend -d 'Platform-specific optimizations for installing dependencies' -a 'hardlink symlink copyfile'
    complete -x -c bun -n "__bun_sub $sub" -l registry -d 'Use a specific registry by default, overriding .npmrc, bunfig.toml and environment variables'

    # Concurrency flags
    complete -x -c bun -n "__bun_sub $sub" -l concurrent-scripts -d 'Maximum number of concurrent jobs for lifecycle scripts (default 5)'
    complete -x -c bun -n "__bun_sub $sub" -l network-concurrency -d 'Maximum number of concurrent network requests (default 48)'

    # Lockfile flags
    complete -c bun -n "__bun_sub $sub" -l save-text-lockfile -d 'Save a text-based lockfile'
    complete -c bun -n "__bun_sub $sub" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

    # Omit flag with specific values
    complete -x -c bun -n "__bun_sub $sub" -l omit -d 'Exclude dependencies from install' -a 'dev optional peer'

    complete -x -c bun -n "__bun_sub $sub" -a '(__bun_complete_uninstall)'
end

# bun update
complete -c bun -n "__bun_sub update" -l latest -d "Update packages to their latest versions"
complete -c bun -n "__bun_sub update" -l save-text-lockfile -d 'Save a text-based lockfile'
complete -c bun -n "__bun_sub update" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

complete -x -c bun -n "__bun_sub update" -a "(__bun_complete_update)"

# bun x
complete -c bun -n "__fish_seen_subcommand_from x" -a "(__bun_complete_x)" -x -r
