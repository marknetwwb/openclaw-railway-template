#!/usr/bin/env bash
set -e
echo "[entrypoint] Starting OpenClaw..."
# 確保 data directory 存在（Railway volume 安全）
mkdir -p /data
chown -R openclaw:openclaw /data
chmod 700 /data
# 使用 global openclaw entry
if [ -z "$OPENCLAW_ENTRY" ]; then
 echo "[entrypoint] ERROR: OPENCLAW_ENTRY is not set"
 exit 1
fi
echo "[entrypoint] Using entry: $OPENCLAW_ENTRY"
exec node "$OPENCLAW_ENTRY"
