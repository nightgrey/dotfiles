function history
    if test (count $argv) -gt 0
        builtin history $argv
    else
        builtin history --show-time='%F %T '
    end
end
