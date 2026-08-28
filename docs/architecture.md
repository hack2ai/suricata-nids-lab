# Lab Architecture

## Logical flow

```text
Host Computer
     |
     v
Oracle VirtualBox
     |
     v
Isolated Host-Only NIDS LAB (example: 192.168.56.0/24)
     |
     +--> Kali Linux (.10) -------- authorized test traffic
     |
     +--> Windows (.20) ----------- victim endpoint
     |
     +--> Ubuntu + Suricata (.30) - IDS sensor
     |
     +--> Metasploitable 2 (.40) --- intentionally vulnerable target
     |
     +--> DVWA (.50) -------------- vulnerable web application
     |
     +--> Typhoon 1.02 (.60) ------ intentionally vulnerable target
                                      |
                                      v
                                  eve.json
                                      |
                                      v
                                  jq / SIEM
```

## Critical IDS concept

A passive NIDS does not automatically receive every packet exchanged by other VMs. Suricata must have packet visibility on the traffic path it is intended to inspect. Verify this with `tcpdump` before debugging rules.

## Example addressing

| System | Role | Example IP |
|---|---|---|
| Kali Linux | Authorized attacker/test system | `192.168.56.10` |
| Windows | Victim endpoint | `192.168.56.20` |
| Ubuntu + Suricata | NIDS sensor | `192.168.56.30` |
| Metasploitable 2 | Vulnerable target | `192.168.56.40` |
| DVWA | Web training target | `192.168.56.50` |
| Typhoon 1.02 | Vulnerable target | `192.168.56.60` |

IPs are examples; DHCP may assign different addresses.

## Safety boundary

Keep intentionally vulnerable VMs on an isolated lab network. Do not bridge them to a home, college, office, or public network.
