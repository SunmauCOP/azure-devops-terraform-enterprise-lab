# Architecture Overview

The lab follows a landing-zone-inspired split:

- Management Hub owns shared monitoring, audit storage, and platform Key Vault.
- Network owns hub connectivity resources.
- Dev owns non-production workload resources.
- Prod owns production workload resources with stronger SKUs and governance.

Each environment is an independent Terraform root. This keeps state blast radius small and allows separate approval gates per subscription.
