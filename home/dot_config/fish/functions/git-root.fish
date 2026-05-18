# Returns relative path to the root of the git repository (or false) by checking the
# current directory and its parents.
#
# Note: Faster than `git rev-parse --show-toplevel` or `git rev-parse
# --is-inside-work-tree` or `git branch` by roughly ~50%.
function git-root
    set -l d (test -n "$argv[1]"; and echo $argv[1]; or pwd)
    set -l depth (test -n "$argv[2]"; and echo $argv[2]; or echo 8)
    set -l current_depth 0

    if test -d "$d/.git"
        echo "$d"
        return 0
    else
        set d (dirname "$d")

        while test "$d" != / -a "$d" != "$HOME" -a $current_depth -lt $depth
            if test -d "$d/.git"
                echo "$d"
                return 0
            end

            set d (dirname "$d")
            set current_depth (math $current_depth + 1)
        end
    end

    return 1
end
