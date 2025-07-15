#!/usr/bin/env bash

# Description:
#   Initialize a skeleton LaTeX project in the present working directory. By
#   default, will use the `homework` template defined in
#   `~/.dotfiles/latex/homework/*`. A different template name can be passed using
#   the `--template` option.
#
# Usage:
#  latex-template.sh [-template {template name}] [-h|--help]
#
# Examples:
#   # Default (homework template)
#   ./latex-template.sh
#
#   # Specify a template
#   ./latex-template.sh --template notes
#
#   # Show help
#   ./latex-template.sh -h
#   ./latex-template.sh --help
#
#   # Invalid usage (unknown option)
#   ./latex-template.sh --foo

TEMPLATES=("notes" "homework")

usage() {
  echo "Usage: $(basename "$0") [--template {template_name}] [-h|--help]"
  echo
  echo "Options:"
  echo "  --template <name>   Specify the LaTeX template to use (default: homework)."
  echo "  -h, --help          Show this help message and exit."
  echo
  echo "Available templates: ${TEMPLATES[*]}"
  exit 0
}

# Set directory to the current directory.
dir=$(pwd)

# Template (defaults to `homework`)
template="homework"

while [[ $# -gt 0 ]]; do
  case "$1" in
  --template)
    if [[ -n "$2" && "$2" != -* ]]; then
      template="$2"
      shift 2 # Shift past both --template and the argument
    else
      echo "Error: --template option requires a value."
      exit 1
    fi
    ;;
  -h | --help)
    usage
    ;;
  *)
    echo "Error: Unknown option: $1"
    usage
    ;;
  esac
done

# Validate template
if [[ ! " ${TEMPLATES[*]} " =~ ${template} ]]; then
  echo "Error: Invalid template '$template'. Available templates: ${TEMPLATES[*]}"
  exit 1
fi

# Copy the contents of the latex directory to the current directory
cp -r ~/dotfiles/latex/"$template"/ "$dir"
