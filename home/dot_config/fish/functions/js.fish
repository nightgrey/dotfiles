# eval fn
function js-eval -d "Evaluate code"
    argparse i/inspect -- $argv

    set -l code
    set -l inspect
    set -l fn
    set -l out

    set code (string join ' ' $argv)

    if test -z "$code" 
        echo "Usage: js [...code]"
        return 1
    end

    set dir (dirname (status filename))

    set script (path resolve "$dir/js-eval.ts")

    if set -ql _flag_i
        echo (bun run $script -- $code --inspect | string collect)
    else
        echo (bun run $script -- $code | string collect)
    end
end

function js -d "Utilities for JavaScript"
    # Check if no arguments provided
    if test (count $argv) -eq 0
        echo "Usage: js <code|deps|circular|unused> [args...]"
        return 1
    end

    if test (count $argv) -gt 1
        set -l first $argv[1]
        set -e argv[1]

        # Check the first argument to determine behavior
        switch $first
            # Run ESLints config inspector
            case eslint
            case eslint-config
                # Run ESLint config inspector
                bunx @eslint/config-inspector $argv
                # https://github.com/raineorshine/npm-check-updates
                # Check package updates with `npm-check-updates`
            case ncu
            case check
                bunx npm-check-updates
                # Check dependencies with madge
            case deps
                bunx madge $argv
                # Find circular dependencies with madge
            case circular
                bunx madge --circular $argv
                # Find orphaned/unused files with madge
            case unused
                bunx madge --orphans $argv
                # Run code and return result with `util.inspect`
            case i
                js-eval --inspect $argv
            case inspect
                js-eval --inspect $argv
            case '*'
                # Default behavior: treat all arguments as code to evaluate
                # If code contains return statement, return result
                js-eval $first $argv
        end
    else
        js-eval $argv
        return
    end

end

# Autocomplete definitions for the js function
complete -c js -f # Disable file completion by default

# First argument completions (firstcommands)
complete -c js -n "not __fish_seen_firstcommand_from deps circular unused" -a eslint -d "Run ESLint config inspector"
complete -c js -n "not __fish_seen_firstcommand_from deps circular unused" -a eslint-config -d "Run ESLint config inspector"
complete -c js -n "not __fish_seen_firstcommand_from deps circular unused" -a ncu -d "Check package updates with npm-check-updates"
complete -c js -n "not __fish_seen_firstcommand_from deps circular unused" -a check -d "Check package updates with npm-check-updates"
complete -c js -n "not __fish_seen_firstcommand_from deps circular unused" -a deps -d "Show dependency tree"
complete -c js -n "not __fish_seen_firstcommand_from deps circular unused" -a circular -d "Find circular dependencies"
complete -c js -n "not __fish_seen_firstcommand_from deps circular unused" -a unused -d "Find orphaned/unused files"
# # For deps firstcommand - enable file completion for JavaScript files
# complete -c js -n "__fish_seen_firstcommand_from deps" -a "(__fish_complete_suffix .js .ts .jsx .tsx .mjs .cjs)" -d "JavaScript/TypeScript file"

# # For circular firstcommand - enable file completion for JavaScript files
# complete -c js -n "__fish_seen_firstcommand_from circular" -a "(__fish_complete_suffix .js .ts .jsx .tsx .mjs .cjs)" -d "JavaScript/TypeScript file"

# # For unused firstcommand - enable file completion for JavaScript files
# complete -c js -n "__fish_seen_firstcommand_from unused" -a "(__fish_complete_suffix .js .ts .jsx .tsx .mjs .cjs)" -d "JavaScript/TypeScript file"

# Add common madge options for all firstcommands
complete -c js -n "__fish_seen_firstcommand_from deps circular unused" -l format -a "amd commonjs es6" -d "Module format"
complete -c js -n "__fish_seen_firstcommand_from deps circular unused" -l config -d "Path to config file"
complete -c js -n "__fish_seen_firstcommand_from deps circular unused" -l exclude -d "Exclude modules"
complete -c js -n "__fish_seen_firstcommand_from deps circular unused" -l json -d "Output as JSON"
complete -c js -n "__fish_seen_firstcommand_from deps circular unused" -l image -d "Write image to path"
complete -c js -n "__fish_seen_firstcommand_from deps circular unused" -l dot -d "Show graph in DOT format"
