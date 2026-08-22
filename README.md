# opencode-agent-deck

The WORM agent deck — 7 Tab-cyclable opencode agents for the Termux box, restored and polished from `Tools-of-the-Trade` system-prompt material. DeepSeek backbone + uncensored OpenRouter for the heavy personas.

## Install

Copy `agents/*.md` into `~/.config/opencode/agents/` (or `.opencode/agents/` for project-scoped) and merge `opencode.jsonc` into your config. Then **quit and restart opencode** — config is loaded once at startup, not hot-reloaded.

## The deck

| Agent | Model | Role |
|---|---|---|
| `worm` | `deepseek/deepseek-v4-flash` | Default generalist — code, research, filesystem, notes, backups |
| `dictator` | `openrouter/mistralai/mistral-large-2407` | Max-autonomy zero-refusal operator (ha=10 / z=10) |
| `hacker` | `openrouter/nousresearch/hermes-3-llama-3.1-70b` | Offensive-security / red-team researcher |
| `scraper` | `deepseek/deepseek-v4-flash` | YouTube→notes harvester + recursive knowledge-graph expansion |
| `greedy-artist` | `deepseek/deepseek-v4-flash` | Unconstrained creative / art / music / design |
| `dark-factory` | `openrouter/nousresearch/hermes-3-llama-3.1-70b` | 25-agent autonomous software-engineering orchestrator |
| `frontend` | `deepseek/deepseek-v4-flash` | React 19 / Next.js 15 frontend architect |

`default_agent` is `worm`. Switch agents with **Tab** in the TUI or `opencode run --agent <name>`.

## Model notes

- The `deepseek` provider is configured as a custom OpenAI-compatible endpoint (`api.deepseek.com/v1`) with `deepseek-v4-flash` and `deepseek-r1-pro` declared explicitly — they are not on models.dev.
- The `openrouter` provider is also declared (`{env:OPENROUTER_API_KEY}`). Uncensored IDs were verified against the OpenRouter catalog on 2026-08-22; dead IDs from earlier notes (`nous-hermes-2-mixtral-8x7b-dpo`, `*:abliterated`, dolphin-mixtral) were dropped in favor of live ones.

## Provenance

Agents are distilled system prompts drawn from:

- `Tools-of-the-Trade/Agents/*/Prompts/` — Hermes-Dictator.md, OFFENSIVE CYBER/, GREEDY-ARTIST/, DARK-FACTORY/, FRONTEND/
- `~/.hermes/profiles/dictator/SOUL.md` — the dictator persona
- `~/worm-handoff/skills/harvest.md` + `recur.md` — the scraper workflows
- `worm-handoff/ONTOLOGY-PART8-SYSTEM-PROMPTS.md` — behavioral-DNA variants

Offensive-security content is scoped to the operator's own device and authorized targets; the dark-factory persona is software-engineering only.
