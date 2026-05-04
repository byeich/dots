#!/usr/bin/env bash
# Run this on TrueNAS before upgrading (via SSH or Shell in UI)
set -euo pipefail

SNAPSHOT_NAME="tank@pre-upgrade-$(date +%Y%m%d)"

echo "=== TrueNAS pre-upgrade checks ==="

echo ""
echo "[1/6] ZFS pool status"
zpool status
echo ""

echo "[2/6] Active scrub check"
if zpool status | grep -q "scrub in progress"; then
  echo "ERROR: scrub in progress — wait for it to finish before upgrading"
  exit 1
else
  echo "OK — no scrub running"
fi

echo ""
echo "[3/6] SMART status (key drives)"
for dev in /dev/sda /dev/sdb; do
  echo "--- $dev ---"
  smartctl -H "$dev" | grep -E 'overall-health|PASSED|FAILED' || true
done

echo ""
echo "[4/6] Snapshotting tank dataset"
zfs snapshot -r "$SNAPSHOT_NAME"
echo "OK — snapshot created: $SNAPSHOT_NAME"

echo ""
echo "[5/6] Reminder: Stop Jellyfin app in TrueNAS UI before proceeding"
echo "[6/6] Reminder: Note Tailscale node IP/hostname before proceeding"
echo ""
echo "=== Pre-checks done. Proceed to System → Update ==="
