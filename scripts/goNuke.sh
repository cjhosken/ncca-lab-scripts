#!/bin/bash

unset QT_PLUGIN_PATH
unset CUDA_CACHE_MAXSIZE

# Custom OCIO Config path 
OCIO_CONFIG=""

# Check command-line arguments for render engine flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        --ocio)
            shift
            if [[ -n "$1" && ! "$1" =~ ^-- ]]; then
                OCIO_CONFIG="$1"
                shift
            else
                echo "Error: --ocio requires a config file path"
                exit 1
            fi
            ;;
        *)
            FILE="$FILE $1"
            shift
            ;;
    esac
done

if [[ -n "$OCIO_CONFIG" ]]; then
    echo "OCIO Config Path (--ocio): $OCIO_CONFIG"
    export OCIO=$OCIO_CONFIG
fi

export NUKE_DISK_CACHE=/transfer/nuke-cache.$USERNAME
export NUKE_TEMP_DIR=/transfer/nuke.$USERNAME
export NUKE_DISK_CACHE_GB=5
export NUKE_PATH=/public/bapublic/jhardin/tools/nuke/plugins:$NUKE_PATH

# Foundry licensing
export foundry_LICENSE=4101@beijing.bournemouth.ac.uk

# KeenTools licensing (broken)
# export KEENTOOLS_LICENSE_SERVER=7096@beijing.bournemouth.ac.uk
# export KEENTOOLS_LICENSE_SERVER=beijing:7096

echo "Starting Nuke - this can take a few seconds..."
echo

/opt/Nuke14.1v4/Nuke14.1 --nukex $@ &