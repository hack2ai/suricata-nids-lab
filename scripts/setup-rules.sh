#!/usr/bin/env bash
set -euo pipefail

RULE_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/config/local.rules"
RULE_DEST="/etc/suricata/rules/local.rules"

if [[ ! -f "$RULE_SOURCE" ]]; then
  echo "ERROR: rule file not found: $RULE_SOURCE" >&2
  exit 1
fi

sudo install -D -m 0644 "$RULE_SOURCE" "$RULE_DEST"
echo "Installed local rules to $RULE_DEST"
echo "Ensure local.rules is included in Suricata's rule-files configuration."
echo "Then validate with: sudo suricata -T -c /etc/suricata/suricata.yaml"
