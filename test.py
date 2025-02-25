import sys

import tree_sitter
import tree_sitter_vhdl

parser = tree_sitter.Parser(tree_sitter.Language(tree_sitter_vhdl.language()))


def print_tree(node, indent=0):
    print("  " * indent + f"({node.type} [{node.start_point} - {node.end_point}])")
    for child in node.children:
        print_tree(child, indent + 1)


def main():
    if len(sys.argv) != 2:
        print("Usage: python test.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        with open(filename, "r") as f:
            code = f.read()
    except FileNotFoundError:
        print(f"Error: File not found: {filename}")
        sys.exit(1)

    # Parse the code
    tree = parser.parse(bytes(code, "utf8"))

    # Print the tree
    print_tree(tree.root_node)

if __name__ == "__main__":
    main()
