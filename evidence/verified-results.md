# Verified NIDS Test Results

## Verification status

The core detection pipeline was verified in the isolated NIDS lab before this repository documentation was created.

## Verified environment

| Item | Verified value |
|---|---|
| Suricata | `8.0.3` |
| Capture interface | `enp0s3` |
| Lab network | `192.168.100.0/24` |
| EVE JSON | `/var/log/suricata/eve.json` |
| Custom rules | `/var/lib/suricata/rules/local.rules` |

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

- `sudo suricata -T -c /etc/suricata/suricata.yaml`: PASS
- Suricata systemd service: `active (running)`
- EVE JSON alert events: observed
- All six required detection SIDs: observed during testing
- GitHub Actions rule-validation workflow: PASS

## Evidence interpretation

A PASS means the corresponding rule was exercised in the isolated training environment and the expected Suricata alert was observed. It does not mean the signature is a complete production-grade detector for the broader attack category.

The SYN scan signature is an educational threshold-based detector. The HTTP signatures intentionally use harmless training markers to exercise application-layer matching and the alert/logging pipeline.

## Evidence checklist

- [x] Suricata configuration validated
- [x] Suricata service confirmed running
- [x] Packet visibility confirmed during lab testing
- [x] TCP SYN detection verified
- [x] Command-injection marker verified
- [x] Directory-traversal marker verified
- [x] XSS marker verified
- [x] SQL marker verified
- [x] File-inclusion marker verified
- [x] EVE JSON alerts verified
- [x] Repository rule-validation CI passed

## Screenshot evidence

Screenshots can be added under `evidence/screenshots/` after sanitizing credentials, cookies, usernames, unrelated personal information, and sensitive network details. This repository does not claim screenshot files are present until they are actually uploaded.

Recommended filenames:

```text
suricata-status.png
configuration-validation.png
syn-scan-alert.png
command-injection-alert.png
directory-traversal-alert.png
xss-alert.png
sql-alert.png
file-inclusion-alert.png
eve-json-alerts.png
github-actions.png
```

## Reproduction

Use the procedures in [`docs/testing.md`](../docs/testing.md). Run all tests only against systems and networks that you own or are explicitly authorized to test.

## Evidence hygiene

Never publish credentials, session cookies, API keys, unrelated personal data, or sensitive information from networks outside the isolated training environment.