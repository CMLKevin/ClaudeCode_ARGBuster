---
description: Start comprehensive ARG investigation on a URL, file, or text
argument-hint: [URL, file path, or encoded text]
allowed-tools:
  - Read
  - Write
  - Bash
  - WebFetch
  - WebSearch
  - Task
  - TodoWrite
  - Glob
  - Grep
model: opus
---

# ARG Investigation Command

You are initiating a comprehensive ARG (Alternate Reality Game) investigation.

**Target**: $ARGUMENTS

## Output Directory

All outputs will be saved to `~/Downloads/ARG_Investigation/`

```bash
# Create timestamped investigation directory
INVESTIGATION_DIR=~/Downloads/ARG_Investigation/$(date +%Y%m%d-%H%M%S)-investigation
mkdir -p "$INVESTIGATION_DIR"/{spectrograms,extracted,reports,logs}
echo "Investigation directory: $INVESTIGATION_DIR"
```

## Investigation Protocol

### Phase 1: Target Identification

Determine the target type:
- **URL**: Website requiring web analysis + OSINT
- **Image file**: Steganography + media forensics
- **Audio file**: Spectrogram + media forensics
- **Text**: Cryptanalysis/decoding
- **Other file**: Media forensics

### Phase 2: Create Investigation Plan

Use TodoWrite to create a systematic investigation plan based on target type.

### Phase 3: Deploy Specialized Agents

Based on target type, launch appropriate agents using the Task tool:

**For URLs/Websites:**
```
Launch in parallel:
1. Task with subagent_type="arg-investigation:web-analyst"
   - Analyze page source, hidden elements, JavaScript
2. Task with subagent_type="arg-investigation:osint-recon"
   - Research domain, WHOIS, DNS, certificates
```

**For Images:**
```
Launch in parallel:
1. Task with subagent_type="arg-investigation:stego-analyst"
   - LSB extraction, color channel analysis
2. Task with subagent_type="arg-investigation:media-forensics"
   - Metadata, binwalk, QR/OCR detection
```

**For Audio:**
```
Launch in parallel:
1. Task with subagent_type="arg-investigation:stego-analyst"
   - Spectrogram generation, frequency analysis
2. Task with subagent_type="arg-investigation:media-forensics"
   - Metadata, format validation
```

**For Encoded Text:**
```
Launch:
1. Task with subagent_type="arg-investigation:crypto-decoder"
   - Multi-encoding detection and decryption
```

### Phase 4: Synthesize Findings

After agent completion:
1. Read files created by agents in `$INVESTIGATION_DIR`
2. Cross-reference findings for patterns
3. Identify puzzle chains and dependencies
4. Determine if follow-up analysis needed

### Phase 5: Generate Report

Create comprehensive investigation report at:
`$INVESTIGATION_DIR/reports/investigation-report.md`

Include:
- Evidence catalog with status
- Key findings from each analysis domain
- Decoded content
- Puzzle chain state (if applicable)
- Prioritized next steps
- Blockers requiring human insight

## Quick Start Commands

For different target types:

```bash
# URL investigation
/arg https://mysterious-arg.com

# Image analysis
/arg /path/to/suspicious-image.png

# Audio analysis
/arg /path/to/audio-clue.mp3

# Text decoding
/arg "SGVsbG8gV29ybGQ="
```

## Remember

- Always save outputs to `~/Downloads/ARG_Investigation/`
- Document everything - even dead ends provide information
- Check for layered encoding in all decoded content
- Cross-reference findings across different analysis types
- ARGs reward systematic, thorough investigation
