# Deep Review Status

## Critical issues

- PowerShell comment-block syntax corrected in the maintained launcher.
- External command failures are checked explicitly.
- Workspace container lookup rejects zero or multiple matches.
- Repository documentation now reflects the separated tooling and documentation areas.

## Compatibility

The legacy `Script/run_devcontainer_claude_code.ps1` entry point is retained as a wrapper while the maintained implementation lives under `tools/devcontainer/`.

## Release rule

A parser error, invalid marketplace metadata, or ambiguous runtime resource must block release until corrected.
