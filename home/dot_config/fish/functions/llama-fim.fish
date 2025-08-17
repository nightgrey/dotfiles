# Function to start llama-server with settings for FIM
function llama-fim --wraps llama-server --description 'Start llama-server with FIM-optimized settings'
    llama-server -ngl 99 -ub 1024 -b 1024 --ctx-size 0 --cache-reuse 256 -np 2 --port 8000 $argv
end
