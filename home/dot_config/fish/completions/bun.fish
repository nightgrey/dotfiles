# This is terribly complicated
# It's because:
# 1. bun run has to have dynamic completions
# 2. there are global options
# 3. bun {install add remove} gets special options
# 4. I don't know how to write fish completions well
# Contributions very welcome!!

function __fish__get_bun_bins
    string split ' ' (bun getcompletes b)
end

function __fish__get_bun_scripts
    set -lx SHELL bash
    set -lx MAX_DESCRIPTION_LEN 40
    string trim (string split '\n' (string split '\t' (bun getcompletes z)))
end

function __fish__get_bun_packages
    if test (commandline -ct) != ""
        set -lx SHELL fish
        string split ' ' (bun getcompletes a (commandline -ct))
    end
end

function __history_completions
    set -l tokens (commandline --current-process --tokenize)
    history --prefix (commandline) | string replace -r \^$tokens[1]\\s\* "" | string replace -r \^$tokens[2]\\s\* "" | string split ' '
end

function __fish__get_bun_bun_js_files
    string split ' ' (bun getcompletes j)
end

set -l bun_install_boolean_flags yarn production optional development no-save dry-run force no-cache silent verbose global
set -l bun_install_boolean_flags_descriptions "Write a yarn.lock file (yarn v1)" "Don't install devDependencies" "Add dependency to optionalDependencies" "Add dependency to devDependencies" "Don't update package.json or save a lockfile" "Don't install anything" "Always request the latest versions from the registry & reinstall all dependencies" "Ignore manifest cache entirely" "Don't output anything" "Excessively verbose logging" "Use global folder"

set -l bun_builtin_cmds_without_run dev create help bun upgrade discord install remove add init pm x
set -l bun_builtin_cmds_accepting_flags create help bun upgrade discord run init link unlink pm x

function __bun_complete_bins_scripts --inherit-variable bun_builtin_cmds_without_run -d "Emit bun completions for bins and scripts"
    # Do nothing if we already have a builtin subcommand,
    # or any subcommand other than "run".
    if __fish_seen_subcommand_from $bun_builtin_cmds_without_run
        or not __fish_use_subcommand && not __fish_seen_subcommand_from run
        return
    end
    # Do we already have a bin or script subcommand?
    set -l bins (__fish__get_bun_bins)
    if __fish_seen_subcommand_from $bins
        return
    end
    # Scripts have descriptions appended with a tab separator.
    # Strip off descriptions for the purposes of subcommand testing.
    set -l scripts (__fish__get_bun_scripts)
    if __fish_seen_subcommand_from (string split \t -f 1 -- $scripts)
        return
    end
    # Emit scripts.
    for script in $scripts
        echo $script
    end
    # Emit binaries and JS files (but only if we're doing `bun run`).
    if __fish_seen_subcommand_from run
        for bin in $bins
            echo "$bin"\t"package bin"
        end
        for file in (__fish__get_bun_bun_js_files)
            echo "$file"\t"Bun.js"
        end
    end
end

# Clear existing completions
complete -e -c bun

# Dynamically emit scripts and binaries
complete -c bun -f -a "(__bun_complete_bins_scripts)"

# Complete flags if we have no subcommand or a flag-friendly one.
set -l flag_applies "__fish_use_subcommand; or __fish_seen_subcommand_from $bun_builtin_cmds_accepting_flags"
complete -c bun \
    -n $flag_applies --no-files -s u -l origin -r -d 'Server URL. Rewrites import paths'
complete -c bun \
    -n $flag_applies --no-files -s p -l port -r -d 'Port number to start server from'
complete -c bun \
    -n $flag_applies --no-files -s d -l define -r -d 'Substitute K:V while parsing, e.g. --define process.env.NODE_ENV:\"development\"'
complete -c bun \
    -n $flag_applies --no-files -s e -l external -r -d 'Exclude module from transpilation (can use * wildcards). ex: -e react'
complete -c bun \
    -n $flag_applies --no-files -l use -r -d 'Use a framework (ex: next)'
complete -c bun \
    -n $flag_applies --no-files -l hot -r -d 'Enable hot reloading in Bun\'s JavaScript runtime'

# Complete dev and create as first subcommand.
complete -c bun \
    -n __fish_use_subcommand -a dev -d 'Start dev server'
complete -c bun \
    -n __fish_use_subcommand -a create -f -d 'Create a new project from a template'

# Complete "next" and "react" if we've seen "create".
complete -c bun \
    -n "__fish_seen_subcommand_from create" -a next -d 'new Next.js project'

complete -c bun \
    -n "__fish_seen_subcommand_from create" -a react -d 'new React project'

# Complete "upgrade" as first subcommand.
complete -c bun \
    -n __fish_use_subcommand -a upgrade -d 'Upgrade bun to the latest version' -x
# Complete "-h/--help" unconditionally.
complete -c bun \
    -s h -l help -d 'See all commands and flags' -x

# Complete "-v/--version" if we have no subcommand.
complete -c bun \
    -n "not __fish_use_subcommand" -l version -s v -d 'Bun\'s version' -x

# Complete additional subcommands.
complete -c bun \
    -n __fish_use_subcommand -a discord -d 'Open bun\'s Discord server' -x

complete -c bun \
    -n __fish_use_subcommand -a bun -d 'Generate a new bundle'

complete -c bun \
    -n "__fish_seen_subcommand_from bun" -F -d 'Bundle this'

complete -c bun \
    -n "__fish_seen_subcommand_from create; and __fish_seen_subcommand_from react next" -F -d "Create in directory"

complete -c bun \
    -n __fish_use_subcommand -a init -F -d 'Start an empty Bun project'

complete -c bun \
    -n __fish_use_subcommand -a install -f -d 'Install packages from package.json'

complete -c bun \
    -n __fish_use_subcommand -a add -F -d 'Add a package to package.json'

complete -c bun \
    -n __fish_use_subcommand -a remove -F -d 'Remove a package from package.json'

for i in (seq (count $bun_install_boolean_flags))
    complete -c bun \
        -n "__fish_seen_subcommand_from install add remove" -l "$bun_install_boolean_flags[$i]" -d "$bun_install_boolean_flags_descriptions[$i]"
end

complete -c bun \
    -n "__fish_seen_subcommand_from install add remove" -l cwd -d 'Change working directory'

complete -c bun \
    -n "__fish_seen_subcommand_from install add remove" -l cache-dir -d 'Choose a cache directory (default: $HOME/.bun/install/cache)'

complete -c bun \
    -n "__fish_seen_subcommand_from add" -d Popular -a '(__fish__get_bun_packages)'

complete -c bun \
    -n "__fish_seen_subcommand_from add" -d History -a '(__history_completions)'

complete -c bun \
    -n "__fish_seen_subcommand_from pm; and not __fish_seen_subcommand_from (__fish__get_bun_bins) (__fish__get_bun_scripts) cache;" -a 'bin ls cache hash hash-print hash-string' -f

complete -c bun \
    -n "__fish_seen_subcommand_from pm; and __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from (__fish__get_bun_bins) (__fish__get_bun_scripts);" -a rm -f

# Add built-in subcommands with descriptions.
complete -c bun -n __fish_use_subcommand -a create -f -d "Create a new project from a template"
complete -c bun -n __fish_use_subcommand -a "build bun" --require-parameter -F -d "Transpile and bundle one or more files"
complete -c bun -n __fish_use_subcommand -a upgrade -d "Upgrade Bun"
complete -c bun -n __fish_use_subcommand -a run -d "Run a script or package binary"
complete -c bun -n __fish_use_subcommand -a install -d "Install dependencies from package.json" -f
complete -c bun -n __fish_use_subcommand -a remove -d "Remove a dependency from package.json" -f
complete -c bun -n __fish_use_subcommand -a add -d "Add a dependency to package.json" -f
complete -c bun -n __fish_use_subcommand -a init -d "Initialize a Bun project in this directory" -f
complete -c bun -n __fish_use_subcommand -a link -d "Register or link a local npm package" -f
complete -c bun -n __fish_use_subcommand -a unlink -d "Unregister a local npm package" -f
complete -c bun -n __fish_use_subcommand -a pm -d "Additional package management utilities" -f
complete -c bun -n __fish_use_subcommand -a x -d "Execute a package binary, installing if needed" -f
complete -c bun -n __fish_use_subcommand -a outdated -d "Display the latest versions of outdated dependencies" -f
complete -c bun -n __fish_use_subcommand -a publish -d "Publish your package from local to npm" -f

# ####################
# CUSTOM COMPLETIONS #
######################

source /usr/share/fish/functions/__fish_npm_helper.fish
source /usr/share/fish/functions/__fish_anypython.fish

function __bun_installed_global_packages
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

function __bun_installed_local_packages
    __npm_installed_local_packages
end

for c in install add i
    # Configuration flags
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s c -l config -d 'Specify path to config file (bunfig.toml)' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l cwd -d 'Set a specific cwd' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l registry -d 'Use a specific registry by default' -r

    # Lockfile and package.json behavior
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s y -l yarn -d 'Write a yarn.lock file (yarn v1)'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-save -d "Don't update package.json or save a lockfile"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l save -d 'Save to package.json (true by default)'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l frozen-lockfile -d 'Disallow changes to lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l save-text-lockfile -d 'Save a text-based lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

    # Production and dependency types
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s p -l production -d "Don't install devDependencies"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s d -l dev -d 'Add dependency to "devDependencies"'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l optional -d 'Add dependency to "optionalDependencies"'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l peer -d 'Add dependency to "peerDependencies"'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l omit -a 'dev optional peer' -d 'Exclude dependency types from install'

    # Security and certificates
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l ca -d 'Provide a Certificate Authority signing certificate' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l cafile -d 'File path to the certificate' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-verify -d 'Skip verifying integrity of newly downloaded packages'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l trust -d 'Add to trustedDependencies and install the package(s)'

    # Installation behavior
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l dry-run -d "Don't install anything"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s f -l force -d 'Always request latest versions & reinstall all dependencies'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s g -l global -d 'Install globally'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s g -l g -d 'Install globally'

    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s E -l exact -d 'Add the exact version instead of the ^range'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l only-missing -d 'Only add dependencies to package.json if not already present'

    # Cache and performance
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l cache-dir -d 'Store & load cached data from specific directory' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-cache -d 'Ignore manifest cache entirely'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l backend -a 'hardlink symlink copyfile' -d 'Platform-specific optimizations'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l concurrent-scripts -d 'Maximum concurrent jobs for lifecycle scripts (default 5)'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l network-concurrency -d 'Maximum concurrent network requests (default 48)'

    # Scripts and lifecycle
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l ignore-scripts -d 'Skip lifecycle scripts in project package.json'

    # Output and logging
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l silent -d "Don't log anything"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l verbose -d 'Excessively verbose logging'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-progress -d 'Disable the progress bar'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-summary -d "Don't print a summary"

    # Workspaces and analysis
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l filter -d 'Install packages for matching workspaces' -r
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s a -l analyze -d 'Analyze & install all dependencies of files recursively'

    # Help
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s h -l help -d 'Print help menu'

    # Package name completions (for installing new packages)
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -d 'Save to dependencies' -a '(__bun_installed_local_packages)'
end

for c in uninstall remove rm r
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -d 'Remove package' -a '(__bun_installed_local_packages)'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -s g -l global -d 'Remove global package' -a '(__bun_installed_global_packages)'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -s g -l g -d 'Remove global package' -a '(__bun_installed_global_packages)'

    # Configuration flags
    complete -r -c bun -n "__fish_seen_subcommand_from $c" -s c -l config -d 'Specify path to config file (bunfig.toml)'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s y -l yarn -d 'Write a yarn.lock file (yarn v1)'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s p -l production -d "Don't install devDependencies"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-save -d "Don't update package.json or save a lockfile"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l save -d 'Save to package.json (true by default)'

    # Certificate flags
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l ca -d 'Provide a Certificate Authority signing certificate'
    complete -r -c bun -n "__fish_seen_subcommand_from $c" -l cafile -d 'The same as --ca, but is a file path to the certificate'

    # Installation behavior flags
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l dry-run -d "Don't install anything"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l frozen-lockfile -d 'Disallow changes to lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s f -l force -d 'Always request the latest versions from the registry & reinstall all dependencies'

    # Cache and directory flags
    complete -r -c bun -n "__fish_seen_subcommand_from $c" -l cache-dir -d 'Store & load cached data from a specific directory path'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-cache -d 'Ignore manifest cache entirely'
    complete -r -c bun -n "__fish_seen_subcommand_from $c" -l cwd -d 'Set a specific cwd'

    # Output control flags
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l silent -d "Don't log anything"
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l verbose -d 'Excessively verbose logging'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-progress -d 'Disable the progress bar'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-summary -d "Don't print a summary"

    # Security and verification flags
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l no-verify -d 'Skip verifying integrity of newly downloaded packages'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l ignore-scripts -d 'Skip lifecycle scripts in the project'\''s package.json'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l trust -d 'Add to trustedDependencies in the project'\''s package.json and install the package(s)'

    # Global flag
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s g -l global -d 'Install globally'

    # Backend and registry flags
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l backend -d 'Platform-specific optimizations for installing dependencies' -a 'hardlink symlink copyfile'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l registry -d 'Use a specific registry by default, overriding .npmrc, bunfig.toml and environment variables'

    # Concurrency flags
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l concurrent-scripts -d 'Maximum number of concurrent jobs for lifecycle scripts (default 5)'
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l network-concurrency -d 'Maximum number of concurrent network requests (default 48)'

    # Lockfile flags
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l save-text-lockfile -d 'Save a text-based lockfile'
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -l lockfile-only -d 'Generate a lockfile without installing dependencies'

    # Omit flag with specific values
    complete -x -c bun -n "__fish_seen_subcommand_from $c" -l omit -d 'Exclude dependencies from install' -a 'dev optional peer'

    # Help flag
    complete -f -c bun -n "__fish_seen_subcommand_from $c" -s h -l help -d 'Print this help menu'
end
