#!/usr/bin/env bash

script_dir=$(cd "$(dirname "$0")" && pwd)

# Get `tree-sitter-vhdl`
need_to_get_cli=""
if [ -d "$script_dir/tree-sitter-vhdl/node_modules" ]; then
    directory=$(mktemp --directory)
    echo "Move node_modules to $directory so we don't need to redownload it"
    mv "$script_dir/tree-sitter-vhdl/node_modules" "$directory/."
else
    need_to_get_cli="yes"
fi
rm -rf "$script_dir/tree-sitter-vhdl"
git clone https://github.com/jpt13653903/tree-sitter-vhdl.git --branch v1.2.4 --single-branch --depth 1
if [ -n "$directory" ]; then
    mv "$directory/node_modules" "$script_dir/tree-sitter-vhdl/."
fi

# Regenerate
cd "$script_dir/tree-sitter-vhdl"
if [ -n "$need_to_get_cli" ]; then
    echo "Get tree-sitter-cli"
    npm install --save-dev tree-sitter-cli
fi
./node_modules/tree-sitter-cli/tree-sitter generate --abi 14
./node_modules/tree-sitter-cli/tree-sitter test
cd "$script_dir"

# Create venv
rm -rf "$script_dir/.venv"
python3 -m venv "$script_dir/.venv"

# Install `pip`
source "$script_dir/.venv/bin/activate"
python3 -m ensurepip

# Install the project
export PROJECT_ROOT="$script_dir"
echo "$PROJECT_ROOT"
pip3 install -e .
