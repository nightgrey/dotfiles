# Common environment variables
set -gx BROWSER firefox
set -gx EDITOR (command -v micro || command -v nano)
set -gx VISUAL (test -n "$VISUAL" && echo $VISUAL || command -v micro || command -v nano)
set -gx PAGER (test -n "$PAGER" && echo $PAGER || command -v bat || command -v less)

if test "$PAGER" = (command -v bat)
    set -gx PAGER "bat --style=numbers,changes --paging=always"

    set -gx LESSOPEN "| bat --color=always --style=plain %s"
    set -gx LESS -R # Allow colors in less
end

set -gx LAUNCH_EDITOR (test -n "$LAUNCH_EDITOR" && echo $LAUNCH_EDITOR || echo $EDITOR)

# XDG 
set -gx XDG_CONFIG_HOME (test -n "$XDG_CONFIG_HOME" && echo $XDG_CONFIG_HOME || echo ~/.config)
set -gx XDG_CACHE_HOME (test -n "$XDG_CACHE_HOME" && echo $XDG_CACHE_HOME || echo ~/.cache)
set -gx XDG_DATA_HOME (test -n "$XDG_DATA_HOME" && echo $XDG_DATA_HOME || echo ~/.local/share)
set -gx XDG_STATE_HOME (test -n "$XDG_STATE_HOME" && echo $XDG_STATE_HOME || echo ~/.local/state)

# Font rendering
# https://github.com/maximilionus/lucidglyph
set -gx FREETYPE_PROPERTIES "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0"
set -gx QT_NO_SYNTHESIZED_BOLD 1
