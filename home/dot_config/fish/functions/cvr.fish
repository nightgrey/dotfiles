function czr -d "Re-apply chezmoi and reload fish config"
    echo "Applying chezmoi..."
    cza
    reload
end
