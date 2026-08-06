function sw --wraps "wt switch"
    # If no arguments are provided, print a usage hint and return an error.
    if test (count $argv) -eq 0
        echo "Usage: sw [options...] <branch-name>" >&2
        return 1
    end

    # Extract the target branch name from the last argument.
    set --local target $argv[-1]

    # Get the current branch name.
    set --local current_branch (git branch --show-current 2>/dev/null)
    if test $status -ne 0
        echo "Error: not inside a git repository" >&2
        return 1
    end

    # Check whether the target branch exists locally.
    git show-ref --verify --quiet "refs/heads/$target"
    set --local branch_exists $status

    # Build the final command: all arguments except the last one are flags.
    set --local flags $argv[1..-2]

    if test $branch_exists -eq 0
        # Branch exists → plain switch.
        wt switch $flags $target
    else
        # Branch doesn't exist → create from current branch.
        wt switch --create --base "$current_branch" --clobber $flags $target
    end
end
