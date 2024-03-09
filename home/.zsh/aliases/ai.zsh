# Note: Needs to be a function for completions to work.
llama() {
    ~/AI/llama.cpp/main "$@"
}

alias comfy="~/AI/ComfyUI/venv/bin/python main.py --force-fp16"
alias comfyui=comfy
