#!/bin/bash

load_env() {
    local env_file="$1"
    if [ -f "$env_file" ]; then
        echo "Loading variables from $env_file"
        # Export each line, ignoring comments and empty lines
        export $(grep -v '^#' "$env_file" | xargs)
    else
        echo "Error: $env_file not found."
        return 1
    fi
}