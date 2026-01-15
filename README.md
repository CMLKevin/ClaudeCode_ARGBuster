# ClaudeCode ARGBuster

Advanced ARG (Alternate Reality Game) investigation toolkit for Claude Code with specialized agents for steganography, cryptanalysis, OSINT, media forensics, and web analysis.

## Installation

```bash
# Copy to Claude Code plugins directory
cp -r ClaudeCode_ARGBuster ~/.claude/plugins/local/

# Restart Claude Code - plugins auto-discover
claude
```

## Quick Start

```bash
/arg https://mysterious-arg-site.com    # Full investigation
/decode SGVsbG8gV29ybGQ=                 # Quick decode
/stego:spectrogram ~/audio.mp3          # Audio spectrogram
```

---

## Agents (6 Total)

### 1. ARG Orchestrator (`agents/arg-orchestrator.md`)
| Model | Color | Role |
|-------|-------|------|
| opus | magenta | Main coordinator - plans investigations, deploys specialists |

**Capabilities:**
- Creates master investigation log
- Deploys subagents in parallel
- Searches ARG communities (Reddit, ARGNet, Game Detectives)
- Synthesizes findings, tracks puzzle chains
- Generates comprehensive reports

**5-Phase Protocol:**
1. Community Research → 2. Initial Assessment → 3. Parallel Analysis → 4. Cross-Reference → 5. Reporting

---

### 2. Stego Analyst (`agents/stego-analyst.md`)
| Model | Color | Role |
|-------|-------|------|
| sonnet | cyan | Steganography detection & extraction |

**Capabilities:**
- **Image**: LSB extraction, color channel separation, bit plane analysis
- **Audio**: Spectrogram generation, phase analysis, reversed audio
- **Tools**: exiftool, binwalk, sox, convert, zbarimg, tesseract

---

### 3. Crypto Decoder (`agents/crypto-decoder.md`)
| Model | Color | Role |
|-------|-------|------|
| sonnet | yellow | Cryptanalysis & encoding detection |

**Supported Encodings:**
| Category | Types |
|----------|-------|
| Modern | Base64, Hex, Binary, URL, HTML entities |
| Classical | Caesar/ROT, Vigenère, Atbash, Substitution |
| Numeric | A1Z26, ASCII, Phone keypad (T9) |
| Symbolic | Morse, Braille, Semaphore, Pigpen |

---

### 4. OSINT Recon (`agents/osint-recon.md`)
| Model | Color | Role |
|-------|-------|------|
| sonnet | green | Open source intelligence gathering |

**Research:** WHOIS, DNS, SSL certs, subdomains, Wayback Machine, identity search

---

### 5. Media Forensics (`agents/media-forensics.md`)
| Model | Color | Role |
|-------|-------|------|
| sonnet | red | Deep file forensic analysis |

**Capabilities:** Magic bytes validation, embedded file extraction, metadata, QR/OCR, hash verification

---

### 6. Web Analyst (`agents/web-analyst.md`)
| Model | Color | Role |
|-------|-------|------|
| sonnet | blue | Web analysis + browser automation |

**Targets:** HTML comments, hidden elements, data attributes, JS variables, console messages, localStorage

**Browser Automation** (claude-in-chrome MCP): `read_page`, `javascript_tool`, `read_console_messages`

---

## Commands (3 Total)

| Command | File | Description |
|---------|------|-------------|
| `/arg [target]` | `commands/arg.md` | Full ARG investigation workflow |
| `/decode [text]` | `commands/decode.md` | Quick multi-encoding decode |
| `/stego:spectrogram [audio]` | `commands/stego/spectrogram.md` | Generate audio spectrograms |

---

## Skills (3 Total)

| Skill | File | Triggers |
|-------|------|----------|
| **Cipher Identification** | `skills/cipher-identification/SKILL.md` | Encoded text, "decode this" |
| **Puzzle Chain Tracking** | `skills/puzzle-chain-tracking/SKILL.md` | "what did we find", investigation state |
| **ARG Patterns** | `skills/arg-patterns/SKILL.md` | "typical ARG puzzles", guidance |

---

## Helper Scripts

| Script | Purpose |
|--------|---------|
| `scripts/lsb-extract.py` | LSB steganography extraction from images |
| `scripts/metadata-extract.sh` | Comprehensive metadata dump |

---

## Output Structure

```
~/Downloads/ARG_Investigation/
├── reports/        # Auto-generated reports
├── spectrograms/   # Audio spectrograms
├── extracted/      # Extracted files
└── logs/           # Analysis logs
```

---

## Auto-Documentation

All agents write findings in real-time:

| Agent | Report Pattern | Finding Types |
|-------|----------------|---------------|
| Orchestrator | `investigation-*.md` | 🔗 🔓 🖼️ 📁 🔍 💡 ❌ ✅ |
| Stego | `stego-*.md` | 🖼️ 🎵 📁 📝 🔲 ❌ |
| Crypto | `crypto-*.md` | 🔓 (with decode chain) |
| OSINT | `osint-*.md` | 🌐 📡 🔐 📜 🔗 👤 |
| Forensics | `forensics-*.md` | 📁 📝 🔲 📖 ⚠️ 🔀 |
| Web | `web-*.md` | 💬 👻 📊 🔗 📜 🖥️ 📦 |

---

## Required Tools

```bash
# macOS
brew install exiftool binwalk sox ffmpeg zbar tesseract imagemagick foremost

# Python
pip3 install pillow
```

---

## Architecture

```
User Request → ARG Orchestrator (opus)
                      │
       ┌──────┬──────┬┴─────┬──────┐
       ▼      ▼      ▼      ▼      ▼
    Stego  Crypto  OSINT  Media   Web
   (cyan) (yellow)(green) (red)  (blue)
       │      │      │      │      │
       └──────┴──────┴──────┴──────┘
                      │
                      ▼
         ~/Downloads/ARG_Investigation/
```

---

## Example

```bash
# Investigate mysterious website
/arg https://mysterious-arg.com

# Decode suspicious text
/decode VGhpcyBpcyBhIHNlY3JldA==

# Analyze image for hidden data
/arg ~/Downloads/suspicious.png
```

---

**Author:** Kevin Lin
**Version:** 1.0.0

*"The truth is out there... hidden in LSBs, spectrograms, and Base64."*
