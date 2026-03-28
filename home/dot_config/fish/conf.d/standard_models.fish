# Standard models
# A list of 'standard' models that are the currently model to use.
#
# Usage:
#
# ```
# for entry in $STANDARD_MODELS
#   set --local parts (string split '|' $entry)
#
#   set --local model $parts[1]
#   set --local aliases (string split ',' $parts[2])
#   set --local name $parts[3]
# end
# ```
set -gx STANDARD_MODELS \
    "openrouter:moonshotai/kimi-k2.5|kimi|Kimi K2.5" \
    "openrouter:google/gemini-3-pro-preview|gemini,google|Gemini 3.0 Pro" \
    "openrouter:openai/gpt-5.2-codex|gpt,codex|GPT-5.2 Codex" \
    "openrouter:anthropic/claude-sonnet-4.6|claude,sonnet|Claude Sonnet 4.6" \
    "openrouter:anthropic/claude-opus-4.6|opus|Claude Opus 4.6"

# Set individual environment variables (`$STANDARD_MODEL_KIMI`, `$STANDARD_MODEL_GEMINI`, `$STANDARD_MODEL_CLAUDE`, etc.)
#
# Example: 
for entry in $STANDARD_MODELS
    set --local parts (string split '|' $entry)

    set --local model $parts[1]
    set --local aliases (string split ',' $parts[2])
    set --local name $parts[3]

    # Create an environment variable for each alias
    for alias in $aliases
        # Convert alias to uppercase for environment variable name
        # e.g. kimi -> STANDARD_MODEL_KIMI, gpt -> STANDARD_MODEL_GPT, etc.
        set --local env_variable (string upper "STANDARD_MODEL_$alias")

        # Set the environment variable globally and export it
        set -gx $env_variable $model
    end
end

# An autocomplete function returning the standard models, then aichat's.
#
# See the QQ (??m, ???m) function for usages.
#   
# Example:
#
# ```
# echo (__dot_complete_standard_models) // 'kimi|Kimi K2 Thinking\n...[rest of the standard models]...[aichat models]'
# ```
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
        set -l aliases (string split ',' $parts[2])
        set -l name $parts[3]

        # Split the comma-separated aliases and output each one
        for alias in $aliases
            echo -e "$alias\t$model"
        end
    end

    # Use models from aichat's models-override.yaml
    # See 'aichat --sync-models'
    if test -f $model_yaml
        yq -r '.list[] | .provider as $provider | .models[] | $provider + ":" + .name' $model_yaml
    end
end

# Get a standard model ID, return as-is if not found.
#
# Example:
#
# ```
# echo (__standard_model kimi) // 'moonshotai/kimi-k2-thinking'
# echo (__standard_model gpt) // 'openai/gpt-5.2-codex'
# echo (__standard_model as-is) // 'as-is'
# echo (__standard_model) // empty
# ```
function __standard_model
    set -l model_arg $argv[1]
    set -l model
    set -l found_arg_in_dict false

    # Try to find the model from the dictionary by any of its aliases
    for entry in $STANDARD_MODELS
        set -l parts (string split "|" $entry)
        set -l model_id $parts[1]
        set -l aliases (string split ',' $parts[2])
        set -l name $parts[3]

        # Check if the argument matches any of the aliases
        for alias in $aliases
            if test "$model_arg" = "$alias"
                set model $model_id
                set found_arg_in_dict true
                break
            end
        end

        # Break outer loop if found
        if $found_arg_in_dict
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
