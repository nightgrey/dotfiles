#!/usr/bin/env fish
#
# klein — wrapper for running FLUX.2 [klein] 4B on this rig (RTX 4090, CUDA).
#
# Modes:
#   klein gen   [opts] [-- extra sd-cli args]     one-shot / batch generation (sd-cli)
#   klein serve [opts] [-- extra sd-server args]  resident model, many prompts (sd-server)
#   klein help                                    this help
#
# Everything fits in 24 GB, so the model + LLM + VAE all live on cuda0 with
# diffusion flash-attention on. Config vars below are overridable from the env.

# ---- config (override via env, e.g. `set -x KLEIN_STEPS 6`) -----------------
set -q KLEIN_DIFFUSION; or set -g KLEIN_DIFFUSION $HOME/.ai/black-forest-labs/flux-2-klein-4b-Q8_0.gguf
set -q KLEIN_VAE; or set -g KLEIN_VAE $HOME/.ai/black-forest-labs/full_encoder_small_decoder.safetensors
set -q KLEIN_LLM; or set -g KLEIN_LLM $HOME/.ai/qwen/Qwen3-4B-Instruct-2507-Q8_0.gguf
set -q KLEIN_BACKEND; or set -g KLEIN_BACKEND cuda0

# sampling defaults — tune for klein. STEPS is conservative (looks good even if
# klein is *not* few-step distilled); drop to ~6 once confirmed distilled.
set -q KLEIN_WIDTH; or set -g KLEIN_WIDTH 1024
set -q KLEIN_HEIGHT; or set -g KLEIN_HEIGHT 1024
set -q KLEIN_STEPS; or set -g KLEIN_STEPS 6
set -q KLEIN_CFG; or set -g KLEIN_CFG 1
set -q KLEIN_GUIDANCE; or set -g KLEIN_GUIDANCE 4
set -q KLEIN_SEED; or set -g KLEIN_SEED -1
set -q KLEIN_OUTPUT; or set -g KLEIN_OUTPUT ./output.png

# server defaults
set -q KLEIN_HOST; or set -g KLEIN_HOST 127.0.0.1
set -q KLEIN_PORT; or set -g KLEIN_PORT 1234

# -----------------------------------------------------------------------------

function __klein_usage
    echo "Usage: klein <mode> [options] [-- extra args passed straight to the binary]"
    echo
    echo "Modes:"
    echo "  gen    one-shot / batch image generation (sd-cli, model loaded per run)"
    echo "  serve  start a resident server (sd-server, model stays in VRAM)"
    echo "  help   show this help"
    echo
    echo "Common options (gen + serve):"
    echo "  --cache <mode>   step cache: none|easycache|dbcache|taylorseer|cache-dit|spectrum|ucache (default none)"
    echo "  --no-fa          disable diffusion flash attention (on by default)"
    echo "  -v, --verbose    print the assembled command before running"
    echo "  --dry-run        print the command and exit without running"
    echo
    echo "gen options:"
    echo "  -p, --prompt <str>    prompt (required)"
    echo "  -n, --negative <str>  negative prompt"
    echo "  -o, --output <path>   output path (default $KLEIN_OUTPUT; use output_%03d.png for batches)"
    echo "  -W, --width <int>     (default $KLEIN_WIDTH)"
    echo "  -H, --height <int>    (default $KLEIN_HEIGHT)"
    echo "      --steps <int>     (default $KLEIN_STEPS)"
    echo "      --cfg <float>     cfg-scale (default $KLEIN_CFG)"
    echo "      --guidance <flt>  distilled guidance (default $KLEIN_GUIDANCE)"
    echo "  -b, --batch <int>     batch count (default 1)"
    echo "  -s, --seed <int>      seed, -1 = random (default $KLEIN_SEED)"
    echo
    echo "serve options:"
    echo "      --host <ip>       listen ip  -> sd-server --listen-ip  (default $KLEIN_HOST)"
    echo "      --port <int>      listen port -> sd-server --listen-port (default $KLEIN_PORT)"
    echo "      --no-eager        disable --eager-load (eager on by default for serve)"
end

# base model args shared by both modes
function __klein_base
    echo --diffusion-model $KLEIN_DIFFUSION \
        --vae $KLEIN_VAE \
        --llm $KLEIN_LLM \
        --backend $KLEIN_BACKEND
end

# append `--cache-mode X` unless X is empty/none
function __klein_cache_args --argument-names mode
    test -z "$mode"; and return
    test "$mode" = none; and return
    echo --cache-mode $mode
end

# print (escaped) + optionally run a command array; honors --verbose/--dry-run
function __klein_run
    if set -q _flag_verbose; or set -q _flag_dry_run
        echo "# "(string join ' ' (string escape -- $argv)) >&2
    end
    set -q _flag_dry_run; and return 0
    $argv
end

# --- dispatch ----------------------------------------------------------------
if test (count $argv) -eq 0
    __klein_usage
    exit 0
end
set -l mode $argv[1]
set -e argv[1]

switch $mode
    case gen
        argparse 'p/prompt=' 'n/negative=' 'o/output=' 'W/width=' 'H/height=' \
            'steps=' 'cfg=' 'guidance=' 'b/batch=' 's/seed=' \
            'cache=' no-fa fa v/verbose dry-run h/help -- $argv
        or exit 1
        if set -q _flag_help
            __klein_usage
            exit 0
        end
        if not set -q _flag_prompt
            echo "klein gen: -p/--prompt is required" >&2
            exit 2
        end

        set -l width $KLEIN_WIDTH
        set -q _flag_width; and set width $_flag_width
        set -l height $KLEIN_HEIGHT
        set -q _flag_height; and set height $_flag_height
        set -l steps $KLEIN_STEPS
        set -q _flag_steps; and set steps $_flag_steps
        set -l cfg $KLEIN_CFG
        set -q _flag_cfg; and set cfg $_flag_cfg
        set -l guidance $KLEIN_GUIDANCE
        set -q _flag_guidance; and set guidance $_flag_guidance
        set -l seed $KLEIN_SEED
        set -q _flag_seed; and set seed $_flag_seed
        set -l output $KLEIN_OUTPUT
        set -q _flag_output; and set output $_flag_output
        set -l batch 1
        set -q _flag_batch; and set batch $_flag_batch

        set -l cmd sd-cli (__klein_base)
        set -q _flag_no_fa; or set -a cmd --diffusion-fa
        set -a cmd -W $width -H $height --steps $steps \
            --cfg-scale $cfg --guidance $guidance \
            -b $batch -s $seed -o $output -p $_flag_prompt
        set -q _flag_negative; and set -a cmd -n $_flag_negative
        set -q _flag_cache; and set -a cmd (__klein_cache_args $_flag_cache)
        set -a cmd $argv # passthrough after --

        __klein_run $cmd

    case serve
        argparse 'host=' 'port=' 'cache=' no-fa fa no-eager eager \
            v/verbose dry-run h/help -- $argv
        or exit 1
        if set -q _flag_help
            __klein_usage
            exit 0
        end

        set -l host $KLEIN_HOST
        set -q _flag_host; and set host $_flag_host
        set -l port $KLEIN_PORT
        set -q _flag_port; and set port $_flag_port

        set -l cmd sd-server (__klein_base) --listen-ip $host --listen-port $port
        set -q _flag_no_fa; or set -a cmd --diffusion-fa
        set -q _flag_no_eager; or set -a cmd --eager-load
        set -q _flag_cache; and set -a cmd (__klein_cache_args $_flag_cache)
        set -a cmd $argv # passthrough after --

        __klein_run $cmd

    case help -h --help ''
        __klein_usage
        exit 0
    case '*'
        echo "klein: unknown mode '$mode' (expected: gen, serve, help)" >&2
        exit 2
end
