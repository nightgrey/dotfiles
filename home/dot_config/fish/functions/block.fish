function block --description 'Wrap input in a code block'
    argparse "l/language=?" -- $argv

    echo "```$_flag_l
$argv
```" | string split0
end
