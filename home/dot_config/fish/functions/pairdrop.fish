# ~/.config/fish/functions/pairdrop.fish
# Sends files via PairDrop - integrates with KIO share menu

function __pairdrop_notify --argument-names title message
    notify-send --app-name="PairDrop" --icon=network-wireless "$title" "$message"
end

function __pairdrop_copy_to_clipboard --argument-names content
    if set --query WAYLAND_DISPLAY
        command --query wl-copy; or begin
            __pairdrop_notify "Error" "wl-clipboard required: sudo pacman -S wl-clipboard"
            return 1
        end
        echo -n "$content" | wl-copy
    else
        command --query xclip; or begin
            __pairdrop_notify "Error" "xclip required: sudo pacman -S xclip"
            return 1
        end
        echo -n "$content" | xclip -selection clipboard
    end
end

function __pairdrop_safe_filename --argument-names input_name
    set --local result (string replace --all ' ' '_' -- "$input_name" \
        | string replace --regex '^\.+' '' \
        | string replace --regex '\.[^.]*$' '' \
        | string replace --regex --all '[^a-zA-Z0-9_]' '')
    
    # Fallback if everything was stripped
    if test -z "$result"
        echo "archive"
    else
        echo "$result"
    end
end

function __pairdrop_create_archive --argument-names output_path
    set --local working_dir (pwd)
    set --local files
    set --local dirs
    set --local dir_names
    set --local dir_parents

    for item in $argv[2..]
        test -e "$item"; or begin
            __pairdrop_notify "Error" "Path does not exist: $item"
            return 1
        end

        set --local abs (realpath "$item")
        set --local base (basename "$abs")
        set --local parent (dirname "$abs")

        if test -d "$abs"
            set --append dirs "$abs"
            set --append dir_names "$base"
            set --append dir_parents "$parent"
        else
            set --append files "$abs"
        end
    end

    set --local file_count (count $files)
    set --local dir_count (count $dirs)
    __pairdrop_notify "PairDrop" "Preparing $file_count file(s), $dir_count director(y/ies)..."

    # Files: junk paths (-j), no compression (-0)
    if test $file_count -gt 0
        zip -q -j -0 "$output_path" $files; or begin
            __pairdrop_notify "Error" "Failed to create archive"
            return 1
        end
    end

    # Directories: preserve structure, update existing (-u)
    for i in (seq $dir_count)
        cd "$dir_parents[$i]"
        
        # Use -u (update) only if archive exists, otherwise create
        if test -f "$output_path"
            zip -q -0 -u -r "$output_path" "$dir_names[$i]"
        else
            zip -q -0 -r "$output_path" "$dir_names[$i]"
        end
        
        or begin
            cd "$working_dir"
            __pairdrop_notify "Error" "Failed to add directory: $dir_names[$i]"
            return 1
        end
        
        cd "$working_dir"
    end

    return 0
end

function pairdrop --description "Send files via PairDrop"
    test (count $argv) -gt 0; or begin
        echo "Usage: pairdrop <file|directory>..."
        return 1
    end

    set --local domain "https://pairdrop.net"
    set --local max_inline_size 1000
    set --local tmp_dir "/tmp/pairdrop"

    test -d "$tmp_dir"; or mkdir -p "$tmp_dir"

    set --local safe_name (__pairdrop_safe_filename (basename "$argv[1]"))
    set --local zip_path "$tmp_dir/$safe_name.zip"
    set --local wrapper_path "$tmp_dir/$safe_name__.zip"

    # Needs wrapper if multiple items or directory (so receiver gets .zip)
    set --local needs_wrapper false
    test (count $argv) -gt 1; and set needs_wrapper true
    test -d "$argv[1]"; and set needs_wrapper true

    rm -f "$zip_path" "$wrapper_path"

    __pairdrop_create_archive "$zip_path" $argv; or return 1

    if test "$needs_wrapper" = true
        __pairdrop_notify "PairDrop" "Bundling as ZIP..."
        pushd (dirname "$zip_path")
        zip -q -0 "$wrapper_path" (basename "$zip_path"); or begin
            popd
            __pairdrop_notify "Error" "Failed to create wrapper archive"
            return 1
        end
        popd
        rm -f "$zip_path"
        set zip_path "$wrapper_path"
    end

    set --local encoded (base64 --wrap=0 "$zip_path")
    rm -f "$zip_path"

    # Inline hash or clipboard depending on size
    set --local url
    if test (string length "$encoded") -gt $max_inline_size
        __pairdrop_copy_to_clipboard "$encoded"; or return 1
        set url "$domain?base64zip=paste"
    else
        set url "$domain?base64zip=hash#$encoded"
    end

    __pairdrop_notify "PairDrop" "Opening $domain"
    xdg-open "$url" &>/dev/null &
    disown 
end 

# ~/.config/fish/completions/pairdrop.fish

complete -c pairdrop -f -d "Send files via PairDrop"
complete -c pairdrop -F -d "File or directory to send"