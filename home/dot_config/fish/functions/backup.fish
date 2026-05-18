function backup --argument path --description "Backup a file or directory"
    if test -d $path
        cp -r $path $path.bak
    else
        cp $path $path.bak
    end
end
