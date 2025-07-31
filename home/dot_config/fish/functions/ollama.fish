function ollama --wraps=ollama --description "Ollama CLI"
    set -l bin (command -v ollama)

    # Check if ollama service is running
    if not systemctl --user is-active --quiet ollama.service
        # Start the service
        systemctl --user start ollama.service
    end

    # Pass all arguments to the actual ollama command
    $bin $argv
end
