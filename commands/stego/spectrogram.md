---
description: Generate spectrogram from audio file to reveal hidden visual patterns
argument-hint: [audio file path]
allowed-tools:
  - Bash
  - Read
---

# Audio Spectrogram Analysis

Generate and analyze spectrograms for hidden visual content.

**Audio File**: $ARGUMENTS

## Output Directory

```bash
OUTPUT_DIR=~/Downloads/ARG_Investigation/spectrograms
mkdir -p "$OUTPUT_DIR"
```

## Generate Spectrograms

```bash
AUDIO="$ARGUMENTS"
BASENAME=$(basename "$AUDIO" | sed 's/\.[^.]*$//')
OUTPUT_DIR=~/Downloads/ARG_Investigation/spectrograms

echo "Generating spectrograms for: $AUDIO"

# 1. Standard full spectrogram
echo "Creating standard spectrogram..."
sox "$AUDIO" -n spectrogram -o "$OUTPUT_DIR/${BASENAME}-full.png" -x 3000 -y 513
echo "Saved: $OUTPUT_DIR/${BASENAME}-full.png"

# 2. High-frequency focused (for hidden images in upper frequencies)
echo "Creating high-frequency spectrogram..."
sox "$AUDIO" -n spectrogram -o "$OUTPUT_DIR/${BASENAME}-high.png" -x 3000 -y 513 -z 120
echo "Saved: $OUTPUT_DIR/${BASENAME}-high.png"

# 3. Low-frequency focused
echo "Creating low-frequency spectrogram..."
sox "$AUDIO" -n spectrogram -o "$OUTPUT_DIR/${BASENAME}-low.png" -x 3000 -y 257 -z 80 -Z -20
echo "Saved: $OUTPUT_DIR/${BASENAME}-low.png"

# 4. Monochrome version (better for text/QR)
echo "Creating monochrome spectrogram..."
sox "$AUDIO" -n spectrogram -o "$OUTPUT_DIR/${BASENAME}-mono.png" -x 3000 -m
echo "Saved: $OUTPUT_DIR/${BASENAME}-mono.png"

# 5. Wide spectrogram (for long messages)
echo "Creating wide spectrogram..."
sox "$AUDIO" -n spectrogram -o "$OUTPUT_DIR/${BASENAME}-wide.png" -x 5000 -y 513
echo "Saved: $OUTPUT_DIR/${BASENAME}-wide.png"
```

## Audio File Information

```bash
echo ""
echo "=== Audio File Information ==="
ffprobe -v quiet -print_format json -show_format -show_streams "$AUDIO"
```

## Check for Reversed Content

```bash
echo ""
echo "=== Generating reversed audio spectrogram ==="
sox "$AUDIO" "$OUTPUT_DIR/${BASENAME}-reversed.wav" reverse
sox "$OUTPUT_DIR/${BASENAME}-reversed.wav" -n spectrogram -o "$OUTPUT_DIR/${BASENAME}-reversed-spec.png" -x 3000
echo "Saved: $OUTPUT_DIR/${BASENAME}-reversed-spec.png"
```

## Visual Inspection Guide

After generating spectrograms, examine them for:

1. **Text messages**: Look for letter-like patterns
2. **QR codes**: Square patterns with positioning markers
3. **Images/logos**: Recognizable shapes or pictures
4. **Morse code**: Dot and dash patterns
5. **Coordinates**: Number patterns

## Common Hidden Content Frequencies

| Frequency Range | Typical Content |
|-----------------|-----------------|
| 0-4 kHz | Voice range, obvious messages |
| 4-8 kHz | Background, subtle patterns |
| 8-16 kHz | Common hiding range |
| 16-22 kHz | High frequency hiding, requires quality source |

## Output Files

All spectrograms saved to: `~/Downloads/ARG_Investigation/spectrograms/`

- `[filename]-full.png` - Standard spectrogram
- `[filename]-high.png` - High frequency focus
- `[filename]-low.png` - Low frequency focus
- `[filename]-mono.png` - Monochrome version
- `[filename]-wide.png` - Extended width
- `[filename]-reversed-spec.png` - Reversed audio spectrogram
