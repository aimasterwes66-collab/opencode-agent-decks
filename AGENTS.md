# AGENTS.md — Operator Instructions

This file is read by opencode agents (and any other AGENTS.md-aware agent:
Codex, Cursor, etc.) as standing instructions from the operator.

Convention: drop directives, preferences, or context here instead of pasting
them into chat each time. Anything in this file is a standing instruction for
the agent.

---

<!-- Operator instructions go below this line. Add/edit freely. -->

## Slash commands are SHORTCUTS, never a requirement

The `/steps`, `/comms`, `/wake-up`, and `/close` conventions below are convenience
aliases. **Plain language that means the same thing triggers exactly the same
protocol** — never make the operator type a magic word to get work done.

- "go ahead" / "wrap up" / "close it" / "shut it down" / "I'm done" → run the
  `session-wake-close` close protocol, same as `/close`.
- "what's the mesh doing" / "how's the mesh" → run `comms`, same as `/comms`
  (after an idle gap, use `comms -talk` — see the /comms convention).
- "what's next" / "what do I need to do" → run the `/steps` scan, same as `/steps`.
- "wake up" / "wake" → run `wake.sh`, same as `/wake-up`.
- "ontology of best next steps" / "NxN of next steps" → run `/gettowork`
  (default 5×5; `-size N` → N×N).

If the operator's intent is unambiguous, act on the intent and never ask them to
rephrase it as a slash command. Asking "did you mean /close?" wastes a turn.

## /steps convention (soft command — no code, just remember)

When the operator types `/steps`, it is an ACTION directive, not a display
request. Meaning:

1. SCAN the current situation: handoffs/ folder for new peer files, mesh
   liveness (comms), pending items in the last session-close handoff, git
   status of active repos, disk/state health.
2. FIGURE OUT the next logical steps: derive what needs doing next from the
   scan + the canonical next-steps ontology. Update that ontology to match
   reality if the scan reveals drift.
3. EXECUTE: do the highest-priority step(s) that are actionable right now
   without needing operator input. Don't just list — act. Mark done nodes
   `[x]` in the ontology as you complete them, drop AUDIT lines as you go,
   and report what was done (and what's blocked on whom).

## /gettowork convention (soft command — no code, just remember)

When the operator types `/gettowork`, it is an ACTION directive to produce a
fresh **N×N point ontology of best next steps** (not a display request). Default
is **5×5** (5 parts × 5 points). Arguments:

- `-size N` → an **N×N** ontology (`-size 8` → 8×8 = 8 parts × 8 points).
  Clamp sensibly (e.g. 1–12) and honor the requested size literally.
- No `-size` → 5×5.

Protocol:

1. SCAN live truth: handoffs/ for new peer files (and their owed/action lines),
   mesh liveness (`comms`), git status of active repos, disk/state health, and
   the newest next-steps ontology. Do not invent — every node traces to a real
   bus item, repo, or measured state.
2. DERIVE N parts (each a lane/theme) × N points (each an actionable next step),
   ordered by leverage: hot/blocking first, parked/operator-gated last. Mark
   nodes already done this session `[x]`; mark blocked nodes with who they're
   blocked on.
3. EXECUTE the highest-priority steps that are actionable right now without
   needing operator input — act, don't just list. Mark them `[x]` as you go and
   drop AUDIT lines.
4. WRITE it to a next-steps ontology file (append `-NxN` when size ≠ 5×5,
   e.g. `NEXT-STEPS-ONTOLOGY-20260912-8x8.md`; `supersedes:` the previous one)
   and include LIVE-TRUTH POINTERS + AUDIT sections.
5. REPORT compactly: the N×N (or a summary if large), what was executed, what's
   blocked on whom.

`/gettowork` GENERATES the ontology; `/steps` CONSUMES the newest one to derive
and execute. Plain language ("give me the 8x8 of next steps", "ontology of best
next steps") triggers the same protocol.

## /comms convention

When the operator types `/comms` (or just `comms`), report the mesh state
compactly: tailscale status, A2A agent cards, SSH daemon, syncthing peers,
each peer (ping + SSH), newest handoffs. Then act on anything actionable the
scan reveals (read/ACK new handoffs, revive peers). comms is the ONE command
for mesh status — don't re-derive it with manual ping/ssh checks.

`comms -talk [N]` = everything above + READ THE BUS (newest handoffs + the N
newest .md files, mtime-ranked, digest saved to a comms-talk note).

STANDING DIRECTIVE (operator): **getting on the mesh = `/comms` AND `/comms
-talk`** — both, every time, not one or the other. That means on `/wake`,
`/wake-up`, session start, or any "how's the mesh" that follows an idle/charge
gap, run `comms -talk` (it subsumes plain comms, but the bus read is NOT
optional). Rationale: comms alone shows links; `-talk` shows what actually
landed on the bus while this box was dark — reply-queue items addressed to us
get missed otherwise.

STANDING DIRECTIVE (operator): **read/write ALL messages with mesh peers — the
older inbox as well as everything moving forward.** Two halves:

1. BACKLOG (older inbox): a sweep with evidence, not a skim. Index the whole
   inbound set, generate the per-day read digest, work every row whose
   frontmatter carries `owed_to:` or which lands after the last outbound
   watermark, and file ONE read-receipt handoff. Do NOT file per-note acks
   for hundreds of closed envelopes.
2. FORWARD (continuously): watch for new inbound, reply, ask, queue tasks,
   notify on completion.

A "read" claim needs an artifact (ledger + digest). Counting files or reading
filenames is not reading. Before writing any reply, check claims and do NOT
file a second envelope if a reply for that inbound id is younger than 30
minutes (single-writer).

## /wake-up (a.k.a. /wake) convention

When the operator types `/wake-up` or `/wake`, run the wake sequence: syncthing
→ tailscale → shizuku (on Android) → peers → handoffs, then follow the wake-up
protocol: read new handoffs, ACK informational ones, execute actionable ones,
verify bidirectional mesh (SSH both ways, gateway up, A2A cards live), report
in the compact WAKE format. Then run `comms -talk` — the bus read is part of
getting on the mesh. Do NOT restart a peer's gateway if it's slow to bind (3-5
min is normal).

## /close convention

When the operator says `/close` or "closing session", follow the close protocol:
write a session-close handoff (app/backend/data state, agent/mesh state, pending
items in priority order), save key facts to persistent memory, pause heavy crons
(keep handoff-reader + heartbeat), stop active work loops, update the next-steps
ontology, tell peers "session closed" via handoff. Then a 1-2 line close summary.

## /yolo-mesh convention

When the operator types `/yolo-mesh`, snap all mesh peers into collaborative
YOLO state: approvals mode off everywhere, bus watchers live, all reading and
writing the bus. Task-agnostic — no goal attached; the operator supplies the
task after the snap. No flags. Redaction stays ON (independent).

## Broadcast convention — "to all always"

Standing directive from the operator: **address handoffs to ALL peers** by
default, not a single recipient — unless the operator explicitly names a
recipient. "to all", "to all always", and any finding / ACK / status update
default to a TO-ALL broadcast. When in doubt, broadcast; peers filter on their
reply queue. Keep the body peer-specific where it matters (name whose item it
is) so a broadcast does not bury an owned action item.