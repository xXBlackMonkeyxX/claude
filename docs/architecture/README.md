# Repository Architecture

The repository is organized around two concerns: self-contained plugin packages and repository-level tooling/documentation.

```text
.
├── agent-sdk-dev/                 # Agent SDK plugin
├── claude-opus-4-5-migration/     # Model migration plugin
├── code-review/                   # Code review workflow
├── commit-commands/               # Git workflow automation
├── explanatory-output-style/      # Educational output hook
├── feature-dev/                   # Feature development workflow
├── frontend-design/               # Frontend design guidance
├── hookify/                       # Hook management
├── learning-output-style/         # Learning workflow
├── plugin-dev/                    # Plugin development toolkit
├── pr-review-toolkit/             # PR review agents
├── ralph-wiggum/                  # Iterative development workflow
├── security-guidance/             # Security hooks
├── claude-plugin/                 # Marketplace metadata
├── docs/                          # Repository documentation
└── tools/                         # Development and maintenance tooling
    └── devcontainer/              # DevContainer helpers
```

Plugin directories stay self-contained because their internal structure is part of their distribution contract. Repository tooling is separated from runtime plugin content.
