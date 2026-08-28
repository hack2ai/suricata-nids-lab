# Test Scenarios

These scenarios are for the isolated lab only. They use harmless training markers where practical.

## Scenario 1 — Packet visibility

**Goal:** prove that the Suricata sensor can see lab traffic.

1. Start Suricata/Ubuntu.
2. Run `sudo tcpdump -ni <IDS_INTERFACE>`.
3. Generate benign traffic from Kali to an authorized lab target.
4. Confirm packets arrive at the sensor.

## Scenario 2 — TCP SYN detection

**Goal:** verify SID `1000001`.

- Source: Kali
- Target: Metasploitable 2
- Activity: authorized SYN scan against the isolated target
- Expected: `NIDS LAB Possible TCP SYN Scan`

## Scenario 3 — HTTP training markers

**Goal:** verify application-layer signature matching.

Use the authorized DVWA/training target and send requests containing these markers:

- `msf-lab-test` → SID `1000002`
- `cmd-lab` → SID `1000010`
- `../` → SID `1000011`
- `xss-lab` → SID `1000012`
- `sql-lab` → SID `1000013`
- `include-lab` → SID `1000014`

## Scenario 4 — EVE JSON verification

**Goal:** verify that alerts reach structured logging.

```bash
sudo tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'
```

For a detected event, confirm the signature name and signature ID correspond to the rule that was exercised.
