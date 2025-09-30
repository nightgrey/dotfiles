# llm.fish – Fish completions for the `llm` CLI
# https://llm.datasette.io/

# Disable file completions for most sub-commands that don’t need them
complete -c llm -f

# Top-level 
complete -c llm -n "__fish_use_subcommand" -s h -l help   -d "Show help"
complete -c llm -n "__fish_use_subcommand" -l version      -d "Show version"
complete -c llm -n "__fish_use_subcommand" -a prompt       -d "Execute a prompt"
complete -c llm -n "__fish_use_subcommand" -a chat         -d "Hold an ongoing chat"
complete -c llm -n "__fish_use_subcommand" -a keys         -d "Manage stored API keys"
complete -c llm -n "__fish_use_subcommand" -a logs         -d "Explore logged prompts/responses"
complete -c llm -n "__fish_use_subcommand" -a models       -d "Manage available models"
complete -c llm -n "__fish_use_subcommand" -a templates    -d "Manage prompt templates"
complete -c llm -n "__fish_use_subcommand" -a schemas      -d "Manage stored JSON schemas"
complete -c llm -n "__fish_use_subcommand" -a tools        -d "Manage LLM tools"
complete -c llm -n "__fish_use_subcommand" -a aliases      -d "Manage model aliases"
complete -c llm -n "__fish_use_subcommand" -a fragments    -d "Manage reusable text fragments"
complete -c llm -n "__fish_use_subcommand" -a plugins      -d "List installed plugins"
complete -c llm -n "__fish_use_subcommand" -a install      -d "Install PyPI packages into LLM env"
complete -c llm -n "__fish_use_subcommand" -a uninstall    -d "Uninstall packages from LLM env"
complete -c llm -n "__fish_use_subcommand" -a embed        -d "Embed text"
complete -c llm -n "__fish_use_subcommand" -a embed-multi  -d "Embed many strings at once"
complete -c llm -n "__fish_use_subcommand" -a embed-models -d "Manage embedding models"
complete -c llm -n "__fish_use_subcommand" -a similar      -d "Find similar embeddings"
complete -c llm -n "__fish_use_subcommand" -a collections  -d "Manage embedding collections"
complete -c llm -n "__fish_use_subcommand" -a openai       -d "OpenAI-specific commands"

# --------------------------------------------------
# llm prompt
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from prompt" -s s -l system           -d "System prompt"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s m -l model            -d "Model to use" -a "(llm models list --no-stream 2>/dev/null | string match -r '^\S+')"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s d -l database         -d "Log database path" -F
complete -c llm -n "__fish_seen_subcommand_from prompt" -s q -l query            -d "Query string to pick model"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s a -l attachment       -d "Attachment file/URL" -F
complete -c llm -n "__fish_seen_subcommand_from prompt" -l at                    -d "Attachment with explicit mime-type"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s T -l tool             -d "Tool name to expose"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l functions             -d "Python file/code defining tools" -F
complete -c llm -n "__fish_seen_subcommand_from prompt" -l td -l tools-debug     -d "Show tool execution details"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l ta -l tools-approve   -d "Manually approve every tool call"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l cl -l chain-limit     -d "Max chained tool calls (default 5)"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s o -l option           -d "Model key/value option"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l schema                -d "JSON schema file/ID" -F
complete -c llm -n "__fish_seen_subcommand_from prompt" -l schema-multi          -d "Schema for multiple results" -F
complete -c llm -n "__fish_seen_subcommand_from prompt" -s f -l fragment         -d "Fragment alias/hash/file" -F
complete -c llm -n "__fish_seen_subcommand_from prompt" -l sf -l system-fragment -d "Fragment for system prompt" -F
complete -c llm -n "__fish_seen_subcommand_from prompt" -s t -l template         -d "Prompt template name"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s p -l param            -d "Template parameter"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l no-stream             -d "Do not stream response"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s n -l no-log           -d "Do not log to DB"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l log                   -d "Force logging to DB"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s c -l continue         -d "Continue last conversation"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l cid -l conversation   -d "Continue specific conversation"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l key                   -d "API key to use"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l save                  -d "Save prompt as template"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l async                 -d "Run asynchronously"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s u -l usage            -d "Show token usage"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s x -l extract          -d "Extract first fenced code block"
complete -c llm -n "__fish_seen_subcommand_from prompt" -l xl -l extract-last    -d "Extract last fenced code block"
complete -c llm -n "__fish_seen_subcommand_from prompt" -s h -l help             -d "Show help"

# --------------------------------------------------
# llm chat
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from chat" -s s -l system
complete -c llm -n "__fish_seen_subcommand_from chat" -s m -l model            -a "(llm models list --no-stream 2>/dev/null | string match -r '^\S+')"
complete -c llm -n "__fish_seen_subcommand_from chat" -s c -l continue
complete -c llm -n "__fish_seen_subcommand_from chat" -l cid -l conversation
complete -c llm -n "__fish_seen_subcommand_from chat" -s f -l fragment
complete -c llm -n "__fish_seen_subcommand_from chat" -l sf -l system-fragment
complete -c llm -n "__fish_seen_subcommand_from chat" -s t -l template
complete -c llm -n "__fish_seen_subcommand_from chat" -s p -l param
complete -c llm -n "__fish_seen_subcommand_from chat" -s o -l option
complete -c llm -n "__fish_seen_subcommand_from chat" -s d -l database         -F
complete -c llm -n "__fish_seen_subcommand_from chat" -l no-stream
complete -c llm -n "__fish_seen_subcommand_from chat" -l key
complete -c llm -n "__fish_seen_subcommand_from chat" -s T -l tool
complete -c llm -n "__fish_seen_subcommand_from chat" -l functions             -F
complete -c llm -n "__fish_seen_subcommand_from chat" -l td -l tools-debug
complete -c llm -n "__fish_seen_subcommand_from chat" -l ta -l tools-approve
complete -c llm -n "__fish_seen_subcommand_from chat" -l cl -l chain-limit
complete -c llm -n "__fish_seen_subcommand_from chat" -s h -l help

# --------------------------------------------------
# llm keys
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from keys" -a list
complete -c llm -n "__fish_seen_subcommand_from keys" -a get
complete -c llm -n "__fish_seen_subcommand_from keys" -a set
complete -c llm -n "__fish_seen_subcommand_from keys" -a path

# llm keys get <name>
complete -c llm -n "__fish_seen_subcommand_from keys; and __fish_seen_subcommand_from get" -a "(llm keys list 2>/dev/null)"

# llm keys set <name>
complete -c llm -n "__fish_seen_subcommand_from keys; and __fish_seen_subcommand_from set" -l value -d "Key value (omit to prompt)"

# --------------------------------------------------
# llm logs
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from logs" -a list
complete -c llm -n "__fish_seen_subcommand_from logs" -a status
complete -c llm -n "__fish_seen_subcommand_from logs" -a on
complete -c llm -n "__fish_seen_subcommand_from logs" -a off
complete -c llm -n "__fish_seen_subcommand_from logs" -a path
complete -c llm -n "__fish_seen_subcommand_from logs" -a backup

# llm logs list options
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s n -l count         -d "Number of entries (0=all)"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s d -l database      -F
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s m -l model         -d "Filter by model"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s q -l query         -d "Search string"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s f -l fragment       -d "Filter by fragment"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s T -l tool           -d "Filter by tool"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l tools              -d "Only prompts that used tools"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l schema             -d "Filter by schema"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l schema-multi       -d "Filter by multi-schema"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s l -l latest        -d "Latest matching rows"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l data               -d "Output ND-JSON"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l data-array         -d "Output JSON array"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l data-key           -d "Key to extract from array"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l data-ids           -d "Include IDs in JSON"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s t -l truncate      -d "Truncate long strings"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s s -l short         -d "Short YAML output"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s u -l usage         -d "Include token usage"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s r -l response      -d "Output last response only"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s x -l extract       -d "Extract first fenced code block"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l xl -l extract-last -d "Extract last fenced code block"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s c -l current       -d "Current conversation"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l cid -l conversation -d "Specific conversation ID"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l id-gt               -d "ID greater than"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l id-gte              -d "ID greater-equal"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -l json               -d "Output as JSON"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s e -l expand         -d "Expand fragments"
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from list" -s h -l help           -d "Show help"

# llm logs backup <file>
complete -c llm -n "__fish_seen_subcommand_from logs; and __fish_seen_subcommand_from backup" -r

# --------------------------------------------------
# llm models
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from models" -a list
complete -c llm -n "__fish_seen_subcommand_from models" -a default
complete -c llm -n "__fish_seen_subcommand_from models" -a options

# llm models list
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from list" -l options   -d "Show model options"
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from list" -l async     -d "List async models"
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from list" -l schemas   -d "Models that support schemas"
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from list" -l tools     -d "Models that support tools"
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from list" -s q -l query -d "Search string"
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from list" -s m -l model  -d "Specific model IDs"
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from list" -s h -l help  -d "Show help"

# llm models default [<model>]
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from default" -a "(llm models list --no-stream 2>/dev/null | string match -r '^\S+')"

# llm models options
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from options" -a list
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from options" -a show
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from options" -a set
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from options" -a clear

# llm models options show <model>
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from options; and __fish_seen_subcommand_from show" -a "(llm models list --no-stream 2>/dev/null | string match -r '^\S+')"

# llm models options set <model> <key> <value>
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from options; and __fish_seen_subcommand_from set" -a "(llm models list --no-stream 2>/dev/null | string match -r '^\S+')"

# llm models options clear <model> [key]
complete -c llm -n "__fish_seen_subcommand_from models; and __fish_seen_subcommand_from options; and __fish_seen_subcommand_from clear" -a "(llm models list --no-stream 2>/dev/null | string match -r '^\S+')"

# --------------------------------------------------
# llm templates
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from templates" -a list
complete -c llm -n "__fish_seen_subcommand_from templates" -a show
complete -c llm -n "__fish_seen_subcommand_from templates" -a edit
complete -c llm -n "__fish_seen_subcommand_from templates" -a path
complete -c llm -n "__fish_seen_subcommand_from templates" -a loaders

# llm templates show/edit <name>
complete -c llm -n "__fish_seen_subcommand_from templates; and __fish_seen_subcommand_from show edit" -a "(llm templates list 2>/dev/null)"

# --------------------------------------------------
# llm schemas
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from schemas" -a list
complete -c llm -n "__fish_seen_subcommand_from schemas" -a show
complete -c llm -n "__fish_seen_subcommand_from schemas" -a dsl

# llm schemas show <id>
complete -c llm -n "__fish_seen_subcommand_from schemas; and __fish_seen_subcommand_from show" -a "(llm schemas list 2>/dev/null)"

# llm schemas dsl <input>
complete -c llm -n "__fish_seen_subcommand_from schemas; and __fish_seen_subcommand_from dsl" -l multi -d "Wrap in array"

# --------------------------------------------------
# llm tools
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from tools" -a list

# llm tools list
complete -c llm -n "__fish_seen_subcommand_from tools; and __fish_seen_subcommand_from list" -l json            -d "Output as JSON"
complete -c llm -n "__fish_seen_subcommand_from tools; and __fish_seen_subcommand_from list" -l functions        -F -d "Python file/code defining tools"

# --------------------------------------------------
# llm aliases
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from aliases" -a list
complete -c llm -n "__fish_seen_subcommand_from aliases" -a set
complete -c llm -n "__fish_seen_subcommand_from aliases" -a remove
complete -c llm -n "__fish_seen_subcommand_from aliases" -a path

# llm aliases remove <alias>
complete -c llm -n "__fish_seen_subcommand_from aliases; and __fish_seen_subcommand_from remove" -a "(llm aliases list 2>/dev/null)"

# llm aliases set <alias> [model]
complete -c llm -n "__fish_seen_subcommand_from aliases; and __fish_seen_subcommand_from set" -s q -l query -d "Query strings to pick model"

# --------------------------------------------------
# llm fragments
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from fragments" -a list
complete -c llm -n "__fish_seen_subcommand_from fragments" -a show
complete -c llm -n "__fish_seen_subcommand_from fragments" -a set
complete -c llm -n "__fish_seen_subcommand_from fragments" -a remove
complete -c llm -n "__fish_seen_subcommand_from fragments" -a loaders

# llm fragments show <alias/hash>
complete -c llm -n "__fish_seen_subcommand_from fragments; and __fish_seen_subcommand_from show" -a "(llm fragments list 2>/dev/null)"

# llm fragments remove <alias>
complete -c llm -n "__fish_seen_subcommand_from fragments; and __fish_seen_subcommand_from remove" -a "(llm fragments list --aliases 2>/dev/null)"

# llm fragments set <alias> <path/url/hash/->
complete -c llm -n "__fish_seen_subcommand_from fragments; and __fish_seen_subcommand_from set" -r

# --------------------------------------------------
# llm embed
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from embed" -s i -l input        -F -d "File to embed"
complete -c llm -n "__fish_seen_subcommand_from embed" -s m -l model        -d "Embedding model" -a "(llm embed-models list 2>/dev/null)"
complete -c llm -n "__fish_seen_subcommand_from embed" -l store             -d "Store text in DB"
complete -c llm -n "__fish_seen_subcommand_from embed" -s d -l database     -F
complete -c llm -n "__fish_seen_subcommand_from embed" -s c -l content      -d "Text to embed"
complete -c llm -n "__fish_seen_subcommand_from embed" -l binary            -d "Treat input as binary"
complete -c llm -n "__fish_seen_subcommand_from embed" -l metadata          -d "JSON metadata"
complete -c llm -n "__fish_seen_subcommand_from embed" -s f -l format       -d "Output format" -a "json blob base64 hex"

# --------------------------------------------------
# llm embed-multi
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -r                # collection name
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l format         -a "json csv tsv nl"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l files          -d "Directory glob pair"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l encoding       -d "Encodings to try"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l binary         -d "Treat files as binary"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l sql            -d "SQL query for input"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l attach         -d "Extra DB to attach"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l batch-size     -d "Embedding batch size"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l prefix         -d "ID prefix"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -s m -l model     -a "(llm embed-models list 2>/dev/null)"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l prepend        -d "String to prepend"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -l store          -d "Store text in DB"
complete -c llm -n "__fish_seen_subcommand_from embed-multi" -s d -l database  -F

# --------------------------------------------------
# llm similar
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from similar" -s i -l input        -F
complete -c llm -n "__fish_seen_subcommand_from similar" -s c -l content      -d "Content to compare"
complete -c llm -n "__fish_seen_subcommand_from similar" -l binary            -d "Treat input as binary"
complete -c llm -n "__fish_seen_subcommand_from similar" -s n -l number       -d "Number of results"
complete -c llm -n "__fish_seen_subcommand_from similar" -s p -l plain        -d "Plain text output"
complete -c llm -n "__fish_seen_subcommand_from similar" -s d -l database     -F
complete -c llm -n "__fish_seen_subcommand_from similar" -l prefix            -d "ID prefix filter"

# --------------------------------------------------
# llm embed-models
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from embed-models" -a list
complete -c llm -n "__fish_seen_subcommand_from embed-models" -a default

# llm embed-models default [<model>]
complete -c llm -n "__fish_seen_subcommand_from embed-models; and __fish_seen_subcommand_from default" -a "(llm embed-models list 2>/dev/null)"
complete -c llm -n "__fish_seen_subcommand_from embed-models; and __fish_seen_subcommand_from default" -l remove-default -d "Reset default"

# --------------------------------------------------
# llm collections
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from collections" -a list
complete -c llm -n "__fish_seen_subcommand_from collections" -a delete
complete -c llm -n "__fish_seen_subcommand_from collections" -a path

# llm collections delete <collection>
complete -c llm -n "__fish_seen_subcommand_from collections; and __fish_seen_subcommand_from delete" -a "(llm collections list 2>/dev/null)"

# --------------------------------------------------
# llm openai
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from openai" -a models

# llm openai models
complete -c llm -n "__fish_seen_subcommand_from openai; and __fish_seen_subcommand_from models" -l json -d "Output as JSON"
complete -c llm -n "__fish_seen_subcommand_from openai; and __fish_seen_subcommand_from models" -l key  -d "API key"

# --------------------------------------------------
# llm install / uninstall
# --------------------------------------------------
complete -c llm -n "__fish_seen_subcommand_from install"   -s U -l upgrade           -d "Upgrade to latest"
complete -c llm -n "__fish_seen_subcommand_from install"   -s e -l editable        -d "Editable install"
complete -c llm -n "__fish_seen_subcommand_from install"   -l force-reinstall      -d "Force reinstall"
complete -c llm -n "__fish_seen_subcommand_from install"   -l no-cache-dir         -d "Disable cache"
complete -c llm -n "__fish_seen_subcommand_from install"   -l pre                  -d "Include pre-releases"

complete -c llm -n "__fish_seen_subcommand_from uninstall" -s y -l yes             -d "Do not ask for confirmation"