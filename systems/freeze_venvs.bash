#!/bin/bash

source ~/.virtualenvs/virtualenvwrapper/bin/virtualenvwrapper.sh

cd "$WORKON_HOME"

OUTPUT_DIR=~/.files/systems/"$(hostname)"/virtualenvs
mkdir -p "$OUTPUT_DIR"

for f in *; do
    if [[ -d $f ]]; then
        echo "$f"
        workon "$f"
        pip freeze > "$OUTPUT_DIR"/"$f".txt
        deactivate
    fi
done
