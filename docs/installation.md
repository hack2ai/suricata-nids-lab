# Installation and Setup

This guide turns the repository into an isolated Suricata training lab.

## 1. Host requirements

A practical starting point is:

- 16 GB host RAM
- 4+ CPU cores
- 60–100 GB free disk space
- Oracle VirtualBox
- Internet access for installing software

You do not need every VM running simultaneously.

## 2. Create the isolated VirtualBox network

Create a Host-Only network in VirtualBox Network Manager.

Example:

```text
Network:       192.168.56.0/24
Host address:  192.168.56.1
Mask:          255.255.255.0
DHCP:          Enabled
```

Attach lab VMs to the same Host-Only network. Do not use Bridged Adapter for intentionally vulnerable machines.

## 3. Install Suricata on Ubuntu

```bash
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt update
sudo apt install -y suricata jq
```

Verify:

```bash
suricata --version
suricata --build-info
sudo systemctl status suricata
```

## 4. Configure Suricata

The example settings are in `config/suricata-lab.yaml.example`.

Set `HOME_NET` to the actual lab subnet and configure the real capture interface. The example assumes:

```text
HOME_NET = 192.168.56.0/24
interface = enp0s3
```

Do not assume these values match every VM.

## 5. Enable EVE JSON

Ensure EVE logging includes at least:

```yaml
outputs:
  - eve-log:
      enabled: yes
      filetype: regular
      filename: eve.json
      types:
        - alert
        - http
        - dns
        - tls
        - flow
```

## 6. Add the custom rules

Copy or adapt `config/local.rules` to the Suricata rules directory, normally:

```bash
sudo cp config/local.rules /etc/suricata/rules/local.rules
```

Ensure the full Suricata configuration loads `local.rules` in its `rule-files` section.

## 7. Validate before restart

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
sudo systemctl restart suricata
sudo systemctl status suricata
```

If the service fails:

```bash
sudo journalctl -u suricata --no-pager -n 100
```

## 8. Update standard rules

```bash
sudo suricata-update
sudo ls -lh /var/lib/suricata/rules/
sudo systemctl restart suricata
```

## 9. Verify packet visibility

Before testing signatures:

```bash
sudo tcpdump -ni enp0s3
```

Generate harmless traffic from the authorized lab machine. If no packets appear, fix the VirtualBox network topology first.

## 10. Monitor EVE JSON

```bash
sudo tail -f /var/log/suricata/eve.json
```

Alerts only:

```bash
sudo tail -f /var/log/suricata/eve.json | \
  jq 'select(.event_type=="alert")'
```
