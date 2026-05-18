function deepseek-code --wraps claude
    set -lx ANTHROPIC_BASE_URL "https://api.deepseek.com/anthropic"
    set -lx ANTHROPIC_AUTH_TOKEN "$DEEPSEEK_API_KEY"
    set -lx ANTHROPIC_MODEL "deepseek-v4-pro[1m]"
    set -lx ANTHROPIC_DEFAULT_OPUS_MODEL "deepseek-v4-pro[1m]"
    set -lx ANTHROPIC_DEFAULT_SONNET_MODEL deepseek-v4-flash
    set -lx ANTHROPIC_DEFAULT_HAIKU_MODEL deepseek-v4-flash
    set -lx CLAUDE_CODE_SUBAGENT_MODEL deepseek-v4-flash
    set -lx CLAUDE_CODE_EFFORT_LEVEL max
    claude $argv
end

function kimi-code --wraps claude
    set -lx ANTHROPIC_BASE_URL "https://api.kimi.com/coding/"
    set -lx ANTHROPIC_AUTH_TOKEN "$MOONSHOT_API_KEY"
    set -lx ANTHROPIC_MODEL kimi-for-coding
    set -lx ANTHROPIC_DEFAULT_OPUS_MODEL kimi-for-coding
    set -lx ANTHROPIC_DEFAULT_SONNET_MODEL kimi-for-coding
    set -lx ANTHROPIC_DEFAULT_HAIKU_MODEL kimi-for-coding
    set -lx CLAUDE_CODE_SUBAGENT_MODEL kimi-for-coding
    set -lx CLAUDE_CODE_EFFORT_LEVEL max
    claude $argv
end
