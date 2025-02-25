#!/usr/bin/env bash

script_dir=$(cd "$(dirname "$0")" && pwd)

if [ ! -f "$script_dir/.venv/bin/activate" ]; then
    "$script_dir"/setup.sh
fi

source "$script_dir/.venv/bin/activate"

python3 test.py test.vhd
