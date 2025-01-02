#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory_path> <search_string> <replacement_string>"
    exit 1
fi

DIRECTORY=$1
SEARCH=$2
REPLACE=$3

if [[ "$DIRECTORY" != /* ]]; then
    DIRECTORY="$(pwd)/$DIRECTORY"
fi

if [ ! -d "$DIRECTORY" ]; then
    echo "Error: El directorio $DIRECTORY no existe."
    exit 1
fi

SEARCH=$(printf '%s\n' "$SEARCH" | sed 's/[&/\]/\\&/g')
REPLACE=$(printf '%s\n' "$REPLACE" | sed 's/[&/\]/\\&/g')

find "$DIRECTORY" -type f -exec file {} \; | grep -i text | cut -d: -f1 | while read file; do
    sed -i.bak "s|$SEARCH|$REPLACE|g" "$file"
done

find "$DIRECTORY" -type f -name "*.bak" -delete

echo "Replacement successful."
