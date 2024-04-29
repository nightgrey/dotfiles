export PATH="${0:A:h}:$PATH"

for folder in "${0:A:h}"/*; do
    if [ -d $folder ]; then
        chmod +x $folder/* >/dev/null 2>&1
        export PATH="$folder:$PATH"
    fi
done