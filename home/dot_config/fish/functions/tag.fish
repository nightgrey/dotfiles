function tag --description 'Wrap input in a HTML/XML tag'
    argparse -n "tag" --min-args 2 -- $argv

    set -l tag $argv[1]
    set -l content (string collect $argv[2..-1])

    if test -z "$content"
        return
    end
 
    echo "<$tag>"
    echo $content
    echo "</$tag>"
end
     