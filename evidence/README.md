# Verification Evidence

This directory contains concise, reproducible evidence documentation for the isolated Suricata NIDS lab.

## What belongs here

Store documentation and sanitized evidence only:

- verification summaries
- screenshots with no credentials or sensitive host data
- test-result notes
- sanitized alert excerpts

## What does not belong here

Do not commit:

- VM images (`.ova`, `.vdi`, `.vmdk`, etc.)
- private credentials or secrets
- `.env` files
- raw runtime logs containing unrelated sensitive data
- unrestricted PCAP captures
- personal data from unrelated systems

The repository `.gitignore` already excludes common runtime logs, packet captures, secrets, and VM disk images.

## Verified lab state

The project session verified the core Suricata detection pipeline in an isolated lab and confirmed the expected custom SIDs in EVE JSON.

See [`verified-results.md`](verified-results.md) for the summarized results.