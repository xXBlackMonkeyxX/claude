# Repository Architecture

The repository separates self-contained plugin packages from marketplace metadata and repository-level tooling.

```text
.
├── <plugin-packages>/              # Self-contained plugin packages
├── claude-plugin/                  # Marketplace metadata
├── docs/                           # Repository documentation
│   └── architecture/               # Structure and conventions
└── tools/                          # Developer tooling
    └── devcontainer/              # DevContainer helpers
```

Plugins remain self-contained because their internal paths are part of their distribution contract. Repository-wide scripts and documentation stay outside plugin runtime content.
