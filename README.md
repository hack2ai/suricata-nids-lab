# Suricata NIDS Lab

A virtualized Network Intrusion Detection System (NIDS) training lab built around Suricata, Kali Linux, Metasploitable 2, DVWA, custom Suricata signatures, and EVE JSON alert logging.

## Lab architecture

- Kali Linux: attacker / test generator
- Ubuntu NIDS VM: Suricata 8.0.3 sensor
- Metasploitable 2: vulnerable target
- DVWA: web application training target
- Lab network: `192.168.100.0/24`
- Suricata capture interface: `enp0s3`
- Alert output: `/var/log/suricata/eve.json`

## Verified custom detections

| SID | Detection | Status |
|---:|---|:---:|
| 1000001 | TCP SYN Scan | ✅ |
| 1000010 | Command Injection marker | ✅ |
| 1000011 | Directory Traversal marker | ✅ |
| 1000012 | XSS marker | ✅ |
| 1000013 | SQL Injection marker | ✅ |
| 1000014 | File Inclusion marker | ✅ |

All listed detections were exercised in the isolated lab and observed in Suricata EVE JSON during validation.

## Repository layout

```text
config/       Suricata configuration and custom rules
scripts/      validation and monitoring helpers
docs/         setup, architecture, testing, and verification notes
lab/          lab topology and test scenarios
evidence/     verification evidence and results
```

## Important safety note

This repository documents an isolated cybersecurity training environment. Metasploitable and DVWA are intentionally vulnerable and should not be exposed to the public Internet. Use the procedures only on systems and networks you own or are explicitly authorized to test.

## Scope

This repository stores reproducible lab configuration, rule definitions, test markers, and documentation. Runtime log files, VM images, credentials, and other environment-specific or sensitive artifacts are intentionally excluded.
