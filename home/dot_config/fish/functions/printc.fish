function printc --description 'Prints a colored message to the terminal'
    set -l color $argv[0]
    set -l message (string join ' ' $argv[2..-1])

    set_color $color
    echo $message
    set_color normal
end
