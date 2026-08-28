# Testing

All tests in this document are intended for the isolated NIDS lab and authorized targets only.

## Packet visibility

On the Ubuntu/Suricata sensor:

```bash
sudo tcpdump -ni enp0s3
```

Generate benign lab traffic and confirm packets are visible before continuing.

## Configuration test

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
```

A successful configuration test is required before restarting the service.

## TCP SYN scan training detector

The repository rule uses SID `1000001` and a threshold of 20 SYN packets from one source within 10 seconds.

From the authorized Kali lab machine, target only the isolated Metasploitable VM:

```bash
nmap -sS -p 1-1000 <METASPLOITABLE_IP>
```

Expected alert:

```text
NIDS LAB Possible TCP SYN Scan
SID: 1000001
```

This is an educational signature, not a production-quality Nmap detector.

## Web training markers

The HTTP rules use harmless markers so the detection pipeline can be tested without relying on real exploitation.

| SID | Marker | Expected alert |
|---:|---|---|
| 1000002 | `msf-lab-test` | Metasploit Training Marker |
| 1000010 | `cmd-lab` | Possible Command Injection |
| 1000011 | `../` | Possible Directory Traversal |
| 1000012 | `xss-lab` | Possible XSS Marker |
| 1000013 | `sql-lab` | Possible SQL Injection |
| 1000014 | `include-lab` | Possible File Inclusion |

Send these markers only to the authorized DVWA/training application in the isolated lab.

## Monitor alerts

```bash
sudo tail -f /var/log/suricata/eve.json | \
  jq -c 'select(.event_type=="alert") | {
    timestamp,
    src_ip,
    dest_ip,
    src_port,
    dest_port,
    signature:.alert.signature,
    sid:.alert.signature_id,
    severity:.alert.severity
  }'
```

## Troubleshooting order

1. Confirm the VMs are on the intended isolated network.
2. Confirm the target is reachable from the authorized test VM.
3. Confirm `tcpdump` sees the relevant traffic.
4. Validate `suricata.yaml` with `suricata -T`.
5. Confirm `local.rules` is loaded.
6. Restart Suricata and inspect `journalctl` if needed.
7. Only then troubleshoot individual signatures.
