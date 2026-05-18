# Fish completions for llama-cli and llama-server (llama.cpp)
# Generated from llama.cpp help output

# --- Helper functions ---

function __llama_complete_gguf_files
    __fish_complete_suffix .gguf
end

function __llama_complete_model
    for dir in ~/.ai ~/.cache/llama.cpp /usr/share/llama
        find $dir -name "*.gguf" 2>/dev/null | head -20
    end
    __llama_complete_gguf_files
end

function __llama_complete_gbnf_files
    __fish_complete_suffix .gbnf
end

function __llama_complete_jinja_files
    __fish_complete_suffix .jinja
end

# --- Shared completions: common params (both llama-cli and llama-server) ---

for cmd in llama-cli llama-server
    # Info / meta (no args)
    complete -c $cmd -s h -l help -d 'Print usage and exit'
    complete -c $cmd -l usage -d 'Print usage and exit'
    complete -c $cmd -l version -d 'Show version and build info'
    complete -c $cmd -l license -d 'Show source code license and dependencies'
    complete -c $cmd -o cl -l cache-list -d 'Show list of models in cache'
    complete -c $cmd -l completion-bash -d 'Print source-able bash completion script'
    complete -c $cmd -l list-devices -d 'Print list of available devices and exit'

    # Threading / CPU
    complete -c $cmd -s t -l threads -r -d 'CPU threads for generation (default: -1)'
    complete -c $cmd -o tb -l threads-batch -r -d 'Threads for batch/prompt processing'
    complete -c $cmd -s C -l cpu-mask -r -d 'CPU affinity mask (hex)'
    complete -c $cmd -o Cr -l cpu-range -r -d 'CPU range for affinity (lo-hi)'
    complete -c $cmd -l cpu-strict -r -a '0 1' -d 'Strict CPU placement (default: 0)'
    complete -c $cmd -l prio -r -a '-1 0 1 2 3' -d 'Process/thread priority (default: 0)'
    complete -c $cmd -l poll -r -d 'Polling level 0-100 (default: 50)'
    complete -c $cmd -o Cb -l cpu-mask-batch -r -d 'Batch CPU affinity mask (hex)'
    complete -c $cmd -o Crb -l cpu-range-batch -r -d 'Batch CPU range for affinity (lo-hi)'
    complete -c $cmd -l cpu-strict-batch -r -a '0 1' -d 'Batch strict CPU placement'
    complete -c $cmd -l prio-batch -r -a '0 1 2 3' -d 'Batch process/thread priority (default: 0)'
    complete -c $cmd -l poll-batch -r -a '0 1' -d 'Batch polling (default: same as --poll)'

    # Context / batching
    complete -c $cmd -s c -l ctx-size -r -d 'Prompt context size (default: 0 = from model)'
    complete -c $cmd -s n -l predict -r -d 'Tokens to predict (default: -1 = infinity)'
    complete -c $cmd -l n-predict -r -d 'Tokens to predict (default: -1 = infinity)'
    complete -c $cmd -s b -l batch-size -r -d 'Logical max batch size (default: 2048)'
    complete -c $cmd -o ub -l ubatch-size -r -d 'Physical max batch size (default: 512)'
    complete -c $cmd -l keep -r -d 'Tokens to keep from initial prompt (default: 0)'

    # Attention / SWA
    complete -c $cmd -l swa-full -d 'Use full-size SWA cache'
    complete -c $cmd -o fa -l flash-attn -r -a 'on off auto' -d 'Flash Attention (default: auto)'

    # Performance
    complete -c $cmd -l perf -d 'Enable internal performance timings'
    complete -c $cmd -l no-perf -d 'Disable internal performance timings'

    # Escape sequences
    complete -c $cmd -s e -l escape -d 'Process escape sequences'
    complete -c $cmd -l no-escape -d 'Do not process escape sequences'

    # RoPE
    complete -c $cmd -l rope-scaling -r -a 'none linear yarn' -d 'RoPE frequency scaling method'
    complete -c $cmd -l rope-scale -r -d 'RoPE context scaling factor'
    complete -c $cmd -l rope-freq-base -r -d 'RoPE base frequency (NTK-aware scaling)'
    complete -c $cmd -l rope-freq-scale -r -d 'RoPE frequency scaling factor'

    # YaRN
    complete -c $cmd -l yarn-orig-ctx -r -d 'YaRN: original context size'
    complete -c $cmd -l yarn-ext-factor -r -d 'YaRN: extrapolation mix factor'
    complete -c $cmd -l yarn-attn-factor -r -d 'YaRN: attention magnitude scale'
    complete -c $cmd -l yarn-beta-slow -r -d 'YaRN: high correction dim (alpha)'
    complete -c $cmd -l yarn-beta-fast -r -d 'YaRN: low correction dim (beta)'

    # KV cache
    complete -c $cmd -o kvo -l kv-offload -d 'Enable KV cache offloading'
    complete -c $cmd -o nkvo -l no-kv-offload -d 'Disable KV cache offloading'
    complete -c $cmd -o ctk -l cache-type-k -r -a 'f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1' -d 'KV cache data type for K (default: f16)'
    complete -c $cmd -o ctv -l cache-type-v -r -a 'f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1' -d 'KV cache data type for V (default: f16)'
    complete -c $cmd -o dt -l defrag-thold -r -d 'KV cache defragmentation threshold (DEPRECATED)'

    # Parallelism
    complete -c $cmd -o np -l parallel -r -d 'Parallel sequences to decode (default: 1)'

    # RPC
    complete -c $cmd -l rpc -r -d 'Comma-separated RPC servers (host:port)'

    # Memory
    complete -c $cmd -l mlock -d 'Force system to keep model in RAM'
    complete -c $cmd -l mmap -d 'Memory-map model (default: enabled)'
    complete -c $cmd -l no-mmap -d 'Disable memory-mapping model'
    complete -c $cmd -l repack -d 'Enable weight repacking (default: enabled)'
    complete -c $cmd -o nr -l no-repack -d 'Disable weight repacking'
    complete -c $cmd -l no-host -d 'Bypass host buffer'
    complete -c $cmd -o dio -l direct-io -d 'Use DirectIO if available'
    complete -c $cmd -o ndio -l no-direct-io -d 'Disable DirectIO'

    # NUMA
    complete -c $cmd -l numa -r -a 'distribute isolate numactl' -d 'NUMA optimization strategy'

    # Devices / GPU
    complete -c $cmd -o dev -l device -r -d 'Devices for offloading (comma-separated)'
    complete -c $cmd -o ot -l override-tensor -r -d 'Override tensor buffer type (pattern=type,...)'
    complete -c $cmd -o cmoe -l cpu-moe -d 'Keep all MoE weights in CPU'
    complete -c $cmd -o ncmoe -l n-cpu-moe -r -d 'Keep first N MoE layers in CPU'
    complete -c $cmd -o ngl -l gpu-layers -r -a 'auto all' -d 'GPU layers (number, auto, or all)'
    complete -c $cmd -l n-gpu-layers -r -a 'auto all' -d 'GPU layers (number, auto, or all)'
    complete -c $cmd -o sm -l split-mode -r -a 'none layer row' -d 'Multi-GPU split mode (default: layer)'
    complete -c $cmd -o ts -l tensor-split -r -d 'GPU offload fractions (e.g. 3,1)'
    complete -c $cmd -o mg -l main-gpu -r -d 'Main GPU index (default: 0)'

    # Fit
    complete -c $cmd -o fit -l fit -r -a 'on off' -d 'Auto-fit to device memory (default: on)'
    complete -c $cmd -o fitt -l fit-target -r -d 'Fit target margin per device in MiB (default: 1024)'
    complete -c $cmd -o fitc -l fit-ctx -r -d 'Min ctx size for --fit (default: 4096)'

    # Tensor checks / overrides
    complete -c $cmd -l check-tensors -d 'Check model tensor data for invalid values'
    complete -c $cmd -l override-kv -r -d 'Override model metadata (KEY=TYPE:VALUE,...)'
    complete -c $cmd -l op-offload -d 'Offload host tensor ops to device (default: true)'
    complete -c $cmd -l no-op-offload -d 'Disable host tensor op offloading'

    # LoRA / control vectors
    complete -c $cmd -l lora -r -F -d 'Path to LoRA adapter (comma-separated for multiple)'
    complete -c $cmd -l lora-scaled -r -d 'LoRA adapter with scaling (FNAME:SCALE,...)'
    complete -c $cmd -l control-vector -r -F -d 'Add a control vector file'
    complete -c $cmd -l control-vector-scaled -r -d 'Control vector with scaling (FNAME:SCALE,...)'
    complete -c $cmd -l control-vector-layer-range -r -d 'Control vector layer range (START END)'

    # Model loading
    complete -c $cmd -s m -l model -r -a '(__llama_complete_model)' -d 'Model path (.gguf)'
    complete -c $cmd -o mu -l model-url -r -d 'Model download URL'
    complete -c $cmd -o dr -l docker-repo -r -d 'Docker Hub model ([repo/]model[:quant])'
    complete -c $cmd -o hf -l hf-repo -r -d 'HuggingFace repo (user/model[:quant])'
    complete -c $cmd -o hfr -r -d 'HuggingFace repo (user/model[:quant])'
    complete -c $cmd -o hfd -l hf-repo-draft -r -d 'HuggingFace draft model repo'
    complete -c $cmd -o hfrd -r -d 'HuggingFace draft model repo'
    complete -c $cmd -o hff -l hf-file -r -d 'HuggingFace model file (overrides quant)'
    complete -c $cmd -o hfv -l hf-repo-v -r -d 'HuggingFace vocoder model repo'
    complete -c $cmd -o hfrv -r -d 'HuggingFace vocoder model repo'
    complete -c $cmd -o hffv -l hf-file-v -r -d 'HuggingFace vocoder model file'
    complete -c $cmd -o hft -l hf-token -r -d 'HuggingFace access token'

    # Logging
    complete -c $cmd -l log-disable -d 'Disable logging'
    complete -c $cmd -l log-file -r -F -d 'Log to file'
    complete -c $cmd -l log-colors -r -a 'on off auto' -d 'Colored logging (default: auto)'
    complete -c $cmd -s v -l verbose -d 'Set verbosity to infinity (debug)'
    complete -c $cmd -l log-verbose -d 'Set verbosity to infinity (debug)'
    complete -c $cmd -l offline -d 'Offline mode: use cache, no network'
    complete -c $cmd -o lv -l verbosity -r -a '0 1 2 3 4' -d 'Verbosity threshold (0=generic..4=debug)'
    complete -c $cmd -l log-verbosity -r -a '0 1 2 3 4' -d 'Verbosity threshold (0=generic..4=debug)'
    complete -c $cmd -l log-prefix -d 'Enable prefix in log messages'
    complete -c $cmd -l log-timestamps -d 'Enable timestamps in log messages'

    # Draft model cache types
    complete -c $cmd -o ctkd -l cache-type-k-draft -r -a 'f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1' -d 'Draft model KV cache type for K'
    complete -c $cmd -o ctvd -l cache-type-v-draft -r -a 'f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1' -d 'Draft model KV cache type for V'

    # --- Sampling params ---
    complete -c $cmd -l samplers -r -d 'Samplers in order (;-separated)'
    complete -c $cmd -s s -l seed -r -d 'RNG seed (default: -1 = random)'
    complete -c $cmd -l sampler-seq -r -d 'Simplified sampler sequence (default: edskypmxt)'
    complete -c $cmd -l sampling-seq -r -d 'Simplified sampler sequence (default: edskypmxt)'
    complete -c $cmd -l ignore-eos -d 'Ignore end-of-stream token'
    complete -c $cmd -l temp -r -d 'Temperature (default: 0.80)'
    complete -c $cmd -l temperature -r -d 'Temperature (default: 0.80)'
    complete -c $cmd -l top-k -r -d 'Top-K sampling (default: 40, 0 = disabled)'
    complete -c $cmd -l top-p -r -d 'Top-P sampling (default: 0.95, 1.0 = disabled)'
    complete -c $cmd -l min-p -r -d 'Min-P sampling (default: 0.05, 0.0 = disabled)'
    complete -c $cmd -l top-nsigma -r -d 'Top-N-sigma sampling (default: -1.0 = disabled)'
    complete -c $cmd -l top-n-sigma -r -d 'Top-N-sigma sampling (default: -1.0 = disabled)'
    complete -c $cmd -l xtc-probability -r -d 'XTC probability (default: 0.0 = disabled)'
    complete -c $cmd -l xtc-threshold -r -d 'XTC threshold (default: 0.10)'
    complete -c $cmd -l typical -r -d 'Locally typical sampling p (default: 1.0 = disabled)'
    complete -c $cmd -l typical-p -r -d 'Locally typical sampling p (default: 1.0 = disabled)'
    complete -c $cmd -l repeat-last-n -r -d 'Last N tokens for penalty (default: 64)'
    complete -c $cmd -l repeat-penalty -r -d 'Repeat penalty (default: 1.0 = disabled)'
    complete -c $cmd -l presence-penalty -r -d 'Presence penalty (default: 0.0 = disabled)'
    complete -c $cmd -l frequency-penalty -r -d 'Frequency penalty (default: 0.0 = disabled)'
    complete -c $cmd -l dry-multiplier -r -d 'DRY sampling multiplier (default: 0.0 = disabled)'
    complete -c $cmd -l dry-base -r -d 'DRY sampling base (default: 1.75)'
    complete -c $cmd -l dry-allowed-length -r -d 'DRY allowed length (default: 2)'
    complete -c $cmd -l dry-penalty-last-n -r -d 'DRY penalty last N tokens (default: -1)'
    complete -c $cmd -l dry-sequence-breaker -r -d 'DRY sequence breaker string'
    complete -c $cmd -l adaptive-target -r -d 'Adaptive-p target probability (default: -1.0 = disabled)'
    complete -c $cmd -l adaptive-decay -r -d 'Adaptive-p decay rate (default: 0.90)'
    complete -c $cmd -l dynatemp-range -r -d 'Dynamic temperature range (default: 0.0 = disabled)'
    complete -c $cmd -l dynatemp-exp -r -d 'Dynamic temperature exponent (default: 1.0)'
    complete -c $cmd -l mirostat -r -a '0 1 2' -d 'Mirostat sampling (0=off, 1=v1, 2=v2)'
    complete -c $cmd -l mirostat-lr -r -d 'Mirostat learning rate eta (default: 0.10)'
    complete -c $cmd -l mirostat-ent -r -d 'Mirostat target entropy tau (default: 5.0)'
    complete -c $cmd -s l -l logit-bias -r -d 'Logit bias (TOKEN_ID(+/-)BIAS)'
    complete -c $cmd -l grammar -r -d 'BNF-like grammar to constrain generation'
    complete -c $cmd -l grammar-file -r -F -a '(__llama_complete_gbnf_files)' -d 'Grammar file (.gbnf)'
    complete -c $cmd -s j -l json-schema -r -d 'JSON schema to constrain generation'
    complete -c $cmd -o jf -l json-schema-file -r -F -d 'JSON schema file'
    complete -c $cmd -o bs -l backend-sampling -d 'Enable backend sampling (experimental)'

    # --- Shared example-specific params ---

    # Checkpoints / cache
    complete -c $cmd -o ctxcp -l ctx-checkpoints -r -d 'Max context checkpoints per slot (default: 32)'
    complete -c $cmd -l swa-checkpoints -r -d 'Max context checkpoints per slot (default: 32)'
    complete -c $cmd -o cpent -l checkpoint-every-n-tokens -r -d 'Checkpoint every N tokens (default: 8192)'
    complete -c $cmd -o cram -l cache-ram -r -d 'Max cache size in MiB (default: 8192)'
    complete -c $cmd -l context-shift -d 'Enable context shift on infinite generation'
    complete -c $cmd -l no-context-shift -d 'Disable context shift'

    # Interaction
    complete -c $cmd -s r -l reverse-prompt -r -d 'Halt generation at PROMPT'
    complete -c $cmd -o sp -l special -d 'Enable special tokens output'
    complete -c $cmd -l warmup -d 'Perform warmup run (default: enabled)'
    complete -c $cmd -l no-warmup -d 'Skip warmup run'

    # Multimodal
    complete -c $cmd -o mm -l mmproj -r -F -d 'Path to multimodal projector file'
    complete -c $cmd -o mmu -l mmproj-url -r -d 'URL to multimodal projector file'
    complete -c $cmd -l mmproj-auto -d 'Auto-use multimodal projector (default: enabled)'
    complete -c $cmd -l no-mmproj -d 'Disable multimodal projector auto-loading'
    complete -c $cmd -l no-mmproj-auto -d 'Disable multimodal projector auto-loading'
    complete -c $cmd -l mmproj-offload -d 'GPU offload multimodal projector (default: enabled)'
    complete -c $cmd -l no-mmproj-offload -d 'Disable GPU offload for multimodal projector'
    complete -c $cmd -l image-min-tokens -r -d 'Min tokens per image (dynamic resolution)'
    complete -c $cmd -l image-max-tokens -r -d 'Max tokens per image (dynamic resolution)'

    # Draft model
    complete -c $cmd -o otd -l override-tensor-draft -r -d 'Override tensor buffer type for draft model'
    complete -c $cmd -o cmoed -l cpu-moe-draft -d 'Keep all draft MoE weights in CPU'
    complete -c $cmd -o ncmoed -l n-cpu-moe-draft -r -d 'Keep first N draft MoE layers in CPU'

    # Chat / template
    complete -c $cmd -l chat-template-kwargs -r -d 'JSON object for template params'
    complete -c $cmd -l jinja -d 'Enable jinja template engine (default: enabled)'
    complete -c $cmd -l no-jinja -d 'Disable jinja template engine'
    complete -c $cmd -l reasoning-format -r -a 'none deepseek deepseek-legacy auto' -d 'Reasoning format (default: auto)'
    complete -c $cmd -o rea -l reasoning -r -a 'on off auto' -d 'Use reasoning/thinking (default: auto)'
    complete -c $cmd -l reasoning-budget -r -d 'Thinking token budget (-1=unlimited, 0=none)'
    complete -c $cmd -l reasoning-budget-message -r -d 'Message when reasoning budget exhausted'
    complete -c $cmd -l chat-template -r -a 'bailing bailing-think bailing2 chatglm3 chatglm4 chatml command-r deepseek deepseek-ocr deepseek2 deepseek3 exaone-moe exaone3 exaone4 falcon3 gemma gigachat glmedge gpt-oss granite grok-2 hunyuan-dense hunyuan-moe kimi-k2 llama2 llama2-sys llama2-sys-bos llama2-sys-strip llama3 llama4 megrez minicpm mistral-v1 mistral-v3 mistral-v3-tekken mistral-v7 mistral-v7-tekken monarch openchat orion pangu-embedded phi3 phi4 rwkv-world seed_oss smolvlm solar-open vicuna vicuna-orca yandex zephyr' -d 'Chat template name or jinja string'
    complete -c $cmd -l chat-template-file -r -F -a '(__llama_complete_jinja_files)' -d 'Chat template file (.jinja)'
    complete -c $cmd -l skip-chat-parsing -d 'Force pure content parser'
    complete -c $cmd -l no-skip-chat-parsing -d 'Use normal chat parsing'

    # Speculative decoding
    complete -c $cmd -l draft -r -d 'Tokens to draft for speculative decoding (default: 16)'
    complete -c $cmd -l draft-n -r -d 'Tokens to draft for speculative decoding (default: 16)'
    complete -c $cmd -l draft-max -r -d 'Tokens to draft for speculative decoding (default: 16)'
    complete -c $cmd -l draft-min -r -d 'Min draft tokens (default: 0)'
    complete -c $cmd -l draft-n-min -r -d 'Min draft tokens (default: 0)'
    complete -c $cmd -l draft-p-min -r -d 'Min speculative decoding probability (default: 0.75)'
    complete -c $cmd -o cd -l ctx-size-draft -r -d 'Draft model context size (default: 0 = from model)'
    complete -c $cmd -o devd -l device-draft -r -d 'Devices for draft model offloading'
    complete -c $cmd -o ngld -l gpu-layers-draft -r -a 'auto all' -d 'Draft model GPU layers (default: auto)'
    complete -c $cmd -l n-gpu-layers-draft -r -a 'auto all' -d 'Draft model GPU layers (default: auto)'
    complete -c $cmd -o md -l model-draft -r -a '(__llama_complete_model)' -d 'Draft model path (.gguf)'
    complete -c $cmd -l spec-replace -r -d 'Translate TARGET string into DRAFT string'

    # Preset models
    complete -c $cmd -l gpt-oss-20b-default -d 'Use gpt-oss-20b (downloads weights)'
    complete -c $cmd -l gpt-oss-120b-default -d 'Use gpt-oss-120b (downloads weights)'
    complete -c $cmd -l vision-gemma-4b-default -d 'Use Gemma 3 4B QAT (downloads weights)'
    complete -c $cmd -l vision-gemma-12b-default -d 'Use Gemma 3 12B QAT (downloads weights)'
end

# --- llama-cli only ---

# Prompt input
complete -c llama-cli -s p -l prompt -r -d 'Prompt to start generation with'
complete -c llama-cli -s f -l file -r -F -d 'File containing the prompt'
complete -c llama-cli -o bf -l binary-file -r -F -d 'Binary file containing the prompt'
complete -c llama-cli -o sys -l system-prompt -r -d 'System prompt'
complete -c llama-cli -o sysf -l system-prompt-file -r -F -d 'System prompt file'

# Display
complete -c llama-cli -l verbose-prompt -d 'Print verbose prompt before generation'
complete -c llama-cli -l display-prompt -d 'Print prompt at generation (default: true)'
complete -c llama-cli -l no-display-prompt -d 'Hide prompt at generation'
complete -c llama-cli -o co -l color -r -a 'on off auto' -d 'Colorize output (default: auto)'
complete -c llama-cli -l show-timings -d 'Show timing info after response (default: true)'
complete -c llama-cli -l no-show-timings -d 'Hide timing info after response'

# Conversation / interaction
complete -c llama-cli -o cnv -l conversation -d 'Conversation mode (default: auto)'
complete -c llama-cli -o no-cnv -l no-conversation -d 'Disable conversation mode'
complete -c llama-cli -o st -l single-turn -d 'Single turn conversation then exit'
complete -c llama-cli -o mli -l multiline-input -d 'Allow multiline input without trailing \\'
complete -c llama-cli -l simple-io -d 'Basic IO for subprocesses/limited consoles'

# Media
complete -c llama-cli -l image -r -F -d 'Image file (comma-separated for multiple)'
complete -c llama-cli -l audio -r -F -d 'Audio file (comma-separated for multiple)'

# --- llama-server only ---

# Network
complete -c llama-server -l host -r -d 'Listen address (default: 127.0.0.1)'
complete -c llama-server -l port -r -d 'Listen port (default: 8080)'
complete -c llama-server -l reuse-port -d 'Allow multiple sockets on same port'

# Paths / API
complete -c llama-server -l path -r -F -d 'Path to serve static files from'
complete -c llama-server -l api-prefix -r -d 'Server path prefix (no trailing slash)'

# WebUI
complete -c llama-server -l webui -d 'Enable Web UI (default: enabled)'
complete -c llama-server -l no-webui -d 'Disable Web UI'
complete -c llama-server -l webui-config -r -d 'JSON for WebUI default settings'
complete -c llama-server -l webui-config-file -r -F -d 'JSON file for WebUI default settings'
complete -c llama-server -l webui-mcp-proxy -d 'Enable MCP CORS proxy (experimental)'
complete -c llama-server -l no-webui-mcp-proxy -d 'Disable MCP CORS proxy'

# Tools
complete -c llama-server -l tools -r -a 'all read_file file_glob_search grep_search exec_shell_command write_file edit_file apply_diff' -d 'Enable built-in tools (experimental)'

# Auth / SSL
complete -c llama-server -l api-key -r -d 'API key(s) for auth (comma-separated)'
complete -c llama-server -l api-key-file -r -F -d 'File containing API keys'
complete -c llama-server -l ssl-key-file -r -F -d 'PEM-encoded SSL private key file'
complete -c llama-server -l ssl-cert-file -r -F -d 'PEM-encoded SSL certificate file'

# Model aliases / tags
complete -c llama-server -s a -l alias -r -d 'Model name aliases (comma-separated)'
complete -c llama-server -l tags -r -d 'Model tags (comma-separated, informational)'

# Server behavior
complete -c llama-server -o to -l timeout -r -d 'Read/write timeout in seconds (default: 600)'
complete -c llama-server -l threads-http -r -d 'Threads for HTTP processing (default: -1)'
complete -c llama-server -l cache-prompt -d 'Enable prompt caching (default: enabled)'
complete -c llama-server -l no-cache-prompt -d 'Disable prompt caching'
complete -c llama-server -l cache-reuse -r -d 'Min chunk size for cache reuse via KV shift'
complete -c llama-server -o sps -l slot-prompt-similarity -r -d 'Prompt-slot similarity threshold (default: 0.10)'
complete -c llama-server -l lora-init-without-apply -d 'Load LoRA without applying (apply via API)'
complete -c llama-server -l sleep-idle-seconds -r -d 'Seconds of idle before server sleeps (-1=off)'

# Endpoints
complete -c llama-server -l metrics -d 'Enable Prometheus metrics endpoint'
complete -c llama-server -l props -d 'Enable POST /props endpoint'
complete -c llama-server -l slots -d 'Expose slot monitoring endpoint (default: enabled)'
complete -c llama-server -l no-slots -d 'Hide slot monitoring endpoint'
complete -c llama-server -l slot-save-path -r -F -d 'Path to save slot KV cache'
complete -c llama-server -l media-path -r -F -d 'Directory for local media files (file:// URLs)'

# Embeddings / reranking
complete -c llama-server -l embedding -d 'Restrict to embedding use case'
complete -c llama-server -l embeddings -d 'Restrict to embedding use case'
complete -c llama-server -l rerank -d 'Enable reranking endpoint'
complete -c llama-server -l reranking -d 'Enable reranking endpoint'
complete -c llama-server -l pooling -r -a 'none mean cls last rank' -d 'Pooling type for embeddings'

# Continuous batching
complete -c llama-server -o cb -l cont-batching -d 'Enable continuous batching (default: enabled)'
complete -c llama-server -o nocb -l no-cont-batching -d 'Disable continuous batching'

# KV unified
complete -c llama-server -o kvu -l kv-unified -d 'Unified KV buffer across sequences'
complete -c llama-server -l no-kv-unified -d 'Disable unified KV buffer'

# Infill
complete -c llama-server -l spm-infill -d 'Use Suffix/Prefix/Middle pattern for infill'

# Lookup cache
complete -c llama-server -o lcs -l lookup-cache-static -r -F -d 'Static lookup cache for lookup decoding'
complete -c llama-server -o lcd -l lookup-cache-dynamic -r -F -d 'Dynamic lookup cache for lookup decoding'

# Router / multi-model
complete -c llama-server -l models-dir -r -F -d 'Directory of models for router server'
complete -c llama-server -l models-preset -r -F -d 'INI file with model presets for router'
complete -c llama-server -l models-max -r -d 'Max simultaneous models for router (default: 4)'
complete -c llama-server -l models-autoload -d 'Auto-load models in router (default: enabled)'
complete -c llama-server -l no-models-autoload -d 'Disable auto-loading models in router'

# Prefill
complete -c llama-server -l prefill-assistant -d 'Prefill assistant response (default: enabled)'
complete -c llama-server -l no-prefill-assistant -d 'Disable assistant response prefill'

# Draft threads (server-specific)
complete -c llama-server -o td -l threads-draft -r -d 'Draft model threads for generation'
complete -c llama-server -o tbd -l threads-batch-draft -r -d 'Draft model threads for batch processing'

# Speculative decoding type (server-specific)
complete -c llama-server -l spec-type -r -a 'none ngram-cache ngram-simple ngram-map-k ngram-map-k4v ngram-mod' -d 'Speculative decoding type (no draft model)'
complete -c llama-server -l spec-ngram-size-n -r -d 'Ngram lookup size N (default: 12)'
complete -c llama-server -l spec-ngram-size-m -r -d 'Ngram draft size M (default: 48)'
complete -c llama-server -l spec-ngram-min-hits -r -d 'Min hits for ngram-map (default: 1)'

# Vocoder / TTS
complete -c llama-server -o mv -l model-vocoder -r -a '(__llama_complete_model)' -d 'Vocoder model for audio generation'
complete -c llama-server -l tts-use-guide-tokens -d 'Use guide tokens for TTS word recall'

# Server preset models
complete -c llama-server -l embd-gemma-default -d 'Use EmbeddingGemma default model'
complete -c llama-server -l fim-qwen-1.5b-default -d 'Use Qwen 2.5 Coder 1.5B'
complete -c llama-server -l fim-qwen-3b-default -d 'Use Qwen 2.5 Coder 3B'
complete -c llama-server -l fim-qwen-7b-default -d 'Use Qwen 2.5 Coder 7B'
complete -c llama-server -l fim-qwen-7b-spec -d 'Use Qwen 2.5 Coder 7B + 0.5B draft'
complete -c llama-server -l fim-qwen-14b-spec -d 'Use Qwen 2.5 Coder 14B + 0.5B draft'
complete -c llama-server -l fim-qwen-30b-default -d 'Use Qwen 3 Coder 30B A3B Instruct'
