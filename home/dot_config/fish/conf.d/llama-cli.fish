# Helper function to complete .gguf files
function __llama_complete_gguf_files
    __fish_complete_suffix .gguf
end

function __llama_complete_model
    find ~/.ai -name "*.gguf" 2>/dev/null | head -20
    __llama_complete_gguf_files
end

# Helper function to complete .gbnf files
function __llama_complete_gbnf_files
    __fish_complete_suffix .gbnf
end

# Helper function to complete .jinja files
function __llama_complete_jinja_files
    __fish_complete_suffix .jinja
end

# Define all llama commands
set -l llama_commands \
    llama-batched \
    llama-batched-bench \
    llama-bench \
    llama-cli \
    llama-completion \
    llama-convert-llama2c-to-ggml \
    llama-cvector-generator \
    llama-embedding \
    llama-eval-callback \
    llama-export-lora \
    llama-gen-docs \
    llama-gguf \
    llama-gguf-hash \
    llama-gguf-split \
    llama-gritlm \
    llama-imatrix \
    llama-infill \
    llama-llava-clip-quantize-cli \
    llama-lookahead \
    llama-lookup \
    llama-lookup-create \
    llama-lookup-merge \
    llama-lookup-stats \
    llama-mtmd-cli \
    llama-parallel \
    llama-passkey \
    llama-perplexity \
    llama-q8dot \
    llama-quantize \
    llama-qwen2vl-cli \
    llama-retrieval \
    llama-save-load-state \
    llama-server \
    llama-simple \
    llama-simple-chat \
    llama-speculative \
    llama-speculative-simple \
    llama-tokenize \
    llama-tts \
    llama-vdot

# File-based completions
for cmd in $llama_commands
    complete -c $cmd -l model -s m -r -F -a '(__llama_complete_model)' -d 'Model file path'
    complete -c $cmd -l grammar-file -r -F -a '(__llama_complete_gbnf_files)' -d 'Grammar file path'
    complete -c $cmd -l chat-template-file -r -F -a '(__llama_complete_jinja_files)' -d 'Chat template file path'
end

# General options (no arguments)
for cmd in $llama_commands
    complete -c $cmd -s h -l help -d 'Show help message'
    complete -c $cmd -l usage -d 'Show usage information'
    complete -c $cmd -l version -d 'Show version'
    complete -c $cmd -l license -d 'Show license'
    complete -c $cmd -l cache-list -s cl -d 'List cache'
    complete -c $cmd -l completion-bash -d 'Generate bash completion'
    complete -c $cmd -l verbose-prompt -d 'Verbose prompt'
    complete -c $cmd -l swa-full -d 'Sliding window attention full'
    complete -c $cmd -l flash-attn -s fa -d 'Flash attention'
    complete -c $cmd -l perf -d 'Performance metrics'
    complete -c $cmd -l escape -s e -d 'Escape special characters'
    complete -c $cmd -l no-host -d 'No host'
    complete -c $cmd -l repack -d Repack
    complete -c $cmd -l mlock -d 'Use mlock'
    complete -c $cmd -l mmap -d 'Use mmap'
    complete -c $cmd -l direct-io -s dio -d 'Direct I/O'
    complete -c $cmd -l numa -d 'NUMA support'
    complete -c $cmd -l list-devices -d 'List devices'
    complete -c $cmd -l fit -s fit -d 'Fit model'
    complete -c $cmd -l check-tensors -d 'Check tensors'
    complete -c $cmd -l log-disable -d 'Disable logging'
    complete -c $cmd -l log-colors -d 'Colored logs'
    complete -c $cmd -l verbose -s v -d 'Verbose output'
    complete -c $cmd -l log-verbose -d 'Verbose logging'
    complete -c $cmd -l offline -d 'Offline mode'
    complete -c $cmd -l log-prefix -d 'Log prefix'
    complete -c $cmd -l log-timestamps -d 'Log timestamps'
    complete -c $cmd -l ignore-eos -d 'Ignore end-of-sequence'
    complete -c $cmd -l backend-sampling -s bs -d 'Backend sampling'
    complete -c $cmd -l display-prompt -d 'Display prompt'
    complete -c $cmd -l color -s co -d 'Colored output'
    complete -c $cmd -l context-shift -d 'Context shift'
    complete -c $cmd -l print-token-count -s ptc -d 'Print token count'
    complete -c $cmd -l prompt-cache -d 'Prompt cache'
    complete -c $cmd -l prompt-cache-all -d 'Cache all prompts'
    complete -c $cmd -l prompt-cache-ro -d 'Read-only prompt cache'
    complete -c $cmd -l special -s sp -d 'Special tokens'
    complete -c $cmd -l conversation -s cnv -d 'Conversation mode'
    complete -c $cmd -l single-turn -s st -d 'Single turn'
    complete -c $cmd -l interactive -s i -d 'Interactive mode'
    complete -c $cmd -l interactive-first -s if -d 'Interactive first'
    complete -c $cmd -l multiline-input -s mli -d 'Multiline input'
    complete -c $cmd -l in-prefix-bos -d 'Input prefix BOS'
    complete -c $cmd -l warmup -d Warmup
    complete -c $cmd -l jinja -d 'Jinja templates'
    complete -c $cmd -l simple-io -d 'Simple I/O'
end

# Options with required arguments
for cmd in $llama_commands
    complete -c $cmd -l threads -s t -r -d 'Number of threads'
    complete -c $cmd -l threads-batch -s tb -r -d 'Batch threads'
    complete -c $cmd -l cpu-mask -s C -r -d 'CPU mask'
    complete -c $cmd -l cpu-range -s Cr -r -d 'CPU range'
    complete -c $cmd -l cpu-strict -r -d 'CPU strict'
    complete -c $cmd -l prio -r -d Priority
    complete -c $cmd -l poll -r -d 'Poll interval'
    complete -c $cmd -l cpu-mask-batch -s Cb -r -d 'Batch CPU mask'
    complete -c $cmd -l cpu-range-batch -s Crb -r -d 'Batch CPU range'
    complete -c $cmd -l cpu-strict-batch -r -d 'Batch CPU strict'
    complete -c $cmd -l prio-batch -r -d 'Batch priority'
    complete -c $cmd -l poll-batch -r -d 'Batch poll interval'
    complete -c $cmd -l ctx-size -s c -r -d 'Context size'
    complete -c $cmd -l predict -s n -r -d 'Predict tokens'
    complete -c $cmd -l n-predict -r -d 'Number of tokens to predict'
    complete -c $cmd -l batch-size -s b -r -d 'Batch size'
    complete -c $cmd -l ubatch-size -s ub -r -d 'Micro batch size'
    complete -c $cmd -l keep -r -d 'Keep tokens'
    complete -c $cmd -l prompt -s p -r -d 'Prompt text'
    complete -c $cmd -l file -s f -r -F -d 'Input file'
    complete -c $cmd -l binary-file -s bf -r -F -d 'Binary input file'
    complete -c $cmd -l rope-scaling -r -d 'RoPE scaling'
    complete -c $cmd -l rope-scale -r -d 'RoPE scale factor'
    complete -c $cmd -l rope-freq-base -r -d 'RoPE frequency base'
    complete -c $cmd -l rope-freq-scale -r -d 'RoPE frequency scale'
    complete -c $cmd -l yarn-orig-ctx -r -d 'YaRN original context'
    complete -c $cmd -l yarn-ext-factor -r -d 'YaRN extension factor'
    complete -c $cmd -l yarn-attn-factor -r -d 'YaRN attention factor'
    complete -c $cmd -l yarn-beta-slow -r -d 'YaRN beta slow'
    complete -c $cmd -l yarn-beta-fast -r -d 'YaRN beta fast'
    complete -c $cmd -l kv-offload -s kvo -r -d 'KV cache offload'
    complete -c $cmd -l cache-type-k -s ctk -r -d 'Cache type K'
    complete -c $cmd -l cache-type-v -s ctv -r -d 'Cache type V'
    complete -c $cmd -l defrag-thold -s dt -r -d 'Defrag threshold'
    complete -c $cmd -l parallel -s np -r -d 'Parallel sequences'
    complete -c $cmd -l rpc -r -d 'RPC server'
    complete -c $cmd -l device -s dev -r -d Device
    complete -c $cmd -l override-tensor -s ot -r -d 'Override tensor'
    complete -c $cmd -l cpu-moe -s cmoe -r -d 'CPU MoE'
    complete -c $cmd -l n-cpu-moe -s ncmoe -r -d 'Number of CPU MoE'
    complete -c $cmd -l gpu-layers -s ngl -r -d 'GPU layers'
    complete -c $cmd -l n-gpu-layers -r -d 'Number of GPU layers'
    complete -c $cmd -l split-mode -s sm -r -d 'Split mode'
    complete -c $cmd -l tensor-split -s ts -r -d 'Tensor split'
    complete -c $cmd -l main-gpu -s mg -r -d 'Main GPU'
    complete -c $cmd -l fit-target -s fitt -r -d 'Fit target'
    complete -c $cmd -l fit-ctx -s fitc -r -d 'Fit context'
    complete -c $cmd -l override-kv -r -d 'Override KV'
    complete -c $cmd -l op-offload -r -d 'Operation offload'
    complete -c $cmd -l lora -r -F -d 'LoRA adapter'
    complete -c $cmd -l lora-scaled -r -d 'Scaled LoRA adapter'
    complete -c $cmd -l control-vector -r -F -d 'Control vector'
    complete -c $cmd -l control-vector-scaled -r -d 'Scaled control vector'
    complete -c $cmd -l control-vector-layer-range -r -d 'Control vector layer range'
    complete -c $cmd -l model-url -s mu -r -d 'Model URL'
    complete -c $cmd -l docker-repo -s dr -r -d 'Docker repository'
    complete -c $cmd -l hf-repo -s hf -s hfr -r -d 'HuggingFace repository'
    complete -c $cmd -l hf-repo-draft -s hfd -s hfrd -r -d 'HuggingFace draft repository'
    complete -c $cmd -l hf-file -s hff -r -d 'HuggingFace file'
    complete -c $cmd -l hf-repo-v -s hfv -s hfrv -r -d 'HuggingFace repository version'
    complete -c $cmd -l hf-file-v -s hffv -r -d 'HuggingFace file version'
    complete -c $cmd -l hf-token -s hft -r -d 'HuggingFace token'
    complete -c $cmd -l log-file -r -F -d 'Log file'
    complete -c $cmd -l verbosity -s lv -r -d 'Verbosity level'
    complete -c $cmd -l log-verbosity -r -d 'Log verbosity level'
    complete -c $cmd -l cache-type-k-draft -s ctkd -r -d 'Draft cache type K'
    complete -c $cmd -l cache-type-v-draft -s ctvd -r -d 'Draft cache type V'
    complete -c $cmd -l samplers -r -d Samplers
    complete -c $cmd -l seed -s s -r -d 'Random seed'
    complete -c $cmd -l sampler-seq -r -d 'Sampler sequence'
    complete -c $cmd -l sampling-seq -r -d 'Sampling sequence'
    complete -c $cmd -l temp -r -d Temperature
    complete -c $cmd -l top-k -r -d 'Top-K sampling'
    complete -c $cmd -l top-p -r -d 'Top-P sampling'
    complete -c $cmd -l min-p -r -d 'Min-P sampling'
    complete -c $cmd -l top-nsigma -r -d 'Top-N sigma'
    complete -c $cmd -l xtc-probability -r -d 'XTC probability'
    complete -c $cmd -l xtc-threshold -r -d 'XTC threshold'
    complete -c $cmd -l typical -r -d 'Typical sampling'
    complete -c $cmd -l repeat-last-n -r -d 'Repeat last N tokens'
    complete -c $cmd -l repeat-penalty -r -d 'Repeat penalty'
    complete -c $cmd -l presence-penalty -r -d 'Presence penalty'
    complete -c $cmd -l frequency-penalty -r -d 'Frequency penalty'
    complete -c $cmd -l dry-multiplier -r -d 'DRY multiplier'
    complete -c $cmd -l dry-base -r -d 'DRY base'
    complete -c $cmd -l dry-allowed-length -r -d 'DRY allowed length'
    complete -c $cmd -l dry-penalty-last-n -r -d 'DRY penalty last N'
    complete -c $cmd -l dry-sequence-breaker -r -d 'DRY sequence breaker'
    complete -c $cmd -l adaptive-target -r -d 'Adaptive target'
    complete -c $cmd -l adaptive-decay -r -d 'Adaptive decay'
    complete -c $cmd -l dynatemp-range -r -d 'Dynamic temperature range'
    complete -c $cmd -l dynatemp-exp -r -d 'Dynamic temperature exponent'
    complete -c $cmd -l mirostat -r -d 'Mirostat sampling'
    complete -c $cmd -l mirostat-lr -r -d 'Mirostat learning rate'
    complete -c $cmd -l mirostat-ent -r -d 'Mirostat target entropy'
    complete -c $cmd -l logit-bias -s l -r -d 'Logit bias'
    complete -c $cmd -l grammar -r -d 'Grammar string'
    complete -c $cmd -l json-schema -s j -r -d 'JSON schema'
    complete -c $cmd -l json-schema-file -s jf -r -F -d 'JSON schema file'
    complete -c $cmd -l system-prompt -s sys -r -d 'System prompt'
    complete -c $cmd -l system-prompt-file -s sysf -r -F -d 'System prompt file'
    complete -c $cmd -l reverse-prompt -s r -r -d 'Reverse prompt'
    complete -c $cmd -l in-prefix -r -d 'Input prefix'
    complete -c $cmd -l in-suffix -r -d 'Input suffix'
    complete -c $cmd -l grp-attn-n -s gan -r -d 'Group attention N'
    complete -c $cmd -l grp-attn-w -s gaw -r -d 'Group attention W'
    complete -c $cmd -l reasoning-format -r -d 'Reasoning format'
    complete -c $cmd -l reasoning-budget -r -d 'Reasoning budget'
    complete -c $cmd -l chat-template -r -d 'Chat template'
end
