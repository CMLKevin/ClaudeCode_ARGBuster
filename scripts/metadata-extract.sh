#!/bin/bash
# Comprehensive metadata extraction for media files
# Usage: metadata-extract.sh <file>
# Output saved to: ~/Downloads/ARG_Investigation/logs/

FILE="$1"
OUTPUT_DIR=~/Downloads/ARG_Investigation/logs
BASENAME=$(basename "$FILE" | sed 's/\.[^.]*$//')

if [ -z "$FILE" ]; then
    echo "Usage: metadata-extract.sh <file>"
    echo "Extracts comprehensive metadata from media files"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "Error: File not found: $FILE"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}-metadata.txt"

echo "=== Metadata Extraction Report ===" | tee "$OUTPUT_FILE"
echo "File: $FILE" | tee -a "$OUTPUT_FILE"
echo "Date: $(date)" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

echo "=== File Identification ===" | tee -a "$OUTPUT_FILE"
file "$FILE" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

echo "=== File Size ===" | tee -a "$OUTPUT_FILE"
ls -lh "$FILE" | awk '{print $5}' | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

echo "=== MD5 Hash ===" | tee -a "$OUTPUT_FILE"
md5 -q "$FILE" 2>/dev/null || md5sum "$FILE" 2>/dev/null | awk '{print $1}' | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

echo "=== EXIF/Metadata (exiftool) ===" | tee -a "$OUTPUT_FILE"
if command -v exiftool &> /dev/null; then
    exiftool -a -u -g1 "$FILE" 2>/dev/null | tee -a "$OUTPUT_FILE"
else
    echo "exiftool not installed" | tee -a "$OUTPUT_FILE"
fi
echo "" | tee -a "$OUTPUT_FILE"

echo "=== Embedded Files (binwalk) ===" | tee -a "$OUTPUT_FILE"
if command -v binwalk &> /dev/null; then
    binwalk "$FILE" 2>/dev/null | tee -a "$OUTPUT_FILE"
else
    echo "binwalk not installed" | tee -a "$OUTPUT_FILE"
fi
echo "" | tee -a "$OUTPUT_FILE"

echo "=== Strings (8+ chars) ===" | tee -a "$OUTPUT_FILE"
strings -n 8 "$FILE" 2>/dev/null | head -100 | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

echo "=== Hex Header (first 64 bytes) ===" | tee -a "$OUTPUT_FILE"
xxd "$FILE" 2>/dev/null | head -4 | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

echo "=== Hex Footer (last 64 bytes) ===" | tee -a "$OUTPUT_FILE"
xxd "$FILE" 2>/dev/null | tail -4 | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# Image-specific checks
MIME_TYPE=$(file -b --mime-type "$FILE")
if [[ "$MIME_TYPE" == image/* ]]; then
    echo "=== Image-Specific Analysis ===" | tee -a "$OUTPUT_FILE"

    echo "--- QR/Barcode Scan ---" | tee -a "$OUTPUT_FILE"
    if command -v zbarimg &> /dev/null; then
        zbarimg "$FILE" 2>/dev/null | tee -a "$OUTPUT_FILE"
    else
        echo "zbarimg not installed" | tee -a "$OUTPUT_FILE"
    fi

    echo "--- PNG Chunks (if PNG) ---" | tee -a "$OUTPUT_FILE"
    if command -v pngcheck &> /dev/null; then
        pngcheck -v "$FILE" 2>/dev/null | tee -a "$OUTPUT_FILE"
    fi
    echo "" | tee -a "$OUTPUT_FILE"
fi

# Audio-specific checks
if [[ "$MIME_TYPE" == audio/* ]]; then
    echo "=== Audio-Specific Analysis ===" | tee -a "$OUTPUT_FILE"

    if command -v ffprobe &> /dev/null; then
        echo "--- FFprobe Info ---" | tee -a "$OUTPUT_FILE"
        ffprobe -v quiet -print_format json -show_format -show_streams "$FILE" 2>/dev/null | tee -a "$OUTPUT_FILE"
    fi

    if command -v mediainfo &> /dev/null; then
        echo "--- MediaInfo ---" | tee -a "$OUTPUT_FILE"
        mediainfo "$FILE" 2>/dev/null | tee -a "$OUTPUT_FILE"
    fi
    echo "" | tee -a "$OUTPUT_FILE"
fi

echo "" | tee -a "$OUTPUT_FILE"
echo "=== Analysis Complete ===" | tee -a "$OUTPUT_FILE"
echo "Output saved to: $OUTPUT_FILE"
