---
name: arg-patterns
description: This skill should be used when analyzing ARG puzzle patterns, identifying common ARG tropes, understanding puzzle design conventions, or when the user asks about "typical ARG puzzles", "common patterns", "what to look for", or needs guidance on ARG investigation strategies.
version: 1.0.0
---

# Common ARG Patterns Skill

Frequently-used puzzle patterns and hiding techniques in Alternate Reality Games.

## Hiding Locations by Medium

### Website Patterns
| Location | How to Check |
|----------|--------------|
| HTML comments | `grep -oP '<!--.*?-->'` |
| Meta tags | `<meta name="secret">` |
| Data attributes | `data-puzzle="encoded"` |
| White text on white | Inspect element, select all |
| display:none elements | DevTools → Elements |
| robots.txt | Often lists hidden paths |
| Source maps | Check for .map files |
| Console messages | DevTools → Console |

### Image Patterns
| Location | How to Check |
|----------|--------------|
| EXIF comments | `exiftool -Comment` |
| LSB steganography | LSB extraction tools |
| Appended data | `binwalk`, check after EOF |
| QR codes | `zbarimg` |
| Alpha channel | Extract alpha separately |
| Tiny embedded images | Zoom, enhance |

### Audio Patterns
| Location | How to Check |
|----------|--------------|
| Spectrogram | `sox audio -n spectrogram` |
| Reversed audio | `sox audio out.wav reverse` |
| Metadata | `exiftool`, `mediainfo` |
| DTMF tones | DTMF decoder |
| Morse code | Listen or spectrogram |
| Hidden tracks | Check after silence |

## Common Encoding Chains

```
Layer 1     →  Layer 2    →  Layer 3    →  Result
─────────────────────────────────────────────────
Base64      →  ROT13      →  Plaintext
Hex         →  Base64     →  Plaintext
Binary      →  ASCII      →  Base64     →  Plaintext
Image LSB   →  Base64     →  URL
```

## ARG Entry Points ("Rabbit Holes")

- Mysterious Twitter accounts
- Hidden links in promotional material
- QR codes in real-world locations
- Phone numbers in videos
- Coordinates leading to websites
- Emails from fictional characters

## Red Herring Detection

Signs of intentional misdirection:
- Obvious "secret" paths that lead nowhere
- Overly simple puzzles early on (test decoys)
- Dead-end URLs that exist but contain nothing
- Fake error pages

## Success Indicators

Signs you're on the right track:
- Decoded text is grammatically correct
- URLs actually exist and load content
- Passwords unlock something
- Patterns match ARG narrative
- Coordinates point to real places
- Multiple clues converge on same answer

## Famous ARG Techniques

### Cicada 3301 Style
- Multi-layer cryptography
- Real-world dead drops
- Book ciphers
- Runic alphabets

### Year Zero (NIN) Style
- Audio spectrograms with images
- USB drives at concerts
- Hidden website network
- Timeline-based reveals

### I Love Bees Style
- GPS coordinates
- Payphone interactions
- Community collaboration required
- Time-sensitive puzzles

## Quick Investigation Checklist

For any new ARG element:
- [ ] View source (Ctrl+U)
- [ ] Check robots.txt and sitemap.xml
- [ ] Inspect hidden elements (DevTools)
- [ ] Check console for messages
- [ ] Extract and analyze images
- [ ] Generate spectrograms for audio
- [ ] Run WHOIS/DNS lookup
- [ ] Check Wayback Machine
- [ ] Search for related content
