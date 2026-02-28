# [PROJECT_NAME]

> This file is the **map**, not the manual. Keep it under ~100 lines.
> Claude reads this first — it should orient, not overwhelm.

## Project Overview

[PROJECT_NAME] is [one-sentence description of what the project does].

**Stack:** [e.g., TypeScript, Next.js, PostgreSQL]
**Status:** [e.g., Active development, Maintenance, Pre-launch]

## Architecture

Read `ARCHITECTURE.md` for the full system map, layer rules, and dependency directions.

**Key rule:** Dependencies flow in one direction only:
```
Types → Config → Repo → Service → Runtime → UI
```

## Directory Map

```
CLAUDE.md                ← You are here (the map)
ARCHITECTURE.md          ← System layers, dependency rules, module layout
docs/
├── design-docs/         ← Design decisions and rationale
│   ├── index.md         ← Catalog of all design docs
│   └── core-beliefs.md  ← Golden principles / agent-first rules
├── exec-plans/          ← Versioned execution plans
│   ├── active/          ← Plans currently being worked on
│   ├── completed/       ← Done plans (for reference)
│   └── tech-debt-tracker.md
├── product-specs/       ← Product specifications
│   └── index.md         ← Catalog of all specs
├── references/          ← Design system, API docs, etc.
├── DESIGN.md            ← Design patterns and conventions
├── FRONTEND.md          ← Frontend architecture and conventions
├── QUALITY_SCORE.md     ← Quality grades per domain/layer
├── RELIABILITY.md       ← Reliability standards and SLOs
└── SECURITY.md          ← Security policies and boundaries
```

## Before You Start Working

1. **Read the relevant design doc** before modifying any module
2. **Check `ARCHITECTURE.md`** for layer rules — violations will be caught by linting
3. **Check `docs/exec-plans/active/`** for any in-progress plans related to your area
4. **Run `scripts/lint-architecture.sh`** before opening a PR

## Conventions

- All boundary data must be validated with schemas (e.g., Zod)
- No `console.log` in production code — use structured logging
- Follow naming conventions defined in `docs/DESIGN.md`
- Keep files under 300 lines; split if larger

## Common Workflows

### Starting a new feature
1. Check `docs/product-specs/` for the relevant spec
2. Create an execution plan: `/plan`
3. Implement in a feature branch or worktree
4. Self-review before PR: `/review`
5. Open PR with Claude-powered CI review

### Fixing a bug
1. Reproduce the bug — preferably with a browser-based E2E test, or an integration test
2. Implement the fix
3. Verify the fix by running the E2E test (use Brave MCP or browser tools)
4. Run `/review` to self-review
5. Open PR

### Cleaning up tech debt
1. Check `docs/exec-plans/tech-debt-tracker.md` for priorities
2. Run `/cleanup` to scan for deviations from golden principles
3. Make targeted changes; keep PRs small

## Quality Gates

- `npm run lint` — Code style and formatting
- `npm run typecheck` — Type safety
- `npm run test:e2e` — E2E / UI tests (primary — real browser, real flows)
- `npm run test` — Unit and integration tests (supporting)
- `scripts/lint-architecture.sh` — Architectural boundary enforcement

## Testing Philosophy

**Test like a human.** See `docs/DESIGN.md` for full details. In short:
- E2E tests via browser automation (Brave MCP, Claude MCP, Playwright) are the **primary** test layer
- Unit tests are a **supporting** layer for pure logic only
- No snapshot tests — ever

## Key Principles

See `docs/design-docs/core-beliefs.md` for the full list. The top three:

1. **Validate at boundaries, trust internally** — Don't defensive-code everywhere
2. **Prefer shared utilities over hand-rolled helpers** — Reduce duplication
3. **Make it legible** — Code, logs, and errors should teach the next reader (human or agent)

---

*This project follows the [Harness Engineering](./HARNESS_ENGINEERING.md) methodology.*
