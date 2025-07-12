# Returns relative path to the root of the git repository (or false) by checking the
# current directory and its parents.
#
# Note: Faster than `git rev-parse --show-toplevel` or `git rev-parse
# --is-inside-work-tree` or `git branch` by roughly ~50%.
function git-dir
    set -l d (test -n "$argv[1]"; and echo $argv[1]; or pwd)
    set -l depth (test -n "$argv[2]"; and echo $argv[2]; or echo 8)
    set -l current_depth 0

    if test -d "$d/.git"
        echo "$d"
        return 0
    else
        set d (dirname "$d")

        while test "$d" != "/" -a "$d" != "$HOME" -a $current_depth -lt $depth
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

# Variables
set -g __PREV_GIT_DIR
set -g --path __PREV_DIRS

# Registers $PATH and named directories in git repositories ($__LB_DIRS) with PWD change.
function set_local_path --on-variable PWD
    # Set git dir path, if inside a git repository
    # If not inside a git repository, $GIT_DIR will be empty
    set -l GIT_DIR (git-dir)

    # Check if we are inside the same git repository as before
    # If we are, we don't need to do anything
    if test -n "$GIT_DIR"; and test -n "$__PREV_GIT_DIR"; and test "$GIT_DIR" = "$__PREV_GIT_DIR"
        return
    end

    set -l --path ALL_DIRS "bin .bin node_modules/.bin .venv/bin"
    set -l DIRS 
    # Set $DIRS based on available directories in the git repository
    for dir in $ALL_DIRS
        # Check if the directory exists in the git repository
        if test -d "$GIT_DIR/$dir"
            # Add the directory to the list of directories
            set -a DIRS $dir
        end
    end

    # Unset previous local bin directories
    if test -n "$__PREV_DIRS"
        for dir in $__PREV_DIRS
            set PATH (string match -v "$dir" $PATH)
            set CDPATH (string match -v "$dir" $CDPATH)
        end
    end

    # Unset abbreviations (Fish equivalent of named directories)
    abbr --erase root
    abbr --erase bin
    abbr --erase node_modules

    set -e __PREV_GIT_DIR

    if test -z "$GIT_DIR"
        return
    end

    # Set PATH for current git repository
    for current in $DIRS
        set -l LOCAL_DIR_PATH "$GIT_DIR/$current"

        # Add to PATH if not present and directory exists
        if test -d "$LOCAL_DIR_PATH"; and not contains "$LOCAL_DIR_PATH" $PATH
            set -gx PATH "$LOCAL_DIR_PATH" $PATH
            set -gx CDPATH "$LOCAL_DIR_PATH" $CDPATH
        end
    end

    # Set abbreviations
    abbr --add --position anywhere "~root" "$GIT_DIR"
    abbr --add --position anywhere "~bin" "$GIT_DIR/node_modules/.bin"
    abbr --add --position anywhere "~node" "$GIT_DIR/node_modules"


    # complete -c cd -a "~root" -d "Git root directory"
    # complete -c cd -a "~bin" -d "node_modules/.bin"
    # complete -c cd -a "~node" -d "node_modules"

    # Set current root as previous root
    set -g __PREV_GIT_DIR $GIT_DIR

    
end

# Execute once on load
set_local_path