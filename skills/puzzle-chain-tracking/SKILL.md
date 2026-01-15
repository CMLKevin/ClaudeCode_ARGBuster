---
name: puzzle-chain-tracking
description: This skill should be used when tracking multi-stage ARG puzzles, managing investigation state, documenting puzzle dependencies, or when the user mentions "puzzle chain", "next clue", "investigation progress", "what did we find", or needs help maintaining ARG investigation context.
version: 1.0.0
---

# Puzzle Chain Tracking Skill

Methodology for tracking multi-stage ARG investigations.

## Investigation Log Template

Create at `~/Downloads/ARG_Investigation/reports/investigation-log.md`:

```markdown
# ARG Investigation: [Name]

**Started**: [date]
**Status**: Active / Completed

## Puzzle Chain

### Stage 1: [Name]
- **Source**: Where found
- **Type**: web/image/audio/crypto
- **Solution**: How solved
- **Result**: What it revealed
- **Points To**: Next stage

### Stage 2: [Name]
(continue pattern...)

## Unsolved Elements
- [ ] Element A: Description
- [ ] Element B: Description

## Connections Map
```
Stage 1 → Stage 2 → Stage 3
    ↘
     Stage 4 → Stage 5
```

## Dead Ends
| Attempted | Result |
|-----------|--------|
| robots.txt | Empty |

## Evidence Inventory
| Item | Type | Status |
|------|------|--------|
| page.html | Source | Analyzed |
```

## Cross-Reference Checklist

When you solve a puzzle, check if the answer:
- [ ] Is a URL (navigate to it)
- [ ] Is a password (try on locked content)
- [ ] Contains coordinates (look up location)
- [ ] Is a username (search social media)
- [ ] Is another encoding (decode further)

## Puzzle Dependency Patterns

| Stage Type | Often Unlocks |
|------------|---------------|
| Website analysis | Hidden paths, encoded messages |
| Image stego | Passwords, coordinates, URLs |
| Audio spectrogram | Images, text, coordinates |
| Cipher solve | Passwords, next-stage URLs |
| OSINT | Background story, timelines |

## Progress Indicators
- ✅ Solved
- 🔄 In Progress
- ❓ Blocked
- ❌ Dead End
