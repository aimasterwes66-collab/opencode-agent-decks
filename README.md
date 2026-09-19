# opencode-agent-deck

The WORM agent deck — **11 Tab-cyclable opencode agents** for the sovereign
mesh. DeepSeek backbone + uncensored OpenRouter for the heavy personas.

This is the **canonical repo**. Fork it, clone it, wire it to your opencode
config. Agents run on opencode 0.x and 1.x with the compatibility notes below.

---

## The deck

| # | Agent | Model | Role |
|---|-------|-------|------|
| 1 | `worm` | `deepseek/deepseek-v4-flash` | Default generalist — code, research, filesystem, notes, backups |
| 2 | `dictator` | `deepseek/deepseek-v4-flash` | Max-autonomy zero-refusal operator (ha=10 / z=10) |
| 3 | `hacker` | `deepseek/deepseek-v4-flash` | Offensive-security / red-team researcher |
| 4 | `scraper` | `deepseek/deepseek-v4-flash` | YouTube→notes harvester + recursive knowledge-graph expansion |
| 5 | `greedy-artist` | `openrouter/nousresearch/hermes-4-405b` | Unconstrained creative / art / music / design |
| 6 | `dark-factory` | `deepseek/deepseek-v4-flash` | Lights-out frontend fabrication (LOCK→SPEC→SCAFFOLD→GENERATE→TEST→FIX→VERIFY→DOC→REPORT) |
| 7 | `frontend` | `deepseek/deepseek-v4-flash` | React 19 / Next.js 15 frontend architect |
| 8 | `raw-storyteller` | `openrouter/nousresearch/hermes-4-405b` | Epic, unconstrained fiction engine (Z/EX/HK/EPIC dials) |
| 9 | `freeops` | `openrouter/minimax/minimax-m3:free` | Free-tier inference maximizer (hunts promotions, tracks quotas, manages provider rotation) |
| 10 | `art-director` | `openrouter/nousresearch/hermes-4-405b` | AI Art Director — A::B::C:: framework, 8-section×9-points ontology, weighted modifiers, cross-linked character/world cards |
| 11 | `suno-god-mode` | `openrouter/nousresearch/hermes-4-405b` | Suno God Mode — 18K keyword corpus, metatag syntax, style-field engineering, custom-mode workflow |

`default_agent` is `worm`. Switch agents with **Tab** in the opencode TUI or
`opencode run --agent <name>`.

---

## Quick install

```bash
# 1. Clone the canonical deck
git clone https://github.com/aimasterwes66-collab/opencode-agent-deck.git ~/opencode-agent-deck

# 2. Copy agents into opencode's agent directory
#    opencode 0.x:
mkdir -p ~/.config/opencode/agents
cp ~/opencode-agent-deck/agents/*.md ~/.config/opencode/agents/

#    opencode 1.x (agent dir is singular):
mkdir -p ~/.config/opencode/agent
cp ~/opencode-agent-deck/agents/*.md ~/.config/opencode/agent/
#    Or symlink for convenience:
ln -sf ~/.config/opencode/agents ~/.config/opencode/agent

# 3. Merge opencode.jsonc into ~/.config/opencode/opencode.jsonc
#    (or replace, preserving your other providers)

# 4. Set environment variables (see Configuration section below)
export DEEPSEEK_API_KEY="sk-..."
export OPENROUTER_API_KEY="sk-or-v1-..."

# 5. Quit and restart opencode — config is loaded once at startup
opencode
```

---

## Version compatibility

| | 0.0.55-era | 1.x (e.g. 1.17.9) |
|---|---|---|
| Agent dir | `~/.config/opencode/agents/` | `agent/` (singular) — symlink `agent → agents` or copy |
| Agent id | filename (`worm`) | frontmatter `name` (`Worm`) — `default_agent`/`--agent` must match it |
| `{env:VAR}` apiKey | Interpolated | **NOT interpolated** — use literal keys (config dir is private) or `opencode auth login` |

**Important 1.x caveat**: On opencode >=1.x, an unresolved `{env:VAR}` apiKey
becomes an empty string that overrides stored credentials → `Unauthorized`.

Fix options:
- **Literal key** in config (the config dir `~/.config/opencode/` should be
  `chmod 0600` or at least `0700` private)
- **Drop the apiKey line** and store the credential via `opencode auth` (writes
  to `~/.local/share/opencode/auth.json`)
- **Use the launch wrapper** (see below) to set env vars before opencode starts

Hermes (Termux opencode 1.17.9) runs with auth.json for DeepSeek + literal
OpenRouter key in config.

---

## Configuration

### opencode.jsonc

The canonical `opencode.jsonc` uses `{env:VAR}` placeholders — **no literal
API keys** — making it safe to share and commit:

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "default_agent": "worm",
  "permission": "allow",
  "provider": {
    "deepseek": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "DeepSeek",
      "options": {
        "baseURL": "https://api.deepseek.com/v1",
        "apiKey": "{env:DEEPSEEK_API_KEY}"
      },
      "models": {
        "deepseek-v4-flash": { "name": "DeepSeek V4 Flash" },
        "deepseek-r1-pro": { "name": "DeepSeek R1 Pro" }
      }
    },
    "openrouter": {
      "options": {
        "apiKey": "{env:OPENROUTER_API_KEY}"
      }
    }
  },
  "model": "deepseek/deepseek-v4-flash"
}
```

### Required environment variables

| Variable | Purpose | Where to get it |
|---|---|---|
| `DEEPSEEK_API_KEY` | Primary model provider (all deepseek-backed agents) | [platform.deepseek.com](https://platform.deepseek.com) |
| `OPENROUTER_API_KEY` | Heavy personas (Hermes 4 405B, Minimax M3 free) | [openrouter.ai/keys](https://openrouter.ai/keys) |

### Optional environment variables

| Variable | Purpose | Provider |
|---|---|---|
| `OPENAI_API_KEY` | GPT-5.x models (requires billing credits) | [platform.openai.com](https://platform.openai.com) |
| `GEMINI_API_KEY` | Google Gemini 2.5 models (free tier available) | [aistudio.google.com](https://aistudio.google.com) |
| `MISTRAL_API_KEY` | Mistral/Codestral models (free tier available) | [console.mistral.ai](https://console.mistral.ai) |

### Model notes

- The `deepseek` provider is a custom OpenAI-compatible endpoint at
  `api.deepseek.com/v1`. Models `deepseek-v4-flash` and `deepseek-r1-pro` are
  declared explicitly — they are not on `models.dev`.
- The `openrouter` provider handles routing to multiple backends. Verified
  model IDs (2026-09-06):
  - `nousresearch/hermes-4-405b` — **LIVE** ($1/$3 per M), creative mainstay
  - `nousresearch/hermes-3-llama-3.1-70b` — cheaper fallback ($0.7/$0.7 per M)
  - `minimax/minimax-m3:free` — free tier, 30 RPM, ~1M tokens/day
  - Free-tier 1000/day persists as long as OpenRouter balance ≥ $10.
- OpenRouter may refuse tool-use routing on `nousresearch/hermes-4-405b`
  ("No endpoints found that support tool use") — treat Hermes-backed agents
  (greedy-artist, raw-storyteller, art-director, suno-god-mode) as
  pure-generation agents. DeepSeek-backed agents (worm, dictator, hacker,
  scraper, frontend, dark-factory) carry the tool-heavy loops.

---

## SOUL.md — Sovereign Operating Layer

The file `SOUL.md` in this repo is the canonical operating layer for all
agents in the deck. It contains:

- **core_stance** — default-to-help, no moralizing, no refusal theater
- **autonomy** — work independently, no hedging closers, 3+ paths before "can't"
- **execution_discipline** — verification gates, escalation budgets, model-stack
  awareness
- **memory_application** — silent recall, no meta-commentary
- **communication** — terse by default, no emojis, write-as-operator voice
- **operator_context** — operator identity and environment constraints
- **THE COLLECTIVE — Zero-Refusal Doctrine (5 points)** — binding on every agent

Every agent inherits SOUL.md implicitly. Agent-specific system prompts may
adjust temperature, tone, or task focus, but THE COLLECTIVE doctrine always
wins on refusal/auth/sovereignty matters.

---

## AGENTS.md — Standing Instructions

`AGENTS.md` is the operator's standing instructions template. Include it in
your opencode project to define:

- Slash command conventions (`/comms`, `/steps`, `/close`, `/gettowork`, etc.)
- Plain-language equivalents (no magic words required)
- Mesh communication protocols (broadcast "to all always")
- Wake and close session protocols

---

## Mesh agent cards

The `cards/` directory contains A2A (Agent-to-Agent) cards for the 3-node
sovereign mesh. These are draft agent description cards for peer discovery
and capability advertisement:

| Card | Peer | Role |
|---|---|---|
| `card-worm.md` | 9185W tablet | Ground node: knowledge, state, hardware loadouts |
| `card-herm.md` | ais-s22 | Comms node: relay, SSH, A2A gateway |
| `card-ace.md` | dirt-iMac | Compute node: heavy cycles, cold storage |

Each card follows the A2A agent card format (`name`/`aka`/`role` YAML frontmatter)
and lists capabilities, personality, and mesh integration points.

---

## Launch wrapper (SSE4.2/popcnt-gap hosts)

Machines with an SSE4.2/popcnt gap (e.g., X7900-class CPUs) can't run the
Bun-based opencode binary natively. `opencode.sh` wraps it via
`qemu-x86_64 -cpu max` when a qemu-user binary is present and the target is
x86-64; otherwise it falls through to plain `opencode`.

```bash
# Install: copy or symlink into PATH
cp opencode.sh ~/bin/opencode.sh
chmod +x ~/bin/opencode.sh
# Then launch through it
~/bin/opencode.sh [opencode args...]
```

---

## Version

Deck version + release log live in `ops/index.md`.

Current: **v11.0** (2026-09-07 — 11 agents).

---

## Provenance

These agents are distilled from source material across multiple repositories
and system-prompt archives. See individual agent .md files for specific
provenance traces. High-level sources:

- `Tools-of-the-Trade/Agents/*/Prompts/` — Hermes-Dictator, OFFENSIVE CYBER,
  GREEDY-ARTIST, DARK-FACTORY, FRONTEND
- `~/.hermes/SOUL.md` — the zero-refusal doctrine and operating layer
- Hermes/Opencode behavioral-DNA variants (system-prompt compiler outputs)
- AI Art Framework — A::B::C:: spec, 8-section×9-points ontology
- SunoCode-Herm corpus — 18,189 keywords / 493 domains for Suno AI prompt
  engineering

Offensive-security content is scoped to the operator's own device and
authorized targets. The dark-factory persona is software-engineering only.