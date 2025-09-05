source ~/.config/fish/completions/__llama.fish

complete -c llama-cli --no-files

# Common parameters
complete -c llama-cli -s h -l help -l usage -d "Print usage and exit"
complete -c llama-cli -l version -d "Show version and build info"
complete -c llama-cli -l completion-bash -d "Print source-able bash completion script"
complete -c llama-cli -l verbose-prompt -d "Print verbose prompt before generation"

# Threading and CPU options
complete -c llama-cli -s t -l threads -d "Number of threads for generation" -x
complete -c llama-cli -l threads-batch -d "Number of threads for batch processing" -x
complete -c llama-cli -s C -l cpu-mask -d "CPU affinity mask (hex)" -x
complete -c llama-cli -l cpu-range -d "Range of CPUs for affinity (lo-hi)" -x
complete -c llama-cli -l cpu-strict -d "Use strict CPU placement" -x -a "0 1"
complete -c llama-cli -l prio -d "Process/thread priority" -x -a "-1 0 1 2 3"
complete -c llama-cli -l poll -d "Polling level (0-100)" -x
complete -c llama-cli -l cpu-mask-batch -d "CPU affinity mask for batch (hex)" -x
complete -c llama-cli -l cpu-range-batch -d "CPU ranges for batch affinity" -x
complete -c llama-cli -l cpu-strict-batch -d "Strict CPU placement for batch" -x -a "0 1"
complete -c llama-cli -l prio-batch -d "Process priority for batch" -x -a "0 1 2 3"
complete -c llama-cli -l poll-batch -d "Use polling for batch work" -x -a "0 1"

# Context and prediction options
complete -c llama-cli -s c -l ctx-size -d "Size of prompt context" -x
complete -c llama-cli -s n -l predict -l n-predict -d "Number of tokens to predict" -x
complete -c llama-cli -s b -l batch-size -d "Logical maximum batch size" -x
complete -c llama-cli -l ubatch-size -d "Physical maximum batch size" -x
complete -c llama-cli -l keep -d "Number of tokens to keep from initial prompt" -x
complete -c llama-cli -l swa-full -d "Use full-size SWA cache"
complete -c llama-cli -l kv-unified -d "Use single unified KV buffer"
complete -c llama-cli -s fa -l flash-attn -d "Enable Flash Attention"
complete -c llama-cli -l no-perf -d "Disable internal performance timings"

# Escape sequences
complete -c llama-cli -s e -l escape -d "Process escape sequences"
complete -c llama-cli -l no-escape -d "Do not process escape sequences"

# RoPE options
complete -c llama-cli -l rope-scaling -d "RoPE frequency scaling method" -x -a "none linear yarn"
complete -c llama-cli -l rope-scale -d "RoPE context scaling factor" -x
complete -c llama-cli -l rope-freq-base -d "RoPE base frequency" -x
complete -c llama-cli -l rope-freq-scale -d "RoPE frequency scaling factor" -x
complete -c llama-cli -l yarn-orig-ctx -d "YaRN original context size" -x
complete -c llama-cli -l yarn-ext-factor -d "YaRN extrapolation mix factor" -x
complete -c llama-cli -l yarn-attn-factor -d "YaRN attention magnitude scale" -x
complete -c llama-cli -l yarn-beta-slow -d "YaRN high correction dim" -x
complete -c llama-cli -l yarn-beta-fast -d "YaRN low correction dim" -x

# Memory and caching options
complete -c llama-cli -l no-kv-offload -d "Disable KV offload"
complete -c llama-cli -l no-repack -d "Disable weight repacking"
complete -c llama-cli -l cache-type-k -d "KV cache data type for K" -x -a "f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1"
complete -c llama-cli -l cache-type-v -d "KV cache data type for V" -x -a "f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1"
complete -c llama-cli -l defrag-thold -d "KV cache defragmentation threshold" -x
complete -c llama-cli -l parallel -d "Number of parallel sequences" -x
complete -c llama-cli -l rpc -d "Comma separated list of RPC servers" -x
complete -c llama-cli -l mlock -d "Force system to keep model in RAM"
complete -c llama-cli -l no-mmap -d "Do not memory-map model"
complete -c llama-cli -l numa -d "NUMA optimizations" -x -a "distribute isolate numactl"

# Device and GPU options
complete -c llama-cli -l device -d "Devices for offloading" -x -a "(__lama_complete_devices)"
complete -c llama-cli -l list-devices -d "Print available devices and exit"
complete -c llama-cli -l override-tensor -d "Override tensor buffer type" -x
complete -c llama-cli -l cpu-moe -d "Keep MoE weights in CPU"
complete -c llama-cli -l n-cpu-moe -d "Keep MoE weights of first N layers in CPU" -x
complete -c llama-cli -l gpu-layers -l n-gpu-layers -d "Number of layers in VRAM" -x
complete -c llama-cli -l split-mode -d "How to split model across GPUs" -x -a "none layer row"
complete -c llama-cli -l tensor-split -d "Fraction to offload to each GPU" -x
complete -c llama-cli -l main-gpu -d "GPU index for model/intermediate results" -x
complete -c llama-cli -l check-tensors -d "Check model tensor data for invalid values"
complete -c llama-cli -l override-kv -d "Override model metadata by key" -x
complete -c llama-cli -l no-op-offload -d "Disable offloading host tensor operations"

# Model loading options
complete -c llama-cli -l lora -d "Path to LoRA adapter" -F
complete -c llama-cli -l lora-scaled -d "Path to LoRA adapter with scaling" -F
complete -c llama-cli -l control-vector -d "Add control vector" -F
complete -c llama-cli -l control-vector-scaled -d "Add scaled control vector" -F
complete -c llama-cli -l control-vector-layer-range -d "Layer range for control vector" -x
complete -c llama-cli -l model -d Model -s m -r -k -a "(__lama_complete_models)"
complete -c llama-cli -l model-url -d "Model download URL" -x
complete -c llama-cli -l hf-repo -d "Hugging Face model repository" -x
complete -c llama-cli -l hf-repo-draft -d "HF repo for draft model" -x
complete -c llama-cli -l hf-file -d "Hugging Face model file" -x
complete -c llama-cli -l hf-repo-v -d "HF repo for vocoder model" -x
complete -c llama-cli -l hf-file-v -d "HF file for vocoder model" -x
complete -c llama-cli -l hf-token -d "Hugging Face access token" -x

# Logging options
complete -c llama-cli -l log-disable -d "Disable logging"
complete -c llama-cli -l log-file -d "Log to file" -F
complete -c llama-cli -l log-colors -d "Enable colored logging"
complete -c llama-cli -s v -l verbose -l log-verbose -d "Set verbosity to infinity"
complete -c llama-cli -l offline -d "Offline mode"
complete -c llama-cli -l verbosity -l log-verbosity -d "Set verbosity threshold" -x
complete -c llama-cli -l log-prefix -d "Enable prefix in log messages"
complete -c llama-cli -l log-timestamps -d "Enable timestamps in log messages"

# Draft model cache options
complete -c llama-cli -l cache-type-k-draft -d "KV cache type for K (draft)" -x -a "f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1"
complete -c llama-cli -l cache-type-v-draft -d "KV cache type for V (draft)" -x -a "f32 f16 bf16 q8_0 q4_0 q4_1 iq4_nl q5_0 q5_1"

# Sampling parameters
complete -c llama-cli -l samplers -d "Samplers for generation (semicolon separated)" -x
complete -c llama-cli -s s -l seed -d "RNG seed" -x
complete -c llama-cli -l sampling-seq -l sampler-seq -d "Simplified sampler sequence" -x
complete -c llama-cli -l ignore-eos -d "Ignore end of stream token"
complete -c llama-cli -l temp -d Temperature -x
complete -c llama-cli -l top-k -d "Top-k sampling" -x
complete -c llama-cli -l top-p -d "Top-p sampling" -x
complete -c llama-cli -l min-p -d "Min-p sampling" -x
complete -c llama-cli -l xtc-probability -d "XTC probability" -x
complete -c llama-cli -l xtc-threshold -d "XTC threshold" -x
complete -c llama-cli -l typical -d "Locally typical sampling" -x
complete -c llama-cli -l repeat-last-n -d "Last n tokens for penalize" -x
complete -c llama-cli -l repeat-penalty -d "Repeat sequence penalty" -x
complete -c llama-cli -l presence-penalty -d "Presence penalty" -x
complete -c llama-cli -l frequency-penalty -d "Frequency penalty" -x
complete -c llama-cli -l dry-multiplier -d "DRY sampling multiplier" -x
complete -c llama-cli -l dry-base -d "DRY sampling base value" -x
complete -c llama-cli -l dry-allowed-length -d "DRY allowed length" -x
complete -c llama-cli -l dry-penalty-last-n -d "DRY penalty for last n tokens" -x
complete -c llama-cli -l dry-sequence-breaker -d "DRY sequence breaker" -x
complete -c llama-cli -l dynatemp-range -d "Dynamic temperature range" -x
complete -c llama-cli -l dynatemp-exp -d "Dynamic temperature exponent" -x
complete -c llama-cli -l mirostat -d "Mirostat sampling" -x -a "0 1 2"
complete -c llama-cli -l mirostat-lr -d "Mirostat learning rate" -x
complete -c llama-cli -l mirostat-ent -d "Mirostat target entropy" -x
complete -c llama-cli -s l -l logit-bias -d "Modify token likelihood" -x
complete -c llama-cli -l grammar -d "BNF-like grammar constraint" -x
complete -c llama-cli -l grammar-file -d "Grammar file" -F
complete -c llama-cli -s j -l json-schema -d "JSON schema constraint" -x
complete -c llama-cli -l json-schema-file -d "JSON schema file" -F

# Example-specific parameters
complete -c llama-cli -l no-context-shift -d "Disable context shift"
complete -c llama-cli -s r -l reverse-prompt -d "Halt generation at prompt" -x
complete -c llama-cli -l special -d "Enable special tokens output"
complete -c llama-cli -l no-warmup -d "Skip model warmup"
complete -c llama-cli -l spm-infill -d "Use Suffix/Prefix/Middle pattern"
complete -c llama-cli -l pooling -d "Pooling type for embeddings" -x -a "none mean cls last rank"
complete -c llama-cli -l cont-batching -d "Enable continuous batching"
complete -c llama-cli -l no-cont-batching -d "Disable continuous batching"

# Multimodal options
complete -c llama-cli -l mmproj -d "Multimodal projector file" -F
complete -c llama-cli -l mmproj-url -d "Multimodal projector URL" -x
complete -c llama-cli -l no-mmproj -d "Disable multimodal projector"
complete -c llama-cli -l no-mmproj-offload -d "Don't offload multimodal projector"

# Chat template options
set -l chat_templates "bailing chatglm3 chatglm4 chatml command-r deepseek deepseek2 deepseek3 exaone3 exaone4 falcon3 gemma gigachat glmedge gpt-oss granite hunyuan-dense hunyuan-moe kimi-k2 llama2 llama2-sys llama2-sys-bos llama2-sys-strip llama3 llama4 megrez minicpm mistral-v1 mistral-v3 mistral-v3-tekken mistral-v7 mistral-v7-tekken monarch openchat orion phi3 phi4 rwkv-world smolvlm vicuna vicuna-orca yandex zephyr"

complete -c llama-cli -l chat-template -d "Custom jinja chat template" -x -a "$chat_templates"
complete -c llama-cli -l chat-template-file -d "Chat template file" -F
complete -c llama-cli -l no-prefill-assistant -d "Don't prefill assistant response"
complete -c llama-cli -l slot-prompt-similarity -d "Prompt similarity for slot reuse" -x
complete -c llama-cli -l lora-init-without-apply -d "Load LoRA without applying"

# Speculative decoding options
complete -c llama-cli -l draft-max -l draft -l draft-n -d "Draft tokens for speculative decoding" -x
complete -c llama-cli -l draft-min -l draft-n-min -d "Minimum draft tokens" -x
complete -c llama-cli -l draft-p-min -d "Minimum speculative decoding probability" -x
complete -c llama-cli -l ctx-size-draft -d "Draft model context size" -x
complete -c llama-cli -l device-draft -d "Devices for draft model" -x
complete -c llama-cli -l gpu-layers-draft -l n-gpu-layers-draft -d "GPU layers for draft model" -x
complete -c llama-cli -l model-draft -d "Draft model path" -F
complete -c llama-cli -l spec-replace -d "String translation for draft compatibility" -x

# Audio and other models
complete -c llama-cli -l model-vocoder -d "Vocoder model for audio" -F
complete -c llama-cli -l tts-use-guide-tokens -d "Use guide tokens for TTS"

# Default model options
complete -c llama-cli -l embd-bge-small-en-default -d "Use default bge-small-en-v1.5"
complete -c llama-cli -l embd-e5-small-en-default -d "Use default e5-small-v2"
complete -c llama-cli -l embd-gte-small-default -d "Use default gte-small"
complete -c llama-cli -l fim-qwen-1.5b-default -d "Use default Qwen 2.5 Coder 1.5B"
complete -c llama-cli -l fim-qwen-3b-default -d "Use default Qwen 2.5 Coder 3B"
complete -c llama-cli -l fim-qwen-7b-default -d "Use default Qwen 2.5 Coder 7B"
complete -c llama-cli -l fim-qwen-7b-spec -d "Use Qwen 2.5 Coder 7B + 0.5B draft"
complete -c llama-cli -l fim-qwen-14b-spec -d "Use Qwen 2.5 Coder 14B + 0.5B draft"
