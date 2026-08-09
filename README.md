# Claude Code Plugin Collection

A curated collection of Claude Code plugins, commands, agents, skills, and hooks for development workflows.

This repository is a maintained distribution/fork of plugin material and is **not an official Anthropic repository**. Original copyright and upstream attribution remain unchanged where applicable.

## Repository layout

```text
.
├── agent-sdk-dev/                 # Plugin package
├── claude-opus-4-5-migration/     # Plugin package
├── code-review/                   # Plugin package
├── commit-commands/               # Plugin package
├── explanatory-output-style/      # Plugin package
├── feature-dev/                   # Plugin package
├── frontend-design/               # Plugin package
├── hookify/                       # Plugin package
├── learning-output-style/         # Plugin package
├── plugin-dev/                    # Plugin package
├── pr-review-toolkit/             # Plugin package
├── ralph-wiggum/                  # Plugin package
├── security-guidance/             # Plugin package
├── claude-plugin/                 # Marketplace metadata
├── docs/                          # Architecture and documentation
└── tools/                         # Developer tooling
    └── devcontainer/              # DevContainer helpers
```

Plugin packages remain self-contained. Repository-level documentation and developer tooling are separated from runtime plugin content.

## Installation

```bash
npm install -g @anthropic-ai/claude-code
claude
```

The marketplace definition is located at `claude-plugin/marketplace.json`.

## Plugin structure

```text
plugin-name/
├── .claude-plugin/plugin.json
├── commands/
├── agents/
├── skills/
├── hooks/
├── .mcp.json
└── README.md
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
