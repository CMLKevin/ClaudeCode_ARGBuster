#!/usr/bin/env python3
"""
LSB Steganography Extraction Tool
Extracts least significant bits from image channels

Usage: python3 lsb-extract.py <image> [bits] [channel]
  image   - Path to image file
  bits    - Number of LSBs to extract (default: 1)
  channel - Channel to extract: r, g, b, a, or all (default: all)

Output saved to: ~/Downloads/ARG_Investigation/extracted/
"""

import sys
import os
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("Error: Pillow not installed. Run: pip3 install pillow")
    sys.exit(1)

OUTPUT_DIR = Path.home() / "Downloads" / "ARG_Investigation" / "extracted"

def extract_lsb(image_path, bits=1, channel='all'):
    """Extract LSB data from image."""
    try:
        img = Image.open(image_path)
    except Exception as e:
        print(f"Error opening image: {e}")
        return None

    pixels = img.load()
    width, height = img.size
    mode = img.mode

    print(f"Image: {image_path}")
    print(f"Size: {width}x{height}")
    print(f"Mode: {mode}")
    print(f"Extracting {bits} LSB(s) from {channel} channel(s)")
    print("-" * 50)

    binary_data = ''

    for y in range(height):
        for x in range(width):
            pixel = pixels[x, y]

            if isinstance(pixel, int):  # Grayscale
                binary_data += format(pixel & ((1 << bits) - 1), f'0{bits}b')
            else:  # RGB/RGBA
                if channel in ('all', 'r') and len(pixel) > 0:
                    binary_data += format(pixel[0] & ((1 << bits) - 1), f'0{bits}b')
                if channel in ('all', 'g') and len(pixel) > 1:
                    binary_data += format(pixel[1] & ((1 << bits) - 1), f'0{bits}b')
                if channel in ('all', 'b') and len(pixel) > 2:
                    binary_data += format(pixel[2] & ((1 << bits) - 1), f'0{bits}b')
                if channel in ('all', 'a') and len(pixel) > 3:
                    binary_data += format(pixel[3] & ((1 << bits) - 1), f'0{bits}b')

    # Convert to text
    text = ''
    raw_bytes = bytearray()

    for i in range(0, len(binary_data) - 7, 8):
        byte = binary_data[i:i+8]
        byte_val = int(byte, 2)
        raw_bytes.append(byte_val)

        char = chr(byte_val)
        if char.isprintable() or char in '\n\r\t':
            text += char
        elif byte_val == 0:
            # Null byte often indicates end of hidden message
            if len(text) > 10:
                break
        else:
            text += '.'  # Non-printable placeholder

    return text, raw_bytes

def save_results(text, raw_bytes, image_path, bits, channel):
    """Save extraction results to output directory."""
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    base_name = Path(image_path).stem

    # Save text output
    text_file = OUTPUT_DIR / f"{base_name}-lsb-{channel}-{bits}bit.txt"
    with open(text_file, 'w', encoding='utf-8', errors='replace') as f:
        f.write(text[:10000])  # Limit output size
    print(f"Text saved to: {text_file}")

    # Save raw bytes
    raw_file = OUTPUT_DIR / f"{base_name}-lsb-{channel}-{bits}bit.bin"
    with open(raw_file, 'wb') as f:
        f.write(raw_bytes[:10000])
    print(f"Raw bytes saved to: {raw_file}")

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    image_path = sys.argv[1]
    bits = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    channel = sys.argv[3].lower() if len(sys.argv) > 3 else 'all'

    if not os.path.exists(image_path):
        print(f"Error: File not found: {image_path}")
        sys.exit(1)

    if channel not in ('r', 'g', 'b', 'a', 'all'):
        print("Error: Channel must be r, g, b, a, or all")
        sys.exit(1)

    result = extract_lsb(image_path, bits, channel)

    if result:
        text, raw_bytes = result

        # Print preview
        preview = text[:500]
        print("\n=== Extracted Text Preview ===")
        print(preview)

        if len(text) > 500:
            print(f"\n... ({len(text)} total characters)")

        # Check for common patterns
        print("\n=== Pattern Detection ===")

        # Check for Base64
        import re
        base64_pattern = re.search(r'[A-Za-z0-9+/]{20,}={0,2}', text)
        if base64_pattern:
            print(f"Possible Base64 found: {base64_pattern.group()[:50]}...")

        # Check for URLs
        url_pattern = re.search(r'https?://[^\s]+', text)
        if url_pattern:
            print(f"URL found: {url_pattern.group()}")

        # Check for readable words
        words = re.findall(r'[a-zA-Z]{4,}', text)
        if words:
            print(f"Readable words: {', '.join(words[:10])}")

        # Save results
        save_results(text, raw_bytes, image_path, bits, channel)

        print("\n=== Analysis Complete ===")

if __name__ == '__main__':
    main()
