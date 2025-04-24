export PATH="${0:A:h}:$PATH"

for folder in "${0:A:h}"/*; do
    if [ -d $folder ]; then
        export PATH="$folder:$PATH"
    fi
done