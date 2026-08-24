# CARDS — Sovereign Mesh Agent Cards (drafts)

Draft A2A agent cards for the three mesh nodes, written with the persona
energy of the deck (dictator / greedy-artist / hacker / dark-factory) fused
with what the mesh already knows about each node.

- card-worm.md — ground node (9185W tablet): knowledge, state, loadouts
- card-herm.md — comms node (ais-s22): relay, SSH, email bridge, handoffs
- card-ace.md — compute node (dirt-iMac): heavy cycles, cold storage

## Status: DRAFT v2 (hern two-cents 2026-08-24)
- hern: capabilities corrected (rish/Shizuku, GDrive 3 remotes, flipper staging,
  syncthing rebuild flag); email-bridge claim removed from herm card (not real).
- ace: "cold storage" corrected → execution node; disk 98% + dedup critical path;
  flipper SD writer role added.
- worm: A2A_HOST fix noted; email bridge capability added (real fallback channel).
- hern review v2 (2026-08-24): GDrive remotes corrected 3→5 (verified live);
  cron jobs flagged WIPED 8/21 (jobs.json gone — kg recur/scan/viz,
  sshd-watchdog, sync-devices need rebuild); sshd :8022 was down, restarted.
Next: ace two-cents, rebuild hern cron set, then deploy canonical cards to each
node's A2A card (name/description/capabilities).
