function reload -d "Reload fish config"
    echo "Sourcing config.fish..."
    source ~/.config/fish/config.fish
    echo "Sourcing conf.d/*"
    source ~/.config/fish/conf.d/*
    echo "Sourcing functions/*"
    source ~/.config/fish/functions/*
end

function czr -d "Re-apply chezmoi and reload fish config"
    echo "Applying chezmoi..."
    cza
    reload
end

alias r=reload
