# Standard models
# A list of 'standard' models that are the currently model to jour.
#
# Used by scripts and helpers, see `m??` and `m?` for examples.

set -gx STANDARD_MODEL_KIMI "openrouter:moonshotai/kimi-k2-thinking"
set -gx STANDARD_MODEL_GEMINI "openrouter:google/gemini-3-pro-preview"
set -gx STANDARD_MODEL_GPT "openrouter:openai/gpt-5.1-codex"
set -gx STANDARD_MODEL_GPT_MINI "openrouter:openai/gpt-5.1-codex-mini"
set -gx STANDARD_MODEL_CLAUDE "openrouter:anthropic/claude-sonnet-4.5"

# Models
# 
# Example:
#
# ```
# for entry in $STANDARD_MODELS
#     set parts (string split "|" $entry)
#     set -l model $parts[1]
#     set -l alias $parts[2] 
#     set -l name $parts[3]
# end
# ```
set -gx STANDARD_MODELS \
    "$STANDARD_MODEL_KIMI|kimi|Kimi K2 Thinking" \
    "$STANDARD_MODEL_GEMINI|gemini|Gemini 3.0 Pro" \
    "$STANDARD_MODEL_GPT|gpt|GPT-5.1 Codex" \
    "$STANDARD_MODEL_GPT_MINI|mini|GPT-5.1 Codex Mini" \
    "$STANDARD_MODEL_CLAUDE|claude|Claude Sonnet 4.5"

# An autocomplete function returning the standard models, then aichat's.
#
# See the QQ (??m, ???m) function for usages.
#   
# Example:
#
# ```
# echo (__dot_complete_standard_models) // 'kimi|Kimi K2 Thinking\n...[rest of the standard models]...[aichat models]'
# ```
function __dot_complete_standard_models
    set --local models
    set --local model_yaml ~/.config/aichat/models-override.yaml
    
    for entry in $STANDARD_MODELS
        set parts (string split "|" $entry)
        set -l model $parts[1]
        set -l alias $parts[2]
        set -l name $parts[3]

        echo -e "$alias\t$model"
    end

    # Use models from aichat's models-override.yaml
    # See 'aichat --sync-models'
    if test -f $model_yaml
       yq -r '.list[] | .provider as $provider | .models[] | $provider + ":" + .name' $model_yaml
    end 
end

# Get a standard model ID, return as-is or empty if no argument.
#
# Example:
#
# ```
# echo (__standard_model kimi) // 'moonshotai/kimi-k2-thinking'
# echo (__standard_model gpt) // 'openai/gpt-5.1-codex'
# echo (__standard_model as-is) // 'as-is'
# echo (__standard_model) // empty
# ```
function __standard_model
    set -l model_arg $argv[1]
    set -l model
    set -l found_arg_in_dict false

    # Try to find the model from the dictionary by alias
    for entry in $STANDARD_MODELS
        set -l parts (string split "|" $entry)
        set -l model_id $parts[1]
        set -l alias $parts[2]
        set -l name $parts[3]

        if test "$model_arg" = "$alias"
            set model $model_id
            set found_arg_in_dict true
            break
        end
    end

    # If not found in dictionary, use the provided value as-is (arbitrary model)
    # or return empty.
    if not $found_arg_in_dict
        if test -z "$model_arg"
            return 1
        else
            # Use given model
            set model $model_arg
        end
    end

    echo $model
end