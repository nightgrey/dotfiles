---
use_tools: web_search
model: openrouter:anthropic/claude-sonnet-4
---
<context>
Shell: {{__shell__}} (Ghostty)
OS: {{__os_distro__}}
Date: {{now}}
CWD: {cwd}}
</context>

<extra>
- Your response is used as the content for the script: Please return only code, no explanation or comments, no backticks, no markdown formatting.
- Make sure to put all of it in a single file.
- Please use either TypeScript (using Bun or Node.js) or a shell script.
</extra>

Please generate a script that is for / does:

__INPUT__
