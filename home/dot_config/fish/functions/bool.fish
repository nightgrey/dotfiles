function bool --argument value --description 'Convert boolean to string'
    set -l value $argv[1]
    if test $value
        echo true
    else
        echo false
    end
end
