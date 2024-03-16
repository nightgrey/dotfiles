# Note: Needs to be a function for completions to apply, see completions folder.

llama() {
    ~/AI/llama.cpp/main "$@"
}

llama-server() {
    ~/AI/llama.cpp/server "$@"
}

alias comfy="~/AI/ComfyUI/venv/bin/python main.py --force-fp16"
alias comfyui=comfy
