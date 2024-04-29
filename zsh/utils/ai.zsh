# Aliases for my own sgpt scripts.
alias "?"="sgpt-shell"
alias "??clip"="sgpt-clip"
alias "??"="sgpt-explain"

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
