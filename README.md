# ClaudeCode ARGBuster

Advanced ARG (Alternate Reality Game) investigation toolkit for Claude Code. Features 6 specialized **opus-powered** agents that work **autonomously** in a flat architecture - each agent investigates directly, cracks puzzles through original analysis, and recommends next steps for Claude Code to orchestrate.

## Philosophy

> **"BE RELENTLESS. BE THOROUGH. CRACK THE ARG."**

This toolkit prioritizes **direct investigation over community search**. The agents probe, analyze, decode, and follow puzzle chains themselves - only referencing community findings after exhausting original investigation.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    FLAT AGENT ARCHITECTURE                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  User Request                                                    │
│       │                                                          │
│       ▼                                                          │
│  ┌─────────┐                                                     │
│  │ Claude  │  Decides which specialist to spawn based on input   │
│  │  Code   │                                                     │
│  └────┬────┘                                                     │
│       │                                                          │
│       ▼ Spawns ONE agent at a time                               │
│  ┌─────────────────────────────────────────────────────────┐     │
│  │  SELF-SUFFICIENT AGENTS (work independently)            │     │
│  │                                                         │     │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐   │     │
│  │  │  stego   │ │  crypto  │ │  osint   │ │  media   │   │     │
│  │  │ analyst  │ │ decoder  │ │  recon   │ │ forensic │   │     │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘   │     │
│  │  ┌──────────┐ ┌──────────┐                             │     │
│  │  │   web    │ │   arg    │ ← Guide + Direct Investigator│     │
│  │  │ analyst  │ │orchestr. │                             │     │
│  │  └──────────┘ └──────────┘                             │     │
│  └─────────────────────────────────────────────────────────┘     │
│       │                                                          │
│       ▼ Returns structured findings                              │
│  ┌─────────┐                                                     │
│  │ Claude  │  Reads report, decides next agent to spawn          │
│  │  Code   │                                                     │
│  └────┬────┘                                                     │
│       │                                                          │
│       ▼ Spawns next recommended agent...                         │
│                                                                  │
│  📁 ~/Downloads/${ARG_NAME}_ARG_Investigation/                   │
│       └── All findings saved to ARG-specific folder              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Key Architecture Features:**
- **No hierarchical orchestration** - Claude Code spawns agents directly
- **Self-sufficient agents** - Each creates its own investigation folder if needed
- **Structured output** - Agents return findings with `🚀 RECOMMENDED NEXT AGENTS`
- **ARG-specific folders** - Each investigation gets its own folder named after the ARG

---

## Installation

### Option 1: Load with --plugin-dir (Recommended)

```bash
# Clone the repo
git clone https://github.com/CMLKevin/ClaudeCode_ARGBuster.git

# Start Claude Code with the plugin loaded
claude --plugin-dir ./ClaudeCode_ARGBuster
```

### Option 2: Add to local plugins directory

```bash
# Copy to Claude Code plugins directory
cp -r ClaudeCode_ARGBuster ~/.claude/plugins/local/arg-investigation

# Start Claude Code with the plugin
claude --plugin-dir ~/.claude/plugins/local/arg-investigation
```

### Option 3: Create a shell alias (Permanent)

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
alias claude-arg='claude --plugin-dir ~/.claude/plugins/local/arg-investigation'
```

Then use `claude-arg` to start Claude Code with ARG capabilities.

---

## Quick Start

```bash
# After starting Claude with the plugin loaded:
/arg https://mysterious-arg-site.com    # Full investigation
/decode SGVsbG8gV29ybGQ=                 # Quick decode
/stego:spectrogram ~/audio.mp3          # Audio spectrogram
```

---

## Agent Selection Guide

Claude Code spawns the appropriate agent based on what you have:

| You Have | Agent to Use | Why |
|----------|--------------|-----|
| Website URL | **web-analyst** | Analyze HTML, JS, hidden elements, browser automation |
| Image file | **stego-analyst** | LSB extraction, spectrograms, color channels |
| Audio file | **stego-analyst** | Spectrogram analysis, phase analysis, reversed audio |
| Encoded text | **crypto-decoder** | 50+ cipher types, multi-layer decoding |
| Domain/IP | **osint-recon** | WHOIS, DNS, certs, Wayback Machine |
| Unknown file | **media-forensics** | binwalk, magic bytes, embedded files |
| Need guidance | **arg-orchestrator** | Investigation methodology, patterns |

---

## Agents (6 Total) - All Opus-Powered

### 1. ARG Orchestrator (`agents/arg-orchestrator.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | magenta | **Guide & Direct Investigator** (not a coordinator) |

**What It Does:**
- Provides **investigation methodology** and checklists
- **Direct browser automation** for site investigation
- **Agent selection guidance** for Claude Code
- Reference for common ARG patterns and hiding techniques

**When to Use:**
- When you need guidance on HOW to investigate
- When you want direct browser-based investigation
- When unsure which specialist to use

---

### 2. Stego Analyst (`agents/stego-analyst.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | cyan | Steganography detection & extraction |

**Capabilities:**
- **Image**: LSB extraction (all channels), color channel separation, bit plane analysis
- **Audio**: Spectrogram generation (multiple ranges), phase analysis, reversed audio
- **Tools**: exiftool, binwalk, sox, convert, zbarimg, tesseract

**Recommends Next:** crypto-decoder (encoded data), media-forensics (embedded files)

---

### 3. Crypto Decoder (`agents/crypto-decoder.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | yellow | **Advanced cryptanalysis & 50+ cipher types** |

**5-Tier Encoding Detection Matrix:**

| Tier | Category | Cipher Types |
|------|----------|--------------|
| 1 | Basic | Base64, Hex, Binary, URL, HTML entities |
| 2 | Classic | Caesar/ROT1-25, Atbash, ROT47, Vigenère |
| 3 | Numeric/Symbolic | A1Z26, ASCII, Morse, T9 Phone, Tap Code |
| 4 | ARG-Specific | **W.D. Gaster (Wingdings)**, Standard Galactic, Braille, Runes, Pigpen, Bacon's Cipher |
| 5 | Esoteric | Polybius, Playfair, Rail Fence, Bifid, Book Cipher |

**Advanced Cryptanalysis:**
- **Index of Coincidence** (IC) analysis for cipher identification
- **Kasiski Examination** for Vigenère key length detection
- **Automated Vigenère cracker** with chi-squared frequency analysis
- **Rail Fence brute-forcer** (2-10 rails)
- **Substitution cipher frequency analysis**
- **Multi-layer decode chain** tracking
- **ARG keyword dictionary attack**

**Recommends Next:** web-analyst (decoded URLs), stego-analyst (decoded reveals image clues)

---

### 4. OSINT Recon (`agents/osint-recon.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | green | Open source intelligence gathering |

**Research Capabilities:**
- WHOIS (including historical changes)
- DNS records (A, MX, TXT, NS, CNAME, SPF, DMARC)
- SSL certificates via crt.sh (find subdomains)
- Wayback Machine deep dive
- Username/email cross-platform search
- Reverse WHOIS (other domains by same registrant)

**Community Cross-Reference:** Checks GameDetectives, Reddit ARG communities, ARGNet after own investigation

**Recommends Next:** web-analyst (discovered subdomains), crypto-decoder (encoded TXT records)

---

### 5. Media Forensics (`agents/media-forensics.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | red | Deep file forensic analysis |

**Capabilities:**
- Magic bytes validation (detect disguised files)
- Embedded file extraction (binwalk, foremost)
- Comprehensive metadata analysis (exiftool)
- QR code detection (zbarimg)
- OCR text extraction (tesseract)
- Hash verification
- Polyglot file detection

**Recommends Next:** crypto-decoder (extracted text), stego-analyst (extracted images)

---

### 6. Web Analyst (`agents/web-analyst.md`)
| Model | Color | Role |
|-------|-------|------|
| **opus** | blue | Web analysis + browser automation |

**Mandatory Investigation Protocol:**
1. Extract ALL hidden elements (7 detection methods)
2. Probe 50+ common ARG paths
3. Analyze raw source (Base64, hex, comments, data-* attributes)
4. Execute and analyze JavaScript
5. Check console messages for hidden clues
6. Recursive investigation of discovered URLs

**Browser Automation** (claude-in-chrome MCP):
- `read_page` - Accessibility tree examination
- `javascript_tool` - Inspect localStorage, sessionStorage, variables
- `read_console_messages` - Hidden console.log clues
- `navigate` - Follow discovered links
- `computer` (screenshot) - Visual analysis

**Recommends Next:** crypto-decoder (encoded content), osint-recon (new domains), stego-analyst (images)

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

Each ARG investigation gets its own folder:

```
~/Downloads/${ARG_NAME}_ARG_Investigation/
├── clues/          # KEY FINDINGS - discovered secrets, decoded messages
├── reports/        # Auto-generated investigation reports
├── spectrograms/   # Audio spectrograms
├── extracted/      # Downloaded & extracted files
└── logs/           # Raw analysis logs
```

**Examples:**
- `~/Downloads/cicada_ARG_Investigation/`
- `~/Downloads/deltarune_ARG_Investigation/`
- `~/Downloads/mysterious_ARG_Investigation/`

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

## Agent Coordination

Each agent ends its analysis with structured output:

```markdown
## 🔍 ANALYSIS COMPLETE

### Findings Summary
- [Key discoveries]

### Files Created
- $ARG_DIR/clues/[findings].txt

### 🚀 RECOMMENDED NEXT AGENTS
1. **crypto-decoder** - [WHY: Found Base64 in hidden element]
2. **osint-recon** - [WHY: Discovered new subdomain]

### Investigation Leads
- [URLs to follow]
- [Patterns to investigate]
```

Claude Code reads these recommendations and decides which agent to spawn next.

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

## Example Investigation Flow

```bash
# 1. Start with a mysterious website
User: "Investigate https://mysterious-arg.com"

# 2. Claude Code spawns web-analyst
CC → web-analyst → Finds hidden Base64 in data-secret attribute
                 → Recommends: crypto-decoder

# 3. Claude Code spawns crypto-decoder
CC → crypto-decoder → Decodes to URL: puzzle.mysterious-arg.com
                    → Recommends: osint-recon, web-analyst

# 4. Claude Code spawns osint-recon
CC → osint-recon → Finds 5 subdomains via crt.sh
                 → Recommends: web-analyst for each

# 5. Investigation continues until puzzle is solved
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
| Hierarchical orchestration | **Flat autonomous agents** |
| Limited cipher support | **50+ cipher types** |
| No ARG-specific ciphers | **Gaster, Standard Galactic, etc.** |

---

## Community Cross-Reference

After completing their own investigation, agents cross-reference with:

- **Reddit**: r/ARG, r/gamedetectives, r/codes, r/cicada
- **Game Detectives Wiki**: wiki.gamedetectives.net
- **ARGNet**: argn.com
- **Unfiction**: forums.unfiction.com

This identifies **novel discoveries** the community may have missed.

---

**Author:** Kevin Lin
**Version:** 1.2.0

*"The truth is out there... hidden in LSBs, spectrograms, and Base64."*
