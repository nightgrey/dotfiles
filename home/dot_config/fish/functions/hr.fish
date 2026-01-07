function hr --description 'Draws a horizontal rule'
    argparse n/newline -- $argv

    if test -n "$_flag_newline"
        echo -n (string repeat --count (tput cols) '─')
    else 
        echo (string repeat --count (tput cols) '─')
    end
end

complete --command hr --no-files
complete --command hr --short n --long newline --description 'Do not output a newline' --exclusive