---
description: Quick decode - try multiple common encodings on text
argument-hint: [encoded text]
allowed-tools:
  - Bash
  - Read
  - Write
---

# Quick Decode Command

Attempt to decode the input using common ARG encodings.

**Input**: `$ARGUMENTS`

## Decode Attempts

Run all applicable decodings and report successful results:

```bash
INPUT="$ARGUMENTS"
OUTPUT_DIR=~/Downloads/ARG_Investigation/logs
mkdir -p "$OUTPUT_DIR"

echo "=== Quick Decode Results ===" | tee "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "Input: $INPUT" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"

# 1. Base64
echo "--- Base64 ---" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "$INPUT" | base64 -d 2>/dev/null | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"

# 2. ROT13
echo "--- ROT13 ---" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "$INPUT" | tr 'A-Za-z' 'N-ZA-Mn-za-m' | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"

# 3. Hex to ASCII
echo "--- Hex to ASCII ---" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "$INPUT" | xxd -r -p 2>/dev/null | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"

# 4. URL decode
echo "--- URL Decode ---" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
python3 -c "import urllib.parse; print(urllib.parse.unquote('$INPUT'))" 2>/dev/null | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"

# 5. Reverse
echo "--- Reversed ---" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "$INPUT" | rev | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
echo "" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"

# 6. Binary to ASCII (if input looks like binary)
if [[ "$INPUT" =~ ^[01\ ]+$ ]]; then
  echo "--- Binary to ASCII ---" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
  echo "$INPUT" | tr -d ' ' | perl -lpe '$_=pack"B*",$_' 2>/dev/null | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
  echo "" | tee -a "$OUTPUT_DIR/decode-$(date +%H%M%S).txt"
fi
```

## All Caesar Rotations

If input appears to be alphabetic cipher:

```bash
echo "--- All Caesar Rotations (ROT1-25) ---"
for i in $(seq 1 25); do
  result=$(echo "$INPUT" | tr "$(printf '%s' {A..Z}{a..z} | cut -c1-$((52-2*i)))$(printf '%s' {A..Z}{a..z} | cut -c$((53-2*i))-52)" "A-Za-z" 2>/dev/null)
  echo "ROT$i: $result"
done
```

## Analysis

After running decodings:
1. Identify which decoding produced readable output
2. Check if the decoded result is itself encoded (multi-layer)
3. Look for ARG patterns: URLs, coordinates, passwords, usernames
4. Report confidence level for each successful decode

## Output

Results saved to: `~/Downloads/ARG_Investigation/logs/decode-[timestamp].txt`
