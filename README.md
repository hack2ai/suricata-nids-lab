# Suricata NIDS Lab

![Suricata](https://img.shields.io/badge/Suricata-NIDS-orange)
![VirtualBox](https://img.shields.io/badge/VirtualBox-Lab-blue)
![CI](https://github.com/hack2ai/suricata-nids-lab/actions/workflows/validate-rules.yml/badge.svg)
![License](https://img.shields.io/badge/License-MIT-green)

A virtualized Network Intrusion Detection System (NIDS) training lab using **Suricata**, **Kali Linux**, **Metasploitable 2**, **DVWA**, **Typhoon 1.02**, custom Suricata signatures, and **EVE JSON** logging.

> **Safety boundary:** Run scans and attack simulations only against intentionally vulnerable systems in an isolated lab. Never expose vulnerable VMs to a home, college, office, or public network.

## Project status

The core lab detection pipeline has been verified in the isolated environment. Six custom detection signatures were exercised and their expected alerts were observed in EVE JSON. Repository rule validation is also covered by GitHub Actions.

## Verified environment

| Item | Verified value |
|---|---|
| Suricata | `8.0.3` |
| Lab network | `192.168.100.0/24` |
| Capture interface | `enp0s3` |
| EVE JSON | `/var/log/suricata/eve.json` |
| Custom rules | `/var/lib/suricata/rules/local.rules` |

## Architecture

```text
                         HOST COMPUTER
                              |
                         Oracle VirtualBox
                              |
                  ISOLATED NIDS LAB NETWORK
                       192.168.100.0/24
                              |
        +---------------------+---------------------+
        |                     |                     |
        v                     v                     v
      KALI                WINDOWS             UBUNTU + SURICATA
  authorized tests       victim VM              IDS sensor
        |                     |                     |
        +---------------------+---------------------+
                              |
                 +------------+------------+
                 |            |            |
                 v            v            v
           METASPLOITABLE    DVWA       TYPHOON
          vulnerable target  web target  vulnerable target
                              |
                              v
                           eve.json
                              |
                              v
                           jq / SIEM
```

The addresses shown above are documentation values for the verified lab network. Adapt IPs and interfaces to the actual VirtualBox environment.

## Detection coverage

| SID | Detection | Test / marker | Verified |
|---:|---|---|:---:|
| `1000001` | Possible TCP SYN Scan | Authorized Nmap SYN scan | ✅ |
| `1000010` | Possible Command Injection | `cmd-lab` | ✅ |
| `1000011` | Possible Directory Traversal | URL-encoded `../` marker | ✅ |
| `1000012` | Possible XSS Marker | `xss-lab` | ✅ |
| `1000013` | Possible SQL Injection | `sql-lab` | ✅ |
| `1000014` | Possible File Inclusion | `include-lab` | ✅ |

These are educational signatures. The HTTP rules use harmless training markers rather than real exploitation payloads, and the SYN rule is a simple threshold-based reconnaissance detector.

## Repository structure

```text
suricata-nids-lab/
├── config/
│   ├── local.rules
│   └── suricata-lab.yaml.example
├── docs/
│   ├── architecture.md
│   ├── installation.md
│   ├── testing.md
│   └── verification-matrix.md
├── lab/
│   ├── network-topology.md
│   └── test-scenarios.md
├── scripts/
│   ├── monitor-alerts.sh
│   ├── setup-rules.sh
│   └── validate.sh
├── evidence/
│   ├── README.md
│   └── verified-results.md
├── .github/
│   └── workflows/
│       └── validate-rules.yml
├── .gitignore
├── LICENSE
└── README.md
```

## Quick start

### Install Suricata on Ubuntu

```bash
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt update
sudo apt install -y suricata jq
```

### Install the repository's local rules

```bash
sudo ./scripts/setup-rules.sh
```

Ensure `local.rules` is included by the full `/etc/suricata/suricata.yaml` configuration.

### Validate the configuration

```bash
sudo ./scripts/validate.sh
```

### Monitor alerts

```bash
sudo ./scripts/monitor-alerts.sh
```

## Testing workflow

1. Keep the intentionally vulnerable systems on an isolated Host-Only network.
2. Confirm packet visibility with `tcpdump`.
3. Validate the Suricata configuration before restarting the service.
4. Generate authorized test traffic from Kali to isolated targets.
5. Confirm the expected signature ID appears in EVE JSON.

See [`docs/testing.md`](docs/testing.md) for the complete workflow and [`evidence/verified-results.md`](evidence/verified-results.md) for the verified results summary.

## CI validation

The GitHub Actions workflow at `.github/workflows/validate-rules.yml` installs Suricata and validates the repository rule file on changes to `config/local.rules` or the workflow itself.

## Scope and evidence hygiene

This repository excludes VM images, PCAP files, runtime logs, credentials, secrets, and other environment-specific sensitive artifacts. Screenshots and exported logs should be sanitized before publication.

## Future upgrade path

A natural next stage is:

**network traffic → IDS → signatures → alerts → logs → SIEM → SOC dashboard**

A SIEM such as Wazuh can be added later for centralized alert triage and visualization.

## License

MIT — see [`LICENSE`](LICENSE).
