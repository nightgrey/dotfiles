# SGPT
alias "?"="aichat -r shell -m claude:claude-3-5-sonnet-20240620 -e"
alias "??clip"="aichat-clip"
alias "??"="aichat -r explain -m claude:claude-3-5-sonnet-20240620"

# SGPT + specific models

# GPT-4o
alias "?4o"="?gpt4o"
alias "?gpt4o"="aichat --model openai:gpt-4o"

# GPT-4o Mini
alias "?4om"="?gpt4o-mini"
alias "?gpt4o-mini"="aichat --model openai:gpt-4o"

# Claude
alias "?opus"="aichat --model claude:claude-3-opus-20240229"
alias "?sonnet"="aichat --model claude:claude-3-5-sonnet-20240620"

# Llama 3.1 405B (Base)
alias "?405b"="?l405b"
alias "?l405b"="aichat --model openrouter:meta-llama/llama-3.1-405b-base"

# Hermes 405B (Instruct)
alias "?h405"="?h405i"
alias "?h405i"="aichat --model openrouter:nousresearch/hermes-3-llama-3.1-405b:extended"

# Llama 3.1 405B (Instruct)
alias "?405"="?l405i"
alias "?l405"="?l405i"
alias "?405i"="?l405i"
alias "?l405i"="aichat --model openrouter:meta-llama/llama-3.1-405b-instruct"

# LLama 3.1 8B (local)
alias "l38"="ollama run llama3.1:8b-instruct-fp16"
alias "llama3"="ollama run llama3.1:8b-instruct-fp16"

# Apps
alias comfyui=comfy

alias stableswarm="docker-compose --project-directory /home/nico/AI/StableSwarmUI up"

function civit() {
  token=$CIVITAI_API_KEY
  url=$1

  if [ -z "$url" ]; then
    echo "No URL provided"
    return 1
  fi

  if [ -z "$token" ]; then
    echo "CIVITAI_API_KEY is not set"
    return 1
  fi

  # Append token as URL parameter
  if [ -z "$url" ]; then
    echo "No URL provided"
    return 1
  fi

  if [ -z "$token" ]; then
    echo "CIVITAI_API_KEY is not set"
    return 1
  fi

  # Append token as URL parameter
  if [[ $url == *'?'* ]]; then
    url="${url}&token=${token}"
  else
    url="${url}?token=${token}"
  fi

  wget --content-disposition $url
}
