source ~/.config/fish/completions/__llama.fish

complete -c llama-server --wraps llama-cli

complete -c llama-server -s a -l alias -d "Set alias for model name" -x
complete -c llama-server -l host -d "IP address to listen" -x
complete -c llama-server -l port -d "Port to listen" -x
complete -c llama-server -l path -d "Path to serve static files" -x
complete -c llama-server -l api-prefix -d "API prefix path" -x
complete -c llama-server -l no-webui -d "Disable Web UI"
complete -c llama-server -l embedding -l embeddings -d "Embedding use case only"
complete -c llama-server -l reranking -l rerank -d "Enable reranking endpoint"
complete -c llama-server -l api-key -d "API key for authentication" -x
complete -c llama-server -l api-key-file -d "File containing API keys" -F
complete -c llama-server -l ssl-key-file -d "SSL private key file" -F
complete -c llama-server -l ssl-cert-file -d "SSL certificate file" -F
complete -c llama-server -l chat-template-kwargs -d "Additional template parser params" -x
complete -c llama-server -l timeout -d "Server read/write timeout" -x
complete -c llama-server -l threads-http -d "Threads for HTTP requests" -x
complete -c llama-server -l cache-reuse -d "Min chunk size for cache reuse" -x
complete -c llama-server -l metrics -d "Enable metrics endpoint"
complete -c llama-server -l slots -d "Enable slots monitoring"
complete -c llama-server -l props -d "Enable properties endpoint"
complete -c llama-server -l no-slots -d "Disable slots monitoring"
complete -c llama-server -l slot-save-path -d "Path to save slot KV cache" -x
complete -c llama-server -l jinja -d "Use jinja template for chat"
complete -c llama-server -l reasoning-format -d "Thought tags format" -x -a "none deepseek auto"
complete -c llama-server -l reasoning-budget -d "Thinking budget" -x

