function stirb --wraps pkill -d "Kill the given process"
    command pkill -KILL $argv
end
