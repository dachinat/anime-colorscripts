#!/usr/bin/env bash

# Default values
SIZE="30x30"
USER_IMG_DIR="$HOME/.local/share/anime-colorscripts/images"
SYSTEM_IMG_DIR="/usr/share/anime-colorscripts/images"
IMG_DIR=""

# Function to select default image directory
detect_image_dir() {
    if [ -d "$USER_IMG_DIR" ] && [ "$(find "$USER_IMG_DIR" -type f | wc -l)" -gt 0 ]; then
        IMG_DIR="$USER_IMG_DIR"
    elif [ -d "$SYSTEM_IMG_DIR" ] && [ "$(find "$SYSTEM_IMG_DIR" -type f | wc -l)" -gt 0 ]; then
        IMG_DIR="$SYSTEM_IMG_DIR"
    else
        echo "No images found in $USER_IMG_DIR or $SYSTEM_IMG_DIR"
        exit 1
    fi
}

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Displays a random anime girl image using chafa.

Options:
  --help        Show this help message.
  --size=WxH    Set the chafa output size (default: 30x30).
  --dir=PATH    Set the image directory manually.

Image search order (if --dir not provided):
  1. $USER_IMG_DIR
  2. $SYSTEM_IMG_DIR

Examples:
  $(basename "$0") --size=40x20
  $(basename "$0") --dir=/path/to/images
EOF
    exit 0
}

# Parse arguments
for arg in "$@"; do
    case $arg in
        --help)
            show_help
            ;;
        --size=*)
            SIZE="${arg#*=}"
            ;;
        --dir=*)
            IMG_DIR="${arg#*=}"
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Use --help for usage."
            exit 1
            ;;
    esac
done

# Detect default image dir if not manually set
if [ -z "$IMG_DIR" ]; then
    detect_image_dir
fi

# Collect images
IMAGES=()
while IFS= read -r -d '' file; do
    IMAGES+=("$file")
done < <(find "$IMG_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) -print0)

if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "No images found in $IMG_DIR"
    exit 1
fi

# Pick random image
IMG="${IMAGES[RANDOM % ${#IMAGES[@]}]}"

# Display image
chafa "$IMG" --fill=block --symbols=block --size="$SIZE"
