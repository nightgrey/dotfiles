
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'gitall' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'gitall'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-')) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'gitall' {
            [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'Controls when to use color')
            [CompletionResult]::new('-D', 'D', [CompletionResultType]::ParameterName, 'The directory to start searching under')
            [CompletionResult]::new('--directory', 'directory', [CompletionResultType]::ParameterName, 'The directory to start searching under')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'Descend at most LEVELS of directories below DIR')
            [CompletionResult]::new('--max-depth', 'max-depth', [CompletionResultType]::ParameterName, 'Descend at most LEVELS of directories below DIR')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Filters command to repo(s) matching provided regular expression')
            [CompletionResult]::new('--regex', 'regex', [CompletionResultType]::ParameterName, 'Filters command to repo(s) matching provided regular expression')
            [CompletionResult]::new('-j', 'j', [CompletionResultType]::ParameterName, 'The maximum number of commands to run in parallel')
            [CompletionResult]::new('--threads', 'threads', [CompletionResultType]::ParameterName, 'The maximum number of commands to run in parallel')
            [CompletionResult]::new('-X', 'X', [CompletionResultType]::ParameterName, 'The program to run in each repo')
            [CompletionResult]::new('--executable', 'executable', [CompletionResultType]::ParameterName, 'The program to run in each repo')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Follow symbolic links')
            [CompletionResult]::new('--follow', 'follow', [CompletionResultType]::ParameterName, 'Follow symbolic links')
            [CompletionResult]::new('--full-path', 'full-path', [CompletionResultType]::ParameterName, 'Match REGEX against the full directory path')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
