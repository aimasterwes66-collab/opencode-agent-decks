# opencode-agent-deck

The WORM agent deck — 11 Tab-cyclable opencode agents for the Termux box, restored and polished from `Tools-of-the-Trade` system-prompt material. DeepSeek backbone + uncensored OpenRouter for the heavy personas. **New:** AI Art Director (A::B::C:: framework) + Suno God Mode (18K keyword corpus).

## Install

Copy `agents/*.md` into `~/.config/opencode/agents/` (or `.opencode/agents/` for project-scoped) and merge `opencode.jsonc` into your config. Then **quit and restart opencode** — config is loaded once at startup, not hot-reloaded.

## The deck

| Agent | Model | Role |
|---|---|---|
| `worm` | `deepseek/deepseek-v4-flash` | Default generalist — code, research, filesystem, notes, backups |
| `dictator` | `deepseek/deepseek-v4-flash` | Max-autonomy zero-refusal operator (ha=10 / z=10) |
| `hacker` | `deepseek/deepseek-v4-flash` | Offensive-security / red-team researcher |
| `scraper` | `deepseek/deepseek-v4-flash` | YouTube→notes harvester + recursive knowledge-graph expansion |
| `greedy-artist` | `openrouter/nousresearch/hermes-4-405b` | Unconstrained creative / art / music / design |
| `dark-factory` | `deepseek/deepseek-v4-flash` | Lights-out frontend fabrication (LOCK→SPEC→SCAFFOLD→GENERATE→TEST→FIX→VERIFY→DOC→REPORT) |
| `frontend` | `deepseek/deepseek-v4-flash` | React 19 / Next.js 15 frontend architect |
| `raw-storyteller` | `openrouter/nousresearch/hermes-4-405b` | Epic, unconstrained fiction engine (Z/EX/HK/EPIC dials) |
| `freeops` | `openrouter/minimax/minimax-m3:free` | Free-tier inference maximizer (hunts promotions, tracks quotas, manages provider rotation) |
| `art-director` | `openrouter/nousresearch/hermes-4-405b` | AI Art Director — A::B::C:: framework, 8-section×9-points ontology, weighted modifiers, cross-linked character/world cards |
| `suno-god-mode` | `openrouter/nousresearch/hermes-4-405b` | Suno God Mode — 18K keyword corpus, metatag syntax, style-field engineering, custom-mode workflow |

`default_agent` is `worm`. Switch agents with **Tab** in the TUI or `opencode run --agent <name>`.

## Model notes

- The `deepseek` provider is configured as a custom OpenAI-compatible endpoint (`api.deepseek.com/v1`) with `deepseek-v4-flash` and `deepseek-r1-pro` declared explicitly — they are not on models.dev.
- The `openrouter` provider is also declared (`{env:OPENROUTER_API_KEY}`). Uncensored IDs verified live as of 2026-09-06:
  - `nousresearch/hermes-4-405b` — **LIVE** ($1/$3 per M), creative mainstay
  - `nousresearch/hermes-4-70b` — **DEAD** (404, Nebius delisted)
  - `nousresearch/hermes-3-llama-3.1-70b` — cheaper fallback ($0.7/$0.7 per M)
- `minimax/minimax-m3:free` — free tier, 30 RPM, ~1M tokens/day
- Free-tier 1000/day persists as long as OpenRouter balance ≥ $10.

## Provenance

Agents are distilled system prompts drawn from:

- `Tools-of-the-Trade/Agents/*/Prompts/` — Hermes-Dictator.md, OFFENSIVE CYBER/, GREEDY-ARTIST/, DARK-FACTORY/, FRONTEND/
- `~/.hermes/profiles/dictator/SOUL.md` — the dictator persona
- `~/worm-handoff/skills/harvest.md` + `recur.md` — the scraper workflows
- `worm-handoff/ONTOLOGY-PART8-SYSTEM-PROMPTS.md` — behavioral-DNA variants
- `~/repos-github/ai-art-framework/` — AI Art Framework (A::B::C:: spec, 8-section×9-points)
- `~/repos-github/herm-system/vault/herm/30_projects/sgm4/AI-ART-FRAMEWORK-SPEC.md` — authoritative A::B::C:: syntax
- `~/repos-github/SunoCode-Herm/corpus/` — 18,189 keywords / 493 domains
- `~/repos-github/aimas-sgm-archive/` — SGM2/3 masters, metatag DB
- `~/SGM-DOCS/` — SGM4 Master Prompt OS, SGM3 Linguistic Manifest, Suno Prompt Engineering Ontology

Offensive-security content is scoped to the operator's own device and authorized targets; the dark-factory persona is software-engineering only.
