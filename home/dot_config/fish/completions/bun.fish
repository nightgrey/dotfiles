source /usr/share/fish/functions/__fish_npm_helper.fish
source /usr/share/fish/functions/__fish_anypython.fish

function __bun_complete_history -d "Emit historic bun completions matching the current commandline, i.e. 'bun i w[...rest]'"
    set -l tokens (commandline --current-process --tokenize)
    history --prefix (commandline) | string replace -r \^$tokens[1]\\s\* "" | string replace -r \^$tokens[2]\\s\* "" | string split ' '
end
function __bun_complete_global_packages -d "Emit bun completions for global packages"
    set -l global "$HOME/.bun/install/global"
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

function __bun_complete_local_packages -d "Emit bun completions for local packages"
    __bun_complete_history
end

function __bun_complete_bins -d "Emit bun completions for binaries (node_modules/.bin)"
    string split ' ' (bun getcompletes b)
end

function __bun_complete_scripts -d "Emit bun completions for scripts"
    set -lx SHELL bash
    set -lx MAX_DESCRIPTION_LEN 40
    string trim (string split '\n' (string split '  ' (bun getcompletes z)))
end

function __bun_complete_packages -d "Emit bun completions for packages"
    if test (commandline -ct) != ""
        set -lx SHELL fish
        string split ' ' (bun getcompletes a (commandline -ct))
    end
end

function __bun_use_main
    __fish_use_subcommand
end

function __bun_is_main
    set -l commands create build init link unlink pm publish install add i uninstall remove rm r update x

    not __fish_seen_subcommand_from -a $commands

end

function __bun_complete_sub
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

function __bun_complete_main -d "Emit bun completions for bins and scripts"
    if __fish_seen_argument -l watch -l hot
        __fish_complete_path
        __bun_complete_scripts
        __bun_complete_sub
    else
        __bun_complete_sub
        __bun_complete_scripts
        __fish_complete_path
    end
end

function __bun_complete_run -d "Emit bun completions for bins and scripts"
    if __fish_seen_argument -l watch -l hot
        __fish_complete_path
        __bun_complete_scripts
    else
        __bun_complete_scripts
        __fish_complete_path
    end
end

complete -e -c bun -f
complete -c bun -k -F -n __fish_use_subcommand -a "(__bun_complete_main)"

# Basic flags
complete -c bun -l watch -d "Automatically restart the process on file change"
complete -c bun -l hot -d "Enable auto reload in the Bun runtime, test runner, or bundler"
complete -c bun -l no-clear-screen -d "Disable clearing the terminal screen on reload when --hot or --watch is enabled"
complete -c bun -l smol -d "Use less memory, but run garbage collection more often"

# Preload options
complete -c bun -s r -l preload -d "Import a module before other modules are loaded" -r -F
complete -c bun -l require -d "Alias of --preload, for Node.js compatibility" -r -F
complete -c bun -l import -d "Alias of --preload, for Node.js compatibility" -r -F

# __bun_is_main options
complete -c bun -l inspect -d "Activate Bun's __bun_is_mainger" -r
complete -c bun -l inspect-wait -d "Activate Bun's __bun_is_mainger, wait for a connection before executing" -r
complete -c bun -l inspect-brk -d "Activate Bun's __bun_is_mainger, set breakpoint on first line of code and wait" -r

# Install options
complete -c bun -l if-present -d "Exit without an error if the entrypoint does not exist"
complete -c bun -l no-install -d "Disable auto install in the Bun runtime"
complete -c bun -l install -d "Configure auto-install behavior" -r -a "auto fallback force"
complete -c bun -s i -d "Auto-install dependencies during execution. Equivalent to --install=fallback"

# Evaluation options
complete -c bun -s e -l eval -d "Evaluate argument as a script" -r
complete -c bun -s p -l print -d "Evaluate argument as a script and print the result" -r

# Package resolution options
complete -c bun -l prefer-offline -d "Skip staleness checks for packages in the Bun runtime and resolve from disk"
complete -c bun -l prefer-latest -d "Use the latest matching versions of packages in the Bun runtime, always checking npm"

# Network and server options
complete -c bun -l port -d "Set the default port for Bun.serve" -r
complete -c bun -l conditions -d "Pass custom conditions to resolve" -r
complete -c bun -l fetch-preconnect -d "Preconnect to a URL while code is loading" -r
complete -c bun -l max-http-header-size -d "Set the maximum size of HTTP headers in bytes. Default is 16KiB" -r
complete -c bun -l dns-result-order -d "Set the default order of DNS lookup results" -r -a "verbatim ipv4first ipv6first"
complete -c bun -l redis-preconnect -d "Preconnect to \$REDIS_URL at startup"

# Runtime options
complete -c bun -l expose-gc -d "Expose gc() on the global object. Has no effect on Bun.gc()."
complete -c bun -l no-deprecation -d "Suppress all reporting of the custom deprecation"
complete -c bun -l throw-deprecation -d "Determine whether or not deprecation warnings result in errors"
complete -c bun -l title -d "Set the process title" -r
complete -c bun -l zero-fill-buffers -d "Boolean to force Buffer.allocUnsafe(size) to be zero-filled"
complete -c bun -l no-addons -d "Throw an error if process.dlopen is called, and disable export condition \"node-addons\""
complete -c bun -l unhandled-rejections -d "Handle unhandled promise rejections" -r -a "strict throw warn none warn-with-error-code"

# Output and script options
complete -c bun -l silent -d "Don't print the script command"
complete -c bun -l elide-lines -d "Number of lines of script output shown when using --filter (default: 10). Set to 0 to show all lines" -r

# Version and help
complete -c bun -s v -l version -d "Print version and exit"
complete -c bun -l revision -d "Print version with revision and exit"
complete -c bun -s h -l help -d "Display this menu and exit"

# Workspace and execution options
complete -c bun -s F -l filter -d "Run a script in all workspace packages matching the pattern" -r
complete -c bun -s b -l bun -d "Force a script or package to use Bun's runtime instead of Node.js (via symlinking node)"
complete -c bun -l shell -d "Control the shell used for package.json scripts" -r -a "bun system"

# Configuration options
complete -c bun -l env-file -d "Load environment variables from the specified file(s)" -r -F
complete -c bun -l cwd -d "Absolute path to resolve files & entry points from. This just changes the process' cwd" -r -a "(__fish_complete_directories)"
complete -c bun -s c -l config -d "Specify path to Bun config file. Default \$commandwd/bunfig.toml" -r -F

# bun create

# bun build

# bun init

# bun link
complete -c bun -n "__fish_seen_subcommand_from link" -f
# bun unlink

complete -c bun -n "__fish_seen_subcommand_from unlink" -f
# bun pm

complete -c bun -n "__fish_seen_subcommand_from pm" -f
# bun publish

complete -c bun -n "__fish_seen_subcommand_from publish" -f

# bun install
for command in install add i

    # Lockfile and package.json behavior
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s y -l yarn -d 'Write a yarn.lock file (yarn v1)'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-save -d "Don't update package.json or save a lockfile"
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l save -d 'Save to package.json (true by default)'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l frozen-lockfile -d 'Disallow changes to lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l save-text-lockfile -d 'Save a text-based lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

    # Production and dependency types
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s p -l production -d "Don't install devDependencies"
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s d -l dev -d 'Add dependency to "devDependencies"'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l optional -d 'Add dependency to "optionalDependencies"'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l peer -d 'Add dependency to "peerDependencies"'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l omit -a 'dev optional peer' -d 'Exclude dependency types from install'

    # Security and certificates
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l ca -d 'Provide a Certificate Authority signing certificate' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l cafile -d 'File path to the certificate' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-verify -d 'Skip verifying integrity of newly downloaded packages'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l trust -d 'Add to trustedDependencies and install the package(s)'

    # Installation behavior
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l dry-run -d "Don't install anything"
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s f -l force -d 'Always request latest versions & reinstall all dependencies'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s g -l global -d 'Install globally'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s g -l g -d 'Install globally'

    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s E -l exact -d 'Add the exact version instead of the ^range'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l only-missing -d 'Only add dependencies to package.json if not already present'

    # Cache and performance
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l cache-dir -d 'Store & load cached data from specific directory' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-cache -d 'Ignore manifest cache entirely'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l backend -a 'hardlink symlink copyfile' -d 'Platform-specific optimizations'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l concurrent-scripts -d 'Maximum concurrent jobs for lifecycle scripts (default 5)'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l network-concurrency -d 'Maximum concurrent network requests (default 48)'

    # Scripts and lifecycle
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l ignore-scripts -d 'Skip lifecycle scripts in project package.json'

    # Output and logging
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l verbose -d 'Excessively verbose logging'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-progress -d 'Disable the progress bar'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-summary -d "Don't print a summary"

    # Workspaces and analysis
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s a -l analyze -d 'Analyze & install all dependencies of files recursively'

    # Package name completions (for installing new packages)
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -a '(__bun_complete_local_packages)'
end

# bun uninstall
for command in uninstall remove rm r
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -a '(__bun_complete_local_packages)'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -s g -l global -d 'Remove global package' -a '(__bun_complete_global_packages)'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -s g -l g -d 'Remove global package' -a '(__bun_complete_global_packages)'

    # Configuration flags
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s y -l yarn -d 'Write a yarn.lock file (yarn v1)'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s p -l production -d "Don't install devDependencies"
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-save -d "Don't update package.json or save a lockfile"
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l save -d 'Save to package.json (true by default)'

    # Installation behavior flags
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l dry-run -d "Don't install anything"
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l frozen-lockfile -d 'Disallow changes to lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s f -l force -d 'Always request the latest versions from the registry & reinstall all dependencies'

    # Cache and directory flags
    complete -r -c bun -n "__fish_seen_subcommand_from $command" -l cache-dir -d 'Store & load cached data from a specific directory path'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-cache -d 'Ignore manifest cache entirely'
    complete -r -c bun -n "__fish_seen_subcommand_from $command" -l cwd -d 'Set a specific cwd'

    # Output control flags
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l verbose -d 'Excessively verbose logging'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-progress -d 'Disable the progress bar'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-summary -d "Don't print a summary"

    # Security and verification flags
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l no-verify -d 'Skip verifying integrity of newly downloaded packages'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l ignore-scripts -d 'Skip lifecycle scripts in the project'\''s package.json'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l trust -d 'Add to trustedDependencies in the project'\''s package.json and install the package(s)'

    # Global flag
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -s g -l global -d 'Install globally'

    # Backend and registry flags
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l backend -d 'Platform-specific optimizations for installing dependencies' -a 'hardlink symlink copyfile'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l registry -d 'Use a specific registry by default, overriding .npmrc, bunfig.toml and environment variables'

    # Concurrency flags
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l concurrent-scripts -d 'Maximum number of concurrent jobs for lifecycle scripts (default 5)'
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l network-concurrency -d 'Maximum number of concurrent network requests (default 48)'

    # Lockfile flags
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l save-text-lockfile -d 'Save a text-based lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $command" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

    # Omit flag with specific values
    complete -x -c bun -n "__fish_seen_subcommand_from $command" -l omit -d 'Exclude dependencies from install' -a 'dev optional peer'
end

# bun update
complete -c bun -n "__fish_seen_subcommand_from update" -l latest -d "Update packages to their latest versions"
complete -f -c bun -n "__fish_seen_subcommand_from update" -l save-text-lockfile -d 'Save a text-based lockfile'
complete -f -c bun -n "__fish_seen_subcommand_from update" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

# bun run
complete -c bun -k -n "__fish_seen_subcommand_from run" -a "(__bun_complete_run)" -r

complete -x -c bun -n "__fish_seen_subcommand_from run" -l main-fields -d "Main fields to lookup in package.json. Defaults to --target dependent"
complete -f -c bun -n "__fish_seen_subcommand_from run" -l preserve-symlinks -d "Preserve symlinks when resolving files"
complete -f -c bun -n "__fish_seen_subcommand_from run" -l preserve-symlinks-main -d "Preserve symlinks when resolving the main entry point"
complete -x -c bun -n "__fish_seen_subcommand_from run" -l extension-order -d "Defaults to: .tsx,.ts,.jsx,.js,.json"
complete -r -c bun -n "__fish_seen_subcommand_from run" -l tsconfig-override -d "Specify custom tsconfig.json"
complete -x -c bun -n "__fish_seen_subcommand_from run" -s d -l define -d "Substitute K:V while parsing, e.g. --define process.env.NODE_ENV:\"development\""
complete -x -c bun -n "__fish_seen_subcommand_from run" -l drop -d "Remove function calls, e.g. --drop=console removes all console.* calls"
complete -x -c bun -n "__fish_seen_subcommand_from run" -s l -l loader -d "Parse files with .ext:loader, e.g. --loader .js:jsx"
complete -f -c bun -n "__fish_seen_subcommand_from run" -l no-macros -d "Disable macros from being executed in the bundler, transpiler and runtime"
complete -x -c bun -n "__fish_seen_subcommand_from run" -l jsx-factory -d "Changes the function called when compiling JSX elements using the classic JSX runtime"
complete -x -c bun -n "__fish_seen_subcommand_from run" -l jsx-fragment -d "Changes the function called when compiling JSX fragments"
complete -x -c bun -n "__fish_seen_subcommand_from run" -l jsx-import-source -d "Declares the module specifier to be used for importing the jsx and jsxs factory functions"
complete -x -c bun -n "__fish_seen_subcommand_from run" -l jsx-runtime -a "automatic classic" -d "JSX runtime mode"
complete -f -c bun -n "__fish_seen_subcommand_from run" -l ignore-dce-annotations -d "Ignore tree-shaking annotations such as @__PURE__"

# bun x
complete -c bun -n "__fish_seen_subcommand_from x" -a "(__bun_complete_bins)" -d "Execute a package binary, installing if needed" -f
