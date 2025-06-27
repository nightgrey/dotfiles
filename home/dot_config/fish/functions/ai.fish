# # Translate natural language to CLI command
function ? --wraps aichat --description 'Translate natural language to CLI command'
    set query (string join ' ' $argv)
    if test -z "$query"
        echo "Usage: ? <query>" >&2
        return 1
    end

    aichat -e "$query"
end 


# alias ask 'aichat -e'


# # # Ask for (code / shell, but also general) help
# # alias '??' 'aichat -r help'

# # # Automatically send the clipboard content(s) with ask for help. Optionally, pass a prompt.
# # alias '???' 'qqq'

# # function qqq
# #     set raw (xclip -selection clipboard -out | tr -d '\r')
# #     set clip (echo "$raw" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
# #     set query $argv[1]

# #     if test -z "$clip"
# #         echo "Clipboard is empty." >&2
# #         return 1
# #     end

# #     if test (string length -- "$clip") -lt 2
# #         echo "Clipboard ('$clip') is too short." >&2
# #         return 1
# #     end

# #     set block "```\n$clip\n```"

# #     echo -e "Request:\n\e[1;37m$block\e[0m\e\n\n[1;31m$query\e[0m"

# #     aichat -r help "$block\n\n$query"
# # end
