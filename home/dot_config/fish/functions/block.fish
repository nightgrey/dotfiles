function block --description 'Wrap input in a code block'
    argparse "l/language=?" -- $argv

    set -l lang $flag_l
    set -l code (string collect $argv)

    if test -z "$code"
        return
    end
 
    echo "```$lang"
    echo $code
    echo "```"
end
     