# Lab Architecture

## Verified lab environment

The lab session used an isolated VirtualBox network in the `192.168.100.0/24` range. The exact VM addresses can vary by configuration, so the examples below are descriptive rather than hard-coded requirements.

```text
                         HOST COMPUTER
                              |
                         Oracle VirtualBox
                              |
                  ISOLATED HOST-ONLY NIDS LAB
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

## Critical IDS concept

A passive NIDS does not automatically receive every packet exchanged by other VMs. Suricata must have packet visibility on the traffic path it is intended to inspect. Verify this with `tcpdump` before debugging rules.

## Sensor configuration used in the verified lab

- Suricata version: `8.0.3`
- Capture interface: `enp0s3`
- Lab subnet: `192.168.100.0/24`
- EVE JSON: `/var/log/suricata/eve.json`
- Custom rules: `/var/lib/suricata/rules/local.rules`

## Detection pipeline

```text
Authorized lab traffic
        |
        v
VirtualBox isolated network
        |
        v
Suricata packet capture
        |
        v
Protocol decoding
        |
        v
Custom rule engine
        |
        v
Alert
        |
        v
eve.json
        |
        v
jq / SIEM / dashboard
```

## Safety boundary

Keep intentionally vulnerable VMs on an isolated lab network. Do not bridge Metasploitable, DVWA hosts, Typhoon, or other vulnerable systems to a home, college, office, or public network.