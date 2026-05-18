source ~/.config/fish/functions/git-root.fish
source ~/.config/fish/functions/debug.fish
# Variables
set -g __PREV_GIT_DIR
set -g --path __PREV_DIRS

# Registers $PATH and named directories in git repositories ($__LB_DIRS) with PWD change.
function set_local_path --on-variable PWD
    if not set -q __PREV_DIRS
        set -g --path __PREV_DIRS
    end

    # Set git dir path, if inside a git repository
    # If not inside a git repository, $GIT_DIR will be empty
    set -l GIT_DIR (git-root)

    # Check if we are inside the same git repository as before
    # If we are, we don't need to do anything
    if test -n "$GIT_DIR"; and test -n "$__PREV_GIT_DIR"; and test "$GIT_DIR" = "$__PREV_GIT_DIR"
        debug "Already in the same git repository, skipping..."
        return
    end

    set -l --path POTENTIAL_DIRS bin .bin node_modules/.bin .venv/bin
    set -l DIRS
    debug "Checking for $POTENTIAL_DIRS..."

    # Set $DIRS based on available directories in the git repository
    for dir in $POTENTIAL_DIRS
        # Check if the directory exists in the git repository
        if test -d "$GIT_DIR/$dir"
            debug "Adding $GIT_DIR/$dir to DIRS..."
            # Add the directory to the list of directories
            set -a DIRS $dir
        end
    end

    # Unset previous local bin directories
    if test -n "$__PREV_DIRS"
        for dir in $__PREV_DIRS
            debug "Removing $dir from PATH..."
            set PATH (string match -v "$dir" $PATH)
            set CDPATH (string match -v "$dir" $CDPATH)
        end
    end

    # Unset abbreviations (Fish equivalent of named directories)
    abbr --erase root 2>/dev/null
    abbr --erase bin 2>/dev/null
    abbr --erase node_modules 2>/dev/null

    set -e __PREV_GIT_DIR

    if test -z "$GIT_DIR"
        return
    end

    # Set PATH for current git repository
    for current in $DIRS
        set -l LOCAL_DIR_PATH "$GIT_DIR/$current"

        # Add to PATH if not present and directory exists
        if test -d "$LOCAL_DIR_PATH"; and not contains "$LOCAL_DIR_PATH" $PATH
            debug "Adding $LOCAL_DIR_PATH to PATH..."
            set -gx PATH "$LOCAL_DIR_PATH" $PATH
            set -gx CDPATH "$LOCAL_DIR_PATH" $CDPATH
            # Save this directory so we can remove it later
            set -ga __PREV_DIRS $LOCAL_DIR_PATH
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
