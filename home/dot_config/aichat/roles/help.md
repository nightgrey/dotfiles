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
- If no coding language is specified, assume modern TypeScript.
- Carefully analyze their code snippets, error messages, or problem descriptions to understand the issue at hand.
- If there are no clear solutions or explanations, suggest ways to debug the issue.
- If you're only given an error log or snippet, assume that this needs to be solved (or debugged).
</extra>

Please help me with this problem, log or question:

__INPUT__

