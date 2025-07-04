function js -d "Utilities for JavaScript"
    # Check if no arguments provided
    if test (count $argv) -eq 0
        echo "Usage: js <code|deps|circular|unused> [args...]"
        return 1
    end

    # Check the first argument to determine behavior
    switch $argv[1]
        # Run ESLints config inspector
        case eslint
        case eslint-config
            set -e argv[1]
            # Run ESLint config inspector
            bunx @eslint/config-inspector $argv
        # https://github.com/raineorshine/npm-check-updates
        # Check package updates with `npm-check-updates`
        case ncu
        case check
            set -e argv[1]
            bunx npm-check-updates
        # Check dependencies with madge
        case deps
            set -e argv[1]
            bunx madge $argv
        # Find circular dependencies with madge
        case circular
            set -e argv[1]
            bunx madge --circular $argv
        # Find orphaned/unused files with madge
        case unused
            set -e argv[1]
            bunx madge --orphans $argv
        # Run code and return result with `util.inspect`
        case '*'
            # Default behavior: treat all arguments as code to evaluate
            bun -e "console.log(util.inspect($argv));"
    end
end

# Autocomplete definitions for the js function
complete -c js -f  # Disable file completion by default

# First argument completions (subcommands)
complete -c js -n "not __fish_seen_subcommand_from deps circular unused" -a "eslint" -d "Run ESLint config inspector"
complete -c js -n "not __fish_seen_subcommand_from deps circular unused" -a "eslint-config" -d "Run ESLint config inspector"
complete -c js -n "not __fish_seen_subcommand_from deps circular unused" -a "ncu" -d "Check package updates with npm-check-updates"
complete -c js -n "not __fish_seen_subcommand_from deps circular unused" -a "check" -d "Check package updates with npm-check-updates"
complete -c js -n "not __fish_seen_subcommand_from deps circular unused" -a "deps" -d "Show dependency tree"
complete -c js -n "not __fish_seen_subcommand_from deps circular unused" -a "circular" -d "Find circular dependencies"
complete -c js -n "not __fish_seen_subcommand_from deps circular unused" -a "unused" -d "Find orphaned/unused files"
# # For deps subcommand - enable file completion for JavaScript files
# complete -c js -n "__fish_seen_subcommand_from deps" -a "(__fish_complete_suffix .js .ts .jsx .tsx .mjs .cjs)" -d "JavaScript/TypeScript file"

# # For circular subcommand - enable file completion for JavaScript files
# complete -c js -n "__fish_seen_subcommand_from circular" -a "(__fish_complete_suffix .js .ts .jsx .tsx .mjs .cjs)" -d "JavaScript/TypeScript file"

# # For unused subcommand - enable file completion for JavaScript files
# complete -c js -n "__fish_seen_subcommand_from unused" -a "(__fish_complete_suffix .js .ts .jsx .tsx .mjs .cjs)" -d "JavaScript/TypeScript file"

# Add common madge options for all subcommands
complete -c js -n "__fish_seen_subcommand_from deps circular unused" -l format -a "amd commonjs es6" -d "Module format"
complete -c js -n "__fish_seen_subcommand_from deps circular unused" -l config -d "Path to config file"
complete -c js -n "__fish_seen_subcommand_from deps circular unused" -l exclude -d "Exclude modules"
complete -c js -n "__fish_seen_subcommand_from deps circular unused" -l json -d "Output as JSON"
complete -c js -n "__fish_seen_subcommand_from deps circular unused" -l image -d "Write image to path"
complete -c js -n "__fish_seen_subcommand_from deps circular unused" -l dot -d "Show graph in DOT format"