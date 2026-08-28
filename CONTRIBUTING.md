# Contributing

Thank you for contributing to the Suricata NIDS Lab.

## Scope

Contributions should improve the isolated cybersecurity training lab, its documentation, reproducibility, rule quality, testing workflow, or defensive analysis.

## Before contributing

- Keep intentionally vulnerable systems isolated from normal and public networks.
- Do not include credentials, API keys, session cookies, private data, VM images, unrestricted PCAPs, or runtime logs containing sensitive information.
- Prefer harmless training markers for rule demonstrations rather than real exploitation payloads.

## Changes to Suricata rules

For new or modified rules:

1. Give the rule a unique SID in the repository's educational SID range.
2. Add a clear comment describing the rule's purpose.
3. Keep the rule focused and explain any protocol keywords used.
4. Update the relevant testing and verification documentation.
5. Run the local validation before opening a pull request:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
```

GitHub Actions also validates `config/local.rules` when the relevant files change.

## Documentation changes

Keep examples explicit about which values are environment-specific. The verified lab used `192.168.100.0/24` and `enp0s3`, but other environments may use different subnets and interfaces.

## Pull requests

A useful pull request should include:

- a concise description of the change
- the reason for the change
- relevant test or validation results
- documentation updates when behavior changes

Do not claim a detection was verified unless the corresponding test has actually been performed.

## Reporting problems

For security-sensitive issues, follow [`SECURITY.md`](SECURITY.md) rather than publishing secrets or sensitive lab data in an issue.