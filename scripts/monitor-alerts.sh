#!/usr/bin/env bash
set -euo pipefail

EVE_FILE="${1:-/var/log/suricata/eve.json}"

if [[ ! -f "$EVE_FILE" ]]; then
  echo "ERROR: EVE JSON file not found: $EVE_FILE" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq is not installed." >&2
  exit 1
fi

sudo tail -F "$EVE_FILE" | jq -c 'select(.event_type=="alert") | {timestamp,src_ip,dest_ip,src_port,dest_port,signature:.alert.signature,sid:.alert.signature_id,severity:.alert.severity}'
