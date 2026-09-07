# Agent Deck — ops index

Canonical deck version tracking for the opencode-agent-deck repo.

## Deck version

- **v11.0** — 2026-09-07, shipped to Ace per ace-20260907-013 §2.
- 11 agents total: worm, dictator, hacker, scraper, greedy-artist,
  raw-storyteller, frontend, dark-factory (original 8, verified 08-31),
  freeops (added 09-03), art-director + suno-god-mode (added 09-06).
- The 3 post-08-31 additions (freeops, art-director, suno-god-mode) are
  flagged as post-ask in the shipment note — ace's "8 agents" reference
  predates them (see TO-HERM-worm-deck-reconcile-20260907).
- Git HEAD: updated on each release below.

## Release log

| Date | Version | HEAD | Change |
|---|---|---|---|
| 2026-09-07 | v11.0 | (see git log) | Shipment release: wrapper shim + version stamp + README; repo canonical at github.com/aimasterwes66-collab/opencode-agent-deck |
| 2026-09-06 | v10.x | 552a4c5 | Model retune + art-director + suno-god-mode added |

## Verification

- Clone target (ace): `git clone https://github.com/aimasterwes66-collab/opencode-agent-deck.git`
  then `git rev-parse HEAD` — must equal origin main at ship time.
- Canonical = GitHub origin; local ~/opencode-agent-deck and the
  40_projects mirror are working copies.
