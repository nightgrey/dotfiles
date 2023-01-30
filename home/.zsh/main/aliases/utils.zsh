# Search
alias findFile="find ./ -type f -name"
alias findDir="find ./ -type d -name"

# Show docker's total RAM usage
function docker-ram {
    docker stats --no-stream --format 'table {{.MemUsage}}' | sed 's/[A-Za-z]*//g' | awk '{sum += $1} END {print sum "MB"}'
}

# Reload the shell (i.e. invoke as a login shell)
function reload {
    exec $SHELL -l
}

# Shows key codes for the pressed keys.
alias keys="sed -n l"
