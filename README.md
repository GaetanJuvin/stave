# Stave

A reusable project template for **Harness Engineering** with [Claude Code](https://claude.ai/claude-code) — Anthropic's CLI agent for software development.

> **Harness Engineering** is a methodology where humans steer and agents execute. The engineer's role shifts from writing code to designing environments, specifying intent, and building feedback loops that allow Claude to do reliable work.

## What's Inside

Clone this repo to bootstrap any new project with a complete agent-friendly documentation and tooling structure.

```
CLAUDE.md                    # Map/TOC — Claude's entry point (~100 lines)
ARCHITECTURE.md              # System layers, dependency rules, module layout

docs/
├── design-docs/             # Design decisions and rationale
│   ├── index.md             # Catalog of all design docs
│   ├── core-beliefs.md      # Golden principles / agent-first rules
│   └── TEMPLATE.md          # Template for new design docs
├── exec-plans/              # Versioned execution plans
│   ├── active/              # Plans currently in progress
│   ├── completed/           # Done plans (for reference)
│   ├── tech-debt-tracker.md # Tech debt log with priority tracking
│   └── TEMPLATE.md          # Template for new plans
├── product-specs/           # Product specifications
│   ├── index.md             # Catalog of all specs
│   └── TEMPLATE.md          # Template for new specs
├── references/
│   └── design-system.md     # Design system reference
├── DESIGN.md                # Design patterns and conventions
├── FRONTEND.md              # Frontend architecture and conventions
├── QUALITY_SCORE.md         # Quality grades per domain/layer
├── RELIABILITY.md           # Reliability standards and SLOs
└── SECURITY.md              # Security policies and boundaries

.claude/
├── settings.json            # Claude Code settings with hooks
└── commands/
    ├── review.md            # /review — self-review before PR
    ├── cleanup.md           # /cleanup — garbage collection scan
    └── plan.md              # /plan — create execution plan

scripts/
└── lint-architecture.sh     # Architectural boundary linting

.github/workflows/
└── claude-review.yml        # Claude-powered PR review CI
```

## Quick Start

1. **Clone the template**
   ```bash
   git clone https://github.com/GaetanJuvin/stave.git my-project
   cd my-project
   ```

2. **Find-and-replace `[PROJECT_NAME]`** across all files with your project name

3. **Customize the architecture** — edit `ARCHITECTURE.md` with your actual layers, domains, and tech stack

4. **Fill in the design system** — update `docs/references/design-system.md` with your colors, typography, and components

5. **Set your quality targets** — update `docs/RELIABILITY.md` with real SLOs and `docs/SECURITY.md` with your auth approach

6. **Start building** — Claude reads `CLAUDE.md` first and follows the map to deeper docs as needed

## Custom Commands

| Command | Purpose |
|---------|---------|
| `/review` | Self-review all changes before opening a PR |
| `/cleanup` | Scan for deviations from golden principles and tech debt |
| `/plan` | Create a versioned execution plan for complex tasks |

## Key Principles

1. **Repository is the source of truth** — if Claude can't read it, it doesn't exist
2. **`CLAUDE.md` is a map, not a manual** — ~100 lines pointing to deeper docs
3. **Enforce architecture mechanically** — linters and CI, not willpower
4. **Plans are first-class artifacts** — versioned and committed to the repo
5. **Corrections are cheap, waiting is expensive** — trust the guardrails, ship fast

Read the full methodology in [HARNESS_ENGINEERING.md](./HARNESS_ENGINEERING.md).

## Background

Adapted from [OpenAI's Harness Engineering](https://openai.com/index/harness-engineering/) methodology, translated for teams using Claude Code. See [COMPARISON_OMC.md](./COMPARISON_OMC.md) for how this compares to other Claude Code scaffolding approaches.

## License

MIT
