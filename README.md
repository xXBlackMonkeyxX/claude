# Claude Code Plugin Collection

A curated collection of Claude Code plugins, commands, agents, skills, and hooks for development workflows.

This repository is a maintained distribution/fork of plugin material and is **not an official Anthropic repository**. Original copyright and upstream attribution remain unchanged where applicable.

## Included plugins

| Plugin | Purpose |
|---|---|
| `agent-sdk-dev` | Build and validate Claude Agent SDK applications |
| `claude-opus-4-5-migration` | Migrate prompts and code to newer Claude model versions |
| `code-review` | Multi-agent pull-request review with confidence filtering |
| `commit-commands` | Streamline Git commit, push, and PR workflows |
| `explanatory-output-style` | Add educational implementation context |
| `feature-dev` | Structured feature-development workflow |
| `frontend-design` | Production-oriented frontend design guidance |
| `hookify` | Create and manage custom safety/productivity hooks |
| `learning-output-style` | Encourage active learning during implementation |
| `plugin-dev` | Create and validate Claude Code plugins |
| `pr-review-toolkit` | Specialized PR analysis for tests, errors, types, comments, and simplification |
| `ralph-wiggum` | Iterative development loops |
| `security-guidance` | Security-focused editing reminders |

## Installation

Install Claude Code first:

```bash
npm install -g @anthropic-ai/claude-code
```

Start Claude Code from your project:

```bash
claude
```

The included marketplace definition is located at `claude-plugin/marketplace.json`.

## Repository layout

```text
.
├── agent-sdk-dev/
├── claude-opus-4-5-migration/
├── claude-plugin/
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
└── Script/
```

Each plugin follows the Claude Code plugin conventions where applicable:

```text
plugin-name/
├── .claude-plugin/
│   └── plugin.json
├── commands/
├── agents/
├── skills/
├── hooks/
├── .mcp.json
└── README.md
```

Only directories that are required by a plugin are present.

## Maintenance principles

1. Keep plugin paths consistent with the repository layout.
2. Prefer small, readable scripts over duplicated shell logic.
3. Do not commit generated archives or build artifacts.
4. Keep upstream copyright and licensing information intact.
5. Validate JSON, Markdown, PowerShell, hooks, and plugin manifests before publishing changes.

## Upstream and licensing

This repository contains material derived from Claude Code plugin work. See `LICENSE.md` for the applicable license and `SECURITY.md` for security reporting guidance.

For current Claude Code documentation, use the official documentation at https://docs.claude.com/en/docs/claude-code/overview.
