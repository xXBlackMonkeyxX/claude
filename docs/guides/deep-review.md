# Deep Review Baseline

This repository is maintained with a conservative review baseline:

1. Validate JSON and marketplace metadata before publishing.
2. Treat PowerShell parser errors as release blockers.
3. Check external command exit codes explicitly.
4. Keep plugin packages self-contained.
5. Keep repository tooling and documentation outside plugin runtime paths.
6. Do not commit generated archives, local environment files, logs, or temporary artifacts.
7. Preserve upstream license and attribution requirements.

The goal is predictable maintenance rather than unnecessary abstraction.
