# Installation and Setup

This guide describes how to reproduce the isolated Suricata training lab. Values marked as examples must be adapted to the actual VM network and interface.

## 1. Host requirements

A practical starting point is:

- 16 GB host RAM
- 4+ CPU cores
- 60–100 GB free disk space
- Oracle VirtualBox
- Internet access for installing software

You do not need every VM running simultaneously.

## 2. Create the isolated VirtualBox network

Create a Host-Only network in VirtualBox Network Manager. The verified lab used the `192.168.100.0/24` range.

```text
Network: 192.168.100.0/24
Mask:    255.255.255.0
```

Attach the lab VMs to the same isolated Host-Only network. Do not use Bridged Adapter for intentionally vulnerable machines.

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

The verified lab used Suricata `8.0.3`.

## 4. Configure Suricata

The repository provides `config/suricata-lab.yaml.example` as a reference. Adapt it rather than replacing a distribution configuration blindly.

In the verified lab:

```text
HOME_NET  = 192.168.100.0/24
interface = enp0s3
```

Do not assume these values match another VM installation. Confirm the interface with `ip addr`.

## 5. Enable EVE JSON

Ensure the full Suricata configuration has EVE JSON enabled and includes the required event types. The verified alert log was:

```text
/var/log/suricata/eve.json
```

## 6. Install the repository rules

From a clone of this repository:

```bash
chmod +x scripts/setup-rules.sh
sudo ./scripts/setup-rules.sh
```

The script installs `config/local.rules` to:

```text
/etc/suricata/rules/local.rules
```

Ensure `local.rules` is listed in the full configuration's `rule-files` section.

## 7. Validate before restart

```bash
sudo ./scripts/validate.sh
```

Equivalent direct command:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
```

A successful validation must report that the configuration was successfully loaded.

## 8. Start Suricata

```bash
sudo systemctl restart suricata
sudo systemctl status suricata --no-pager
```

The service should show `active (running)`.

## 9. Verify packet visibility

On the Ubuntu sensor:

```bash
sudo tcpdump -ni enp0s3
```

Generate benign authorized lab traffic from Kali. If the sensor sees no relevant traffic, fix the VirtualBox topology before troubleshooting signatures.

## 10. Monitor EVE JSON

```bash
sudo ./scripts/monitor-alerts.sh
```

Or:

```bash
sudo tail -f /var/log/suricata/eve.json
```

Only test against intentionally vulnerable systems inside the isolated lab.