#!/usr/bin/env sh
# opencode.sh — launch shim for opencode on SSE4.2/popcnt-gap hosts (X7900-class).
# Bridges the Bun/opencode binary gap via qemu-user. Confirmed method per
# collective memory note: qemu-x86_64 -cpu max runs Bun/opencode fine.
#
# Usage:  ./opencode.sh [opencode args...]   (or symlink into PATH)
# If qemu-user is absent OR the host already runs x86_64 without issue, this
# falls through to a direct `opencode` exec.
set -eu

QEMU="$(command -v qemu-x86_64 || true)"
OC_BIN="${OC_BIN:-opencode}"

# Only wrap when qemu exists AND the binary is x86_64 (file check best-effort)
needs_wrap=0
if [ -n "$QEMU" ]; then
    if command -v "$OC_BIN" >/dev/null 2>&1; then
        case "$(file -b "$(command -v "$OC_BIN")" 2>/dev/null || true)" in
            *x86-64*) needs_wrap=1 ;;
        esac
    fi
fi

if [ "$needs_wrap" -eq 1 ]; then
    exec "$QEMU" -cpu max "$(command -v "$OC_BIN")" "$@"
else
    exec "$OC_BIN" "$@"
fi
