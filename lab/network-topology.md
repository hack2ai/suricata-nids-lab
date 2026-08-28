# Network Topology

Example isolated Host-Only network:

```text
                    HOST COMPUTER
                         |
                    VirtualBox
                         |
              192.168.56.0/24
                  ISOLATED LAB
                         |
       +-----------------+------------------+
       |                 |                  |
       v                 v                  v
     KALI             WINDOWS          UBUNTU + SURICATA
      .10                .20                 .30
       |                 |                  |
       +-----------------+------------------+
                         |
             +-----------+-----------+
             |           |           |
             v           v           v
        METASPLOITABLE  DVWA      TYPHOON
             .40         .50         .60
                         |
                         v
                     eve.json
```

These IPs are examples. DHCP may assign different addresses.

## Isolation requirements

- Use a Host-Only network for the vulnerable lab machines.
- Do not use Bridged Adapter for intentionally vulnerable VMs.
- Verify the intended interface and subnet before starting tests.
- Treat all scan/exploitation simulations as authorized lab activity only.

## Packet visibility

A passive IDS needs a packet path or traffic copy. Having VMs on the same virtual network does not by itself guarantee that Suricata receives every packet. Confirm visibility with `tcpdump` on the Suricata interface before troubleshooting detection rules.
