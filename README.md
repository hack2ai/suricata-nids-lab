# Suricata NIDS Lab

![Suricata](https://img.shields.io/badge/Suricata-NIDS-orange)
![VirtualBox](https://img.shields.io/badge/VirtualBox-Lab-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A beginner-friendly, isolated VirtualBox Network Intrusion Detection System (NIDS) training lab using **Suricata**, **Kali Linux**, **Metasploitable 2**, **DVWA**, **Typhoon 1.02**, custom Suricata signatures, and **EVE JSON** logging.

> **Safety boundary:** Run scans and attack simulations only against intentionally vulnerable systems in an isolated lab. Never expose vulnerable VMs to a home, college, office, or public network.

## Architecture

```text
                         HOST COMPUTER
                              |
                         Oracle VirtualBox
                              |
                  ISOLATED NIDS LAB NETWORK
                       192.168.56.0/24
                              |
        +---------------------+---------------------+
        |                     |                     |
        v                     v                     v
      KALI                WINDOWS             UBUNTU + SURICATA
       .10                   .20                    .30
        |                     |                     |
        +---------------------+---------------------+
                              |
                 +------------+------------+
                 |            |            |
                 v            v            v
           METASPLOITABLE    DVWA       TYPHOON
                .40           .50          .60
                              |
                              v
                          eve.json
                              |
                              v
                          jq / SIEM
```

Example IP addresses are documentation values; DHCP may assign different addresses.

### Critical NIDS concept

A passive NIDS does **not** automatically see every packet exchanged by other VMs. Suricata requires packet visibility on the traffic path it is intended to inspect. Verify visibility with `tcpdump` before troubleshooting signatures.

## Components

| System | Role | Example IP |
|---|---|---|
| Kali Linux | Authorized attacker/test system | `192.168.56.10` |
| Windows | Victim endpoint | `192.168.56.20` |
| Ubuntu Server | Suricata NIDS sensor | `192.168.56.30` |
| Metasploitable 2 | Intentionally vulnerable target | `192.168.56.40` |
| DVWA | Vulnerable web application | `192.168.56.50` |
| Typhoon 1.02 | Intentionally vulnerable target | `192.168.56.60` |

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
├── .gitignore
├── LICENSE
└── README.md
```

## Custom detections

| SID | Detection | Type |
|---:|---|---|
| `1000001` | Possible TCP SYN Scan | Recon training detector |
| `1000002` | Metasploit Training Marker | Harmless HTTP marker |
| `1000010` | Possible Command Injection | HTTP training marker |
| `1000011` | Possible Directory Traversal | HTTP training marker |
| `1000012` | Possible XSS Marker | HTTP training marker |
| `1000013` | Possible SQL Injection | HTTP training marker |
| `1000014` | Possible File Inclusion | HTTP training marker |

The web signatures intentionally use harmless markers so the detection pipeline can be demonstrated without depending on real exploitation.

## Quick start

### Install Suricata

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

Make sure `local.rules` is included by the full `/etc/suricata/suricata.yaml` configuration.

### Validate

```bash
sudo ./scripts/validate.sh
```

### Monitor alerts

```bash
sudo ./scripts/monitor-alerts.sh
```

## Testing workflow

1. Keep the lab on an isolated Host-Only network.
2. Confirm packet visibility with `tcpdump`.
3. Validate the Suricata configuration.
4. Generate authorized test traffic from Kali to lab targets.
5. Confirm the expected SID appears in EVE JSON.

Detailed procedures are in [`docs/testing.md`](docs/testing.md) and the verification matrix in [`docs/verification-matrix.md`](docs/verification-matrix.md).

## Project scope

This repository intentionally excludes VM images, PCAP captures, runtime logs, credentials, secrets, and environment-specific sensitive artifacts. The repository contains configuration examples, custom rules, helper scripts, lab documentation, and verification procedures.

## Future upgrade path

The lab can be extended from:

**network traffic → IDS → signatures → alerts → logs → SIEM → SOC dashboard**

Possible next-stage components include a SIEM such as Wazuh and a dashboard for alert triage.

## License

MIT — see [`LICENSE`](LICENSE).
