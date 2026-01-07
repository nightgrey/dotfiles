function mode -d "Switch scheduler mode"
    switch $argv[1]
        case g game gamer gaming
            sudo scxctl switch scx_lavd --profile gaming
            and echo "🎮 Gaming mode"
        case d dev devel development
            sudo scxctl switch scx_bpfland
            and echo "⌨️  Dev mode"
        case ''  
            # Show current scheduler
            scxctl info
        case '*'
            echo "Usage: mode [gaming|dev]"
            return 1
    end
end