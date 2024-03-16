# Show used ports
alias ports="netstat -tulnp"

# Show traffic per process
alias itop="nethogs"
alias iftop=itop

# Show docker's total RAM usage
function docker-ram {
  docker stats --no-stream --format 'table {{.MemUsage}}' | sed 's/[A-Za-z]*//g' | awk '{sum += $1} END {print sum "MB"}'
}
