function debug --argument message
    if test -n "$DEBUG"
        echo $argv
    else
        return 0
    end
end
