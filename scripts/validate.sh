#!/usr/bin/env bash
set -euo pipefail

CONFIG="${1:-/etc/suricata/suricata.yaml}"

if ! command -v suricata >/dev/null 2>&1; then
  echo "ERROR: suricata is not installed or not in PATH." >&2
  exit 1
fi

if [[ ! -f "$CONFIG" ]]; then
  echo "ERROR: Suricata configuration not found: $CONFIG" >&2
  exit 1
fi

echo "Testing Suricata configuration: $CONFIG"
sudo suricata -T -c "$CONFIG"

echo "Suricata configuration test completed successfully."
