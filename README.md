# Claude Code Plugin Collection

A curated collection of Claude Code plugins, commands, agents, skills, and hooks for development workflows.

This repository is a maintained distribution/fork of plugin material and is **not an official Anthropic repository**. Original copyright and upstream attribution remain unchanged where applicable.

## Repository layout

```text
.
├── agent-sdk-dev/
├── claude-opus-4-5-migration/
├── code-review/
├── commit-commands/
├── explanatory-output-style/
├── feature-dev/
├── frontend-design/
├── hookify/
├── learning-output-style/
├── plugin-dev/
├── pr-review-toolkit/
├── ralph-wiggum/
├── security-guidance/
├── claude-plugin/
├── docs/
└── tools/
```

Plugin packages remain self-contained. Repository-level documentation and developer tooling are separated from plugin runtime content.

## Installation

```bash
npm install -g @anthropic-ai/claude-code
claude
```

The marketplace definition is located at `claude-plugin/marketplace.json`.

## DevContainer

```powershell
.\tools\devcontainer\run_devcontainer.ps1 -Backend docker
```

or:

```powershell
.\tools\devcontainer\run_devcontainer.ps1 -Backend podman
```

## Maintenance principles

1. Keep plugin paths consistent with the distribution layout.
2. Keep development tooling under `tools/`.
3. Prefer small, readable scripts over duplicated shell logic.
4. Do not commit generated archives or build artifacts.
5. Preserve upstream copyright and licensing information.
6. Validate JSON, Markdown, PowerShell, hooks, and plugin manifests before publishing changes.

## Licensing

See `LICENSE.md` for the applicable license and `SECURITY.md` for security reporting guidance.
