# Verification Matrix

| Test | Source | Target | Expected result | Repository reference |
|---|---|---|---|---|
| TCP SYN scan | Kali | Metasploitable 2 | Recon alert / SID 1000001 | `config/local.rules` |
| Metasploit training marker | Kali | Lab web target | SID 1000002 | `config/local.rules` |
| Command injection marker | Kali | DVWA | SID 1000010 | `config/local.rules` |
| Directory traversal marker | Kali | DVWA | SID 1000011 | `config/local.rules` |
| XSS marker | Kali | DVWA | SID 1000012 | `config/local.rules` |
| SQL injection marker | Kali | DVWA | SID 1000013 | `config/local.rules` |
| File inclusion marker | Kali | DVWA | SID 1000014 | `config/local.rules` |

## Completion checklist

- [ ] VirtualBox installed
- [ ] Isolated Host-Only network created
- [ ] Ubuntu Server imported
- [ ] Suricata installed
- [ ] Suricata configuration validated
- [ ] `HOME_NET` configured
- [ ] AF_PACKET interface configured
- [ ] EVE JSON enabled
- [ ] Suricata rules updated
- [ ] Kali configured
- [ ] Windows configured
- [ ] Metasploitable 2 imported
- [ ] DVWA deployed
- [ ] Typhoon imported
- [ ] Packet visibility confirmed with `tcpdump`
- [ ] Nmap test completed
- [ ] Nmap alert verified
- [ ] Local rules created and loaded
- [ ] Web training rules tested
- [ ] EVE JSON alerts verified
- [ ] Lab confirmed isolated from the normal network

## Expected detection pipeline

```text
Authorized test traffic
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
Rule engine / signature match
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
