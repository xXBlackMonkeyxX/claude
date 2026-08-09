# Repository Architecture

The repository separates three concerns: self-contained plugin packages, marketplace metadata, and repository-level tooling/documentation.

```text
.
├── <plugin-packages>/              # Self-contained plugin packages
├── claude-plugin/                  # Marketplace metadata
├── docs/                           # Repository documentation
│   └── architecture/               # Structure and conventions
└── tools/                          # Developer tooling
    └── devcontainer/               # DevContainer helpers
```

Plugins stay self-contained because their internal paths are part of their distribution contract. Repository-wide scripts and documentation are kept outside plugin runtime content.
