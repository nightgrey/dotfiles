function ??m --description "Use '??' with a specific model"
    set -l model (__standard_model $argv[1])
    set -l query (string collect $argv[2..])

    if test -z "$model" || test -z "$query"
        echo "Usage: m?? <model> [<query>]" >&2
    else 
        echo "Using $model ..."
        aichat --model $model -r help "$message"
    end
end

complete --command ??m \
    --no-files \
    --keep-order \
    --arguments '(__dot_complete_standard_models)'
