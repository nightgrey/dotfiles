
edit:completion:arg-completer[gitall] = [@words]{
    fn spaces [n]{
        repeat $n ' ' | joins ''
    }
    fn cand [text desc]{
        edit:complex-candidate $text &display-suffix=' '(spaces (- 14 (wcswidth $text)))$desc
    }
    command = 'gitall'
    for word $words[1:-1] {
        if (has-prefix $word '-') {
            break
        }
        command = $command';'$word
    }
    completions = [
        &'gitall'= {
            cand --color 'Controls when to use color'
            cand -D 'The directory to start searching under'
            cand --directory 'The directory to start searching under'
            cand -d 'Descend at most LEVELS of directories below DIR'
            cand --max-depth 'Descend at most LEVELS of directories below DIR'
            cand -r 'Filters command to repo(s) matching provided regular expression'
            cand --regex 'Filters command to repo(s) matching provided regular expression'
            cand -j 'The maximum number of commands to run in parallel'
            cand --threads 'The maximum number of commands to run in parallel'
            cand -X 'The program to run in each repo'
            cand --executable 'The program to run in each repo'
            cand -L 'Follow symbolic links'
            cand --follow 'Follow symbolic links'
            cand --full-path 'Match REGEX against the full directory path'
            cand -h 'Prints help information'
            cand --help 'Prints help information'
            cand -V 'Prints version information'
            cand --version 'Prints version information'
        }
    ]
    $completions[$command]
}
