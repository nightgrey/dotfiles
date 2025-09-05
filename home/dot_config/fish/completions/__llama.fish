function __lama_complete_devices
    command llama-cli --list-devices 2>/dev/null | grep -A 999 "Available devices:" | grep -v "Available devices:" | sed 's/  //' | sed 's/:.*(.*free)//'
end

function __lama_complete_models
    find ~/.ai -name "*.gguf" -o -name "*.bin" 2>/dev/null | head -20
    __fish_complete_path
end
