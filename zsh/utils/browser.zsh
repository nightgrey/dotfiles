function browse() {
    local URL="$1"

    if [[ -z $1 ]]; then
        echo "Usage: $0 <url>"
        return 1
    fi
 
    if [[ ! $URL =~ ^(http|https):// ]]; then
        if [[ $URL == *localhost* ]]; then
            echo "Assuming http ..."
            URL="http://${URL}"
        else
            echo "Assuming https ..."
            URL="http://${URL}"
        fi
    fi

    $BROWSER "$URL"
}

alias to=browse
alias go=browse

alias google=google-chrome-stable
alias browser=$BROWSER