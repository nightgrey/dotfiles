function local-code --wraps claude
    set -lx ANTHROPIC_BASE_URL "http://127.0.0.1:8080"
    set -lx ANTHROPIC_MODEL local
    set -lx ANTHROPIC_DEFAULT_OPUS_MODEL local
    set -lx ANTHROPIC_DEFAULT_SONNET_MODEL local
    set -lx ANTHROPIC_DEFAULT_HAIKU_MODEL local
    set -lx CLAUDE_CODE_SUBAGENT_MODEL local
    set -lx CLAUDE_CODE_EFFORT_LEVEL max
    claude $argv
end
,
m
