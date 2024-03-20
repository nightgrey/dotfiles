# Note: Needs to be a function for completions to apply, see completions folder.

llama() {
    ~/AI/llama.cpp/main "$@"
}

llama-server() {
    ~/AI/llama.cpp/server "$@"
}

alias comfy="~/AI/ComfyUI/venv/bin/python main.py --force-fp16"
alias comfyui=comfy


alias invoke="~/AI/invokeai/start.sh"

# Sync AI models from HDD to local SSD.
sync-ai() {
    from_root="/mnt/hdd/Data/AI"
    to_root="/home/nico/AI/Models"

    dirs=(
        "${from_root}/SDXL/Collections/,${to_root}/SDXL"
        "${from_root}/Others/,${to_root}/Others"
        "${from_root}/SC/,${to_root}/SC"
        # Unused:
        # "${from}/SD15/,${to}/SD15"
    )

    # Format dirs as $from -> $to, $from -> $to, ...
    sync_info=""

    for dir in "${dirs[@]}"; do
        IFS=',' read -r from to <<<"$dir"

        from_size=$(du -Lsm --exclude='**/.git' "$from" | awk '{print $1}')
        to_size=$(du -Lsm --exclude='**/.git' "$to" | awk '{print $1}')
        diff="$((to_size - from_size))"
        diff="${diff#-}"

        # Format sizes
        from_size="${from_size} MB"
        to_size="${to_size} MB"
        diff="${diff} MB"

        sync_info+="[Diff: ${diff}] $from ($from_size) -> $to ($to_size)"

        # Add new line if not last element
        if [[ $dir != "${dirs[-1]}" ]]; then
            sync_info+="\n"
        fi
    done

    sync_info=${sync_info%, }

    echo -e "Syncing directories:\n\n${sync_info}\n"

    confirm() {
        read -rq "? Is that okay? (y/n) "
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            return 0
        else
            return 1
        fi
    }

    if confirm; then
        for dir in "${dirs[@]}"; do
            IFS=',' read -r from to <<<"$dir"

            if [ ! -d "$from" ]; then
                echo "Error: Directory to sync from (""${from}"") does not exist."
                exit 1
            fi

            echo -e "\n\nSyncing $from -> $to...\n"

            rsync --delete -av --copy-unsafe-links --human-readable --exclude='.git/' "$from" "$to"

            sleep 0.5
        done
    fi

}
