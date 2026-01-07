function mode -d "Switch scheduler mode"
    set -l current (scxctl get 2>/dev/null)
    
    switch $argv[1]
        case g game gamer gaming
            if string match -q "*Lavd*Gaming*" $current
                echo "🎮 Gaming mode already enabled"
            else
                sudo scxctl switch --sched lavd --mode gaming &>/dev/null
                and echo "🎮 Gaming mode enabled"
            end
        case d dev devel development
            if string match -q "*Bpfland*Auto*" $current
                echo "⌨️  Dev mode already enabled"
            else
                sudo scxctl switch --sched bpfland --mode auto &>/dev/null
                and echo "⌨️  Dev mode enabled"
            end
        case ''
            if string match -q "*Lavd*Gaming*" $current
                echo "🎮 Gaming"
            else if string match -q "*Bpfland*Auto*" $current
                echo "⌨️  Dev"
            else
                # Unknown/custom config, show raw
                echo $current
            end
        case '*'
            echo "Usage: mode [gaming|dev]"
            return 1
    end
end