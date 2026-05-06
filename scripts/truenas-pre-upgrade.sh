#!/usr/bin/env bash
# Run this on TrueNAS before upgrading (via SSH or Shell in UI)
set -euo pipefail

SNAPSHOT_NAME="bigtank@pre-upgrade-$(date +%Y%m%d)"

echo "=== TrueNAS pre-upgrade checks ==="

echo ""
echo "[1/7] Saving TrueNAS config"
CONFIG_PATH="/mnt/bigtank/backups/truenas-config/truenas-config-$(date +%Y%m%d).tar"
sudo mkdir -p "$(dirname "$CONFIG_PATH")"
sudo tar -czf "$CONFIG_PATH" -C /data freenas-v1.db pwenc_secret
echo "OK — config saved to $CONFIG_PATH"

echo "  Triggering B2 cloud sync (task 1)..."
sudo midclt call cloudsync.sync 1 --job
echo "OK — config synced to B2"

echo ""
echo "[2/7] ZFS pool status"
sudo zpool status
echo ""

echo "[3/7] Active scrub check"
if sudo zpool status | grep -q "scrub in progress"; then
  echo "ERROR: scrub in progress — wait for it to finish before upgrading"
  exit 1
else
  echo "OK — no scrub running"
fi

echo ""
echo "[4/7] SMART status (mirror drives)"
for dev in /dev/sda /dev/sdc; do
  echo "--- $dev ---"
  sudo smartctl -H "$dev" | grep -E 'overall-health|PASSED|FAILED' || true
done

echo ""
echo "[5/7] Snapshotting bigtank dataset"
sudo zfs destroy -r "$SNAPSHOT_NAME" 2>/dev/null || true
sudo zfs snapshot -r "$SNAPSHOT_NAME"
echo "OK — snapshot created: $SNAPSHOT_NAME"

echo ""
echo "[6/7] Tailscale IP (verify this matches after upgrade)"
ip addr show | grep "100\." | grep -oE "100\.[0-9]+\.[0-9]+\.[0-9]+"

echo "[7/7] Reminder: Stop Jellyfin app in TrueNAS UI before proceeding"
echo ""
echo "=== Pre-checks done. Proceed to System → Update ==="
