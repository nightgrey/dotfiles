function tag --description 'Wrap input in a HTML/XML tag'
    argparse -n "tag" --min-args 2 -- $argv

    set -l tag_name "$argv[1]"
    set -l content (string collect "$argv[2..-1]")

    printf '<%s>\n%s\n</%s>' "$tag_name" "$content" "$tag_name"
end