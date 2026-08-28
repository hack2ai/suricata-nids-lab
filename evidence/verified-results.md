# Verified NIDS Test Results

## Verification status

The core detection pipeline was verified in the isolated NIDS lab before this repository documentation was created.

Environment verified during the lab session:

- Suricata: `8.0.3`
- Capture interface: `enp0s3`
- Lab network: `192.168.100.0/24`
- EVE JSON: `/var/log/suricata/eve.json`
- Custom rules: `/var/lib/suricata/rules/local.rules`

## Detection matrix

| SID | Detection | Training marker / test | Result |
|---:|---|---|:---:|
| `1000001` | TCP SYN Scan | Authorized Nmap SYN scan | PASS |
| `1000010` | Command Injection marker | `cmd-lab` | PASS |
| `1000011` | Directory Traversal marker | URL-encoded `../` marker | PASS |
| `1000012` | XSS marker | `xss-lab` | PASS |
| `1000013` | SQL Injection marker | `sql-lab` | PASS |
| `1000014` | File Inclusion marker | `include-lab` | PASS |

## Service and configuration checks

- `suricata -T -c /etc/suricata/suricata.yaml`: PASS
- Suricata systemd service: `active (running)`
- EVE JSON alert events: observed
- All six required detection SIDs: observed during testing

## Evidence interpretation

A PASS means the corresponding rule was exercised in the isolated training environment and the expected Suricata alert was observed. It does not mean the signature is a complete production-grade detector for the broader attack category.

In particular, the SYN scan signature is an educational threshold-based detector, while the HTTP signatures intentionally use harmless markers to test the detection and logging pipeline.

## Reproduction

Use the procedures in [`docs/testing.md`](../docs/testing.md). Only run tests against systems and networks that you own or are explicitly authorized to test.

## Evidence hygiene

Screenshots and logs added to this directory should be sanitized. Never publish credentials, session cookies, API keys, unrelated personal data, or sensitive network information.