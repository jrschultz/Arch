#!/bin/bash
#
# pkg-list-to-cmd.sh
#
# Convert a list of explicitly installed packages (one per line)
# into a single-line space-separated list for bulk install.
#
# Usage:
#   ./pkg-list-to-cmd.sh [input_file] [output_file]
#
#   input_file  - defaults to PackageList.txt
#   output_file - defaults to install-cmd.txt
#
# Example output line (install-cmd.txt):
#   package1 package2 package3 ...

INPUT="${1:-PackageList.txt}"
OUTPUT="${2:-install-cmd.txt}"

# Safety check
if [[ ! -f "$INPUT" ]]; then
    echo "Error: Input file '$INPUT' not found." >&2
    exit 1
fi

# Read lines, trim whitespace, join with a single space
mapfile -t pkgs < <(grep -v '^$' "$INPUT" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if (( ${#pkgs[@]} == 0 )); then
    echo "Warning: No packages found in '$INPUT'." >&2
    > "$OUTPUT"   # create empty file
else
    printf '%s' "${pkgs[0]}" > "$OUTPUT"
    for pkg in "${pkgs[@]:1}"; do
        printf ' %s' "$pkg" >> "$OUTPUT"
    done
    echo >> "$OUTPUT"   # final newline for readability
fi

echo "Done. Packages written to '$OUTPUT'."
echo "You can now run on the target machine:"
echo "  sudo pacman -S --needed \$(cat \"$OUTPUT\")"
