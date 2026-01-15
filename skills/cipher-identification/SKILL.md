---
name: cipher-identification
description: This skill should be used when the user encounters encoded or encrypted text, asks about cipher types, needs help identifying encoding schemes, mentions "what cipher is this", "decode this", "encrypted text", "what encoding", or discusses cryptographic puzzles in ARGs.
version: 1.0.0
---

# Cipher Identification Skill

Pattern-based identification of common ciphers and encoding schemes used in ARGs.

## Quick Reference: Identify by Character Set

| If you see... | It's probably... | Decode with... |
|---------------|------------------|----------------|
| A-Za-z0-9+/= (ends with =) | **Base64** | `echo "..." \| base64 -d` |
| 0-9A-Fa-f only | **Hexadecimal** | `echo "..." \| xxd -r -p` |
| Only 0s and 1s (8-bit groups) | **Binary** | Convert to ASCII |
| A-Z only (looks shifted) | **Caesar/ROT cipher** | Try all 26 rotations |
| .-. and --- patterns | **Morse code** | Morse decoder |
| Numbers 1-26 | **A1Z26** | Map numbers to letters |
| %XX patterns | **URL encoding** | `urllib.parse.unquote()` |

## Pattern Recognition

### Base64 Indicators
- Ends with `=` or `==` (padding)
- Character set: `A-Za-z0-9+/`
- Example: `SGVsbG8gV29ybGQ=`

### Hexadecimal Indicators
- Only `0-9` and `A-F` (case insensitive)
- Two hex chars = one byte
- Example: `48656c6c6f`

### ROT13/Caesar Indicators
- Only letters (spaces preserved)
- Word boundaries maintained
- Example: `Uryyb Jbeyq` (ROT13)

### Binary Indicators
- Only `0` and `1`, groups of 8
- Example: `01001000 01100101`

### Morse Code Indicators
- Dots (`.`), dashes (`-`), spaces
- Example: `.... . .-.. .-.. ---`

## Multi-Layer Detection

ARGs often chain encodings:
```
Base64 → ROT13 → Plaintext
Hex → Base64 → Plaintext
Binary → ASCII → Base64 → Plaintext
```

**Always check:** If decoded output looks encoded, decode again!

## Quick Decode Commands

```bash
# Base64
echo "SGVsbG8=" | base64 -d

# ROT13
echo "Uryyb" | tr 'A-Za-z' 'N-ZA-Mn-za-m'

# Hex to ASCII
echo "48656c6c6f" | xxd -r -p

# URL decode
python3 -c "import urllib.parse; print(urllib.parse.unquote('%48%65'))"

# Binary to ASCII
echo "01001000" | perl -lpe '$_=pack"B*",$_'

# A1Z26
echo "8-5-12-12-15" | tr '-' '\n' | while read n; do printf "\\$(printf '%03o' $((n+64)))"; done
```

## Frequency Analysis (Substitution Ciphers)

English letter frequency (most to least):
```
E T A O I N S H R D L C U M W F G Y P B V K J X Q Z
```

Common patterns:
- Single letters: Usually `A` or `I`
- Two-letter: `OF, TO, IN, IS, IT, AS, AT, BE`
- Three-letter: `THE, AND, FOR, ARE, BUT, NOT`
