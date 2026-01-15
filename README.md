# ClaudeCode ARGBuster

Advanced ARG (Alternate Reality Game) investigation toolkit for Claude Code. Features 6 specialized **opus-powered** agents that **investigate directly** - cracking puzzles through original analysis, not by searching for existing solutions.

## Philosophy

> **"BE RELENTLESS. BE THOROUGH. CRACK THE ARG."**

This toolkit prioritizes **direct investigation over community search**. The agents probe, analyze, decode, and follow puzzle chains themselves - only referencing community findings after exhausting original investigation.

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

## Agents (6 Total) - All Opus-Powered

### 1. ARG Orchestrator (`agents/arg-orchestrator.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | magenta | Master coordinator - directs investigations, deploys specialists |

**Capabilities:**
- **Direct site investigation** using browser automation
- Automated path probing (50+ common ARG paths)
- Deploys subagents in parallel
- Recursive chain following
- Real-time documentation

**6-Phase Investigation Protocol:**
1. **Direct Reconnaissance** → 2. Aggressive Content Analysis → 3. Decode Everything → 4. Recursive Investigation → 5. Cross-Link Analysis → 6. Community Reference (LAST)

---

### 2. Stego Analyst (`agents/stego-analyst.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | cyan | Steganography detection & extraction |

**Capabilities:**
- **Image**: LSB extraction (all channels), color channel separation, bit plane analysis
- **Audio**: Spectrogram generation (multiple ranges), phase analysis, reversed audio
- **Tools**: exiftool, binwalk, sox, convert, zbarimg, tesseract

---

### 3. Crypto Decoder (`agents/crypto-decoder.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | yellow | Cryptanalysis & multi-layer decoding |

**Supported Encodings:**
| Category | Types |
|----------|-------|
| Modern | Base64, Hex, Binary, URL, HTML entities |
| Classical | Caesar/ROT (all 26), Vigenère, Atbash, Substitution |
| Numeric | A1Z26, ASCII, Phone keypad (T9) |
| Symbolic | Morse, Braille, Semaphore, Pigpen |

---

### 4. OSINT Recon (`agents/osint-recon.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | green | Open source intelligence gathering |

**Research:** WHOIS, DNS records, SSL certs (crt.sh), subdomains, Wayback Machine, identity search

---

### 5. Media Forensics (`agents/media-forensics.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | red | Deep file forensic analysis |

**Capabilities:** Magic bytes validation, embedded file extraction (binwalk/foremost), metadata analysis, QR/OCR detection, hash verification

---

### 6. Web Analyst (`agents/web-analyst.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | blue | Web analysis + browser automation |

**Mandatory Investigation Protocol:**
1. Extract ALL hidden elements (multiple detection methods)
2. Probe common secret paths
3. Analyze raw source code (Base64, hex, comments)
4. Click everything interactive
5. Recursive investigation of all discovered URLs

**Browser Automation** (claude-in-chrome MCP): `read_page`, `javascript_tool`, `read_console_messages`, `navigate`

---

## Commands (3 Total)

| Command | Description |
|---------|-------------|
| `/arg [target]` | Full ARG investigation workflow |
| `/decode [text]` | Quick multi-encoding decode |
| `/stego:spectrogram [audio]` | Generate audio spectrograms |

---

## Skills (3 Total)

| Skill | Triggers |
|-------|----------|
| **Cipher Identification** | Encoded text, "decode this" |
| **Puzzle Chain Tracking** | "what did we find", investigation state |
| **ARG Patterns** | "typical ARG puzzles", hiding techniques |

---

## Helper Scripts

| Script | Purpose |
|--------|---------|
| `scripts/lsb-extract.py` | LSB steganography extraction |
| `scripts/metadata-extract.sh` | Comprehensive metadata dump |

---

## Output Structure

```
~/Downloads/ARG_Investigation/
├── reports/        # Auto-generated investigation reports
├── spectrograms/   # Audio spectrograms
├── extracted/      # Downloaded & extracted files
└── logs/           # Raw analysis logs
```

---

## Auto-Documentation

All agents document findings in real-time:

| Agent | Report Pattern | Finding Types |
|-------|----------------|---------------|
| Orchestrator | `investigation-*.md` | 🔗 🔓 🖼️ 📁 💬 👻 📊 🖥️ 💡 ✅ |
| Stego | `stego-*.md` | 🖼️ 🎵 📁 📝 🔲 ❌ |
| Crypto | `crypto-*.md` | 🔓 (with full decode chain) |
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

## Recommended Claude Code Settings

Add these permissions to `~/.claude/settings.json` for unrestricted web fetching:

```json
{
  "permissions": {
    "allow": [
      "Bash(curl:*)",
      "Bash(wget:*)"
    ]
  }
}
```

> **Note:** The built-in `WebFetch` tool has domain verification that may fail on some networks. Using `curl` via Bash bypasses this limitation and provides more control over headers, cookies, and redirects.

---

## Architecture

```
User Request → ARG Orchestrator (opus)
                      │
                      │ INVESTIGATE FIRST
                      │
       ┌──────┬──────┬┴─────┬──────┐
       ▼      ▼      ▼      ▼      ▼
    Stego  Crypto  OSINT  Media   Web
   (opus) (opus)  (opus) (opus) (opus)
       │      │      │      │      │
       └──────┴──────┴──────┴──────┘
                      │
                      ▼
         ~/Downloads/ARG_Investigation/
              (Real-time reports)
```

---

## Example

```bash
# Investigate mysterious website (direct analysis, not search)
/arg https://mysterious-arg.com

# Decode suspicious text
/decode VGhpcyBpcyBhIHNlY3JldA==

# Analyze image for hidden data
/arg ~/Downloads/suspicious.png
```

---

## What Makes This Different

| Traditional Approach | ARGBuster Approach |
|---------------------|-------------------|
| Search for solutions first | **Investigate directly first** |
| Look up community writeups | **Crack puzzles yourself** |
| Single-page analysis | **Recursive chain following** |
| Manual path checking | **Automated 50+ path probing** |
| Passive investigation | **Aggressive content analysis** |

---

**Author:** Kevin Lin
**Version:** 1.1.0

*"The truth is out there... hidden in LSBs, spectrograms, and Base64."*
