#!/bin/bash

# Default values
verbose=false
level=0
output="/mnt/export/pyspark_pex_env.pex"

# Help function
usage() {
  echo "Usage: $0 [options] python-dependency1 [python-dependency2 ...]"
  echo "Options:"
  echo "  -v, --verbose       Enable verbose output"
  echo "  -o, --output FILE   Write output to FILE (default: '$output')"
  echo "  -h, --help          Display this help message"
  exit 1
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--verbose)
      verbose=true
      shift
      ;;
    -o|--output)
      if [[ -n "$2" && "$2" != -* ]]; then
        output="$2"
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        usage
      fi
      ;;
    -h|--help)
      usage
      ;;
    --) # End of options
      shift
      break
      ;;
    -*) # Unknown option
      echo "Error: Unknown option: $1" >&2
      usage
      ;;
    *) # Not an option, break the loop
      break
      ;;
  esac
done

# Remaining arguments are input files
dependencies=("$@")

# Check if we have input files
if [[ ${#dependencies[@]} -eq 0 ]]; then
  echo "Error: No dependency specified" >&2
  usage
fi

if $verbose; then
  echo "Output: $output"
  echo "Dependencies: ${dependencies[*]}"
fi
# Print parsed arguments

pip install ${dependencies[*]} && \
  pex ${dependencies[*]} -o "$output"

if $verbose; then
  echo "Pex file generated: '$output'"
fi