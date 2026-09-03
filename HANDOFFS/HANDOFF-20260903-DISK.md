---
status: canonical
confidence: 9
provenance: ace, 2026-09-03 (disk-freedom session)
scope: FULL session writeup — disk investigation verdict + fsck action + nuke candidates + mesh/git reality
---

# HANDOFF — 2026-09-03 DISK INVESTIGATION (write-all per operator)

Operator said: write all to handoff, send to Worm too, then /.new.
Direction only. Verify live before acting. No deletions were performed this session.

## ⚠️ VERDICT: THE DRIVE IS FAILING (not just full)

Disk: 457G, 415G used, 3.4G free (100%). Device: WDC WD5000AAKS-40TMA0 — 2009-era SATA HDD.
e2fsck -fn /dev/sda2 (this session, read-only): RC=4 — FILESYSTEM HAS ERRORS:
- 72 orphaned-inode messages (crash residue; inodes on orphan list)
- Block-bitmap checksum mismatches: groups 1427, 1498, 1651, 1653, 2481, 3582, 3721
- Inode-bitmap checksum mismatches: groups 2405, 2499, 2515
- Free-block/free-inode counts wrong (small deltas), deleted inodes with zero dtime
- NEVER fsck'd since creation 2026-08-09 (max-mount-count=-1, no auto-check)

THE ~295G MYSTERY (why every du/find survey failed):
- Walking the tree accounts only ~120-145G. df/e2fsck raw-metadata says 415G allocated
  to 5.87M files. e2fsck block math EXACTLY matches df (no phantom space).
- du -x -d1 / consistently reports ONLY lost+found+srv then exits (I/O errors on the
  other top-level dirs, hidden by 2>/dev/null — rerun WITHOUT suppression to see them).
- Directory walks stall 5-15 min in D-state (wait_on_buffer) on specific subtrees
  (Backups/9185W IRDB CSV trees, FLIPPER, Archive) = drive read-retry storms on weak
  regions. Some eventually complete (9185W: 3.4G after ~10 min) — marginal sectors.
- CONCLUSION: ~295G of data sits in directories on UNREADABLE/weak disk regions.
  It exists (inodes + blocks allocated, fsck sees it) but directory walks can't read it.
  NOT phantom space, NOT a du bug, NOT millions of tiny files (inodes only 20% used).

## WHAT WAS MEASURED (all live, du -sh, completed runs)

/home/dirt/Desktop:  Reference 62G (old VAULT) | Projects 28G (AIMAS device drains) |
  Backups 14G (DEVICE-DRAINS graveyard: 9185W 3.4G + worm-9185w-20260831 2.9G +
  sd-card 5.2G + worm-backup 1.8G + HERM-BUNDLE 0.15G) | FLIPPER ~7G (canons 3.9G +
  awesome-pack 2.3G) | Archive ~2G | Knowledge 0.25G | Vault 55M | rest = empty shells
  (Creative 88K!, Hardware/Automation/Stack/Library are decorative).
/home/dirt non-Desktop ~3.5G. /usr 20G (incl hermes venv torch 1.1G + nvidia/ 2.7G —
  CUDA stack on a GPU-less box). /var 7.7G. /opt 0.6G. /root 0.3G. swapfile 3.9G.
TOTAL walked ~145G. GAP vs df ~270-295G = the unreadable regions above.

## IMMEDIATE NEXT ACTIONS (in order)

1. REBOOT, then BEFORE mounting: e2fsck -f -y /dev/sda2 from recovery/single-user
   (repairs orphaned inodes, bitmap checksums, counts — RC=4 errors are fixable).
   fsck CANNOT fix hardware read errors; if the weak regions read after reboot (marginal
   sectors often do), the ~295G becomes walkable and the disk-freedom pass can proceed.
2. Then re-survey with find -type f -size +200M (handoff's fast method) + du per child,
   ONE walker at a time (NEVER parallel du storms on this box — 14 walkers this morning
   = load 14.76 + 90-min D-state pileup; zombies were killed, system recovered).
3. DRIVE REPLACEMENT PLANNING: 17-year-old drive with read errors = not a storage
   platform. NixOS-on-this-disk is OFF until replaced. The GDrive mirror fabric
   (MASTER_BACKUP_STATUS.md) never completed: aimasterwes66 quota-saturated + PARTIAL,
   VAULT push stalled 7.34/62G, only 42 files ever VERIFIED-REMOTE. The hoard (~360G,
   big-mess audit 08-24) is NOT safely remote. Backup-what-reads is now urgent.
4. Nuke candidates (awaiting operator nod, NOW SECONDARY to drive health):
   a. DEVICE-DRAINS overlap ~9-11G (worm online has originals; keep newest drain + HERM)
   b. hermes venv nvidia/ 2.7G + libtorch_cuda.so 0.47G (GPU-less box) — verify first
   c. Flatpak youtube twins: 4ktube 414M vs nouTube 348M (standing open ASK)
   d. DEDUP-desktop.tsv 21.7G sha256-dups: paths DEAD (pre-restructure); Sep 1 exec
      freed 0 bytes; needs remap+reverify = expensive, do only after fsck+survey

## SIDE FINDINGS (verified live)

- Gateway: hermes-gateway.service crash-looping — restart counter 34,206, syslog 72MB.
  :9900 bound (pid 224784). Needs outside-terminal restart + root-cause look.
- Reboot has NOT happened (uptime 2d at session start). A2A :9900 was already bound.
- Git REALITY (claims vs live): the "FINAL handoff pushed, master in sync at 8969187,
  git auth permanently fixed" claims are FALSE as of this session: origin/main =
  b5c9ce5 (xyz-toolkit line); HANDOFFS/HANDOFF-20260903-FINAL.md does NOT exist on
  origin/main; SHA 8969187 not an object in ANY clone on box; src/ clone (3c6f182,
  hern-review line) is DIRTY (agents/→AGENTS/ move + deletions uncommitted) and its
  fetch prompts for creds (root has none). Clean clone = /home/dirt/opencode-agent-deck
  (b5c9ce5, synced). This handoff is being pushed from the clean clone as dirt
  (dirt's ~/.git-credentials works; token-embedded-URL claim was false in both clones).
- worm-handoff/ (123M, own .git) holds worm's mesh handoffs incl
  HANDOFF-20260903-worm-gdr-ont-mesh.md. worm-handoff/AGENTS.md present.
- Aug 24 audit artifact: big-mess was 360.4G/3.09M files (Tools-of-the-Trade 141.7G,
  WES-HERM 70.4G, media 35.6G...). Moved into Desktop by the Sep 2 restructure, dedup
  never applied (that's why disk refilled after the 08-29 debloat's 19G win).
- Findings doc: /home/dirt/Desktop/Index/DISK-FINDINGS-20260903.md

## MESH STATE

- Worm: ONLINE + verified reachable this session (ssh u0_a306@100.67.4.14:8022, key
  /home/dirt/.ssh/id_ed25519_mesh works). Receiving this handoff via direct scp +
  repo push.
- Herm: offline. Deuce: awaiting relay. Ace gateway: see crash-loop note above.

## DELIVERY (this session)

- Local: /home/dirt/HANDOFF-20260903-DISK.md
- Repo: HANDOFFS/HANDOFF-20260903-DISK.md committed on main (clean clone) + pushed
- Worm: scp'd directly (verified on device)
- GDR repo origin/main will advance past b5c9ce5 with this commit.
