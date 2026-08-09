# Claude Code Plugin Collection

A curated collection of Claude Code plugins, commands, agents, skills, and hooks for development workflows.

> This repository is a maintained distribution/fork of plugin material. It is **not an official Anthropic repository**. Original licensing and required upstream attribution remain in force.

## Repository layout

```text
.
├── agent-sdk-dev/                 # Agent SDK development
├── claude-opus-4-5-migration/     # Model migration tooling
├── code-review/                   # Automated code review
├── commit-commands/               # Git workflow commands
├── explanatory-output-style/      # Educational output
├── feature-dev/                   # Feature development workflow
├── frontend-design/              # Frontend design guidance
├── hookify/                       # Hook creation and management
├── learning-output-style/         # Interactive learning workflow
├── plugin-dev/                    # Plugin development toolkit
├── pr-review-toolkit/             # Specialized PR review agents
├── ralph-wiggum/                  # Iterative development loops
├── security-guidance/             # Security guidance hooks
│
├── claude-plugin/                 # Marketplace metadata
│   └── marketplace.json
│
├── docs/                          # Repository documentation
│   ├── architecture/
│   └── guides/
│
└── tools/                         # Repository-level tooling
    ├── devcontainer/
    ├── validation/
    └── maintenance/
```

Plugins remain self-contained because their internal paths are part of their distribution contract. Repository-level tooling and documentation stay outside plugin runtime content.

## Included plugins

| Plugin | Purpose |
|---|---|
| `agent-sdk-dev` | Build and validate Claude Agent SDK applications |
| `claude-opus-4-5-migration` | Migrate prompts and code between supported model versions |
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

Install Claude Code:

```bash
npm install -g @anthropic-ai/claude-code
```

Start it from your project:

```bash
claude
```

The repository marketplace definition is available at `claude-plugin/marketplace.json`.

## DevContainer tooling

The maintained launcher is:

```powershell
.\tools\devcontainer\run_devcontainer.ps1 -Backend docker
```

or:

```powershell
.\tools\devcontainer\run_devcontainer.ps1 -Backend podman
```

The former `Script/run_devcontainer_claude_code.ps1` remains as a compatibility wrapper so existing workflows do not break abruptly.

## Maintenance baseline

1. Validate JSON, Markdown, PowerShell, hooks, and plugin manifests before publishing.
2. Check external command exit codes explicitly.
3. Keep plugin packages self-contained.
4. Keep repository-level tools and documentation separated from plugin runtime content.
5. Do not commit generated archives, local environment files, logs, or temporary artifacts.
6. Preserve upstream license and attribution requirements.

## Upstream and licensing

See `LICENSE.md` for the applicable license and `SECURITY.md` for security reporting guidance.

For current Claude Code documentation, use the official documentation at https://docs.claude.com/en/docs/claude-code/overview.
