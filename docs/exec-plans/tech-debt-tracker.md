# Tech Debt Tracker

> Track, prioritize, and resolve technical debt. Review this regularly during cleanup cycles.

## Priority Legend

| Priority | Meaning |
|----------|---------|
| **P0** | Critical — blocks feature work or causes incidents |
| **P1** | High — should be addressed this sprint/cycle |
| **P2** | Medium — address when working in the area |
| **P3** | Low — nice to have, address opportunistically |

## Status Legend

| Status | Meaning |
|--------|---------|
| **Open** | Identified, not yet started |
| **In Progress** | Actively being worked on |
| **Resolved** | Fixed and verified |

## Active Debt

| ID | Priority | Area | Description | Status | Owner | Created | Resolved |
|----|----------|------|-------------|--------|-------|---------|----------|
| TD-001 | | | | Open | | YYYY-MM-DD | |

<!-- Add new tech debt items above this line -->

## Resolved Debt

Move resolved items here for reference.

| ID | Priority | Area | Description | Owner | Created | Resolved |
|----|----------|------|-------------|-------|---------|----------|
| | | | | | | |

## Process

### Adding New Debt
1. Add a row to the Active Debt table with the next ID
2. Set priority based on impact and urgency
3. Open a PR to update this file

### Resolving Debt
1. Create a focused PR that addresses the debt
2. Update the status to "Resolved" and add the resolution date
3. Move the row to the Resolved Debt table
4. Open a PR to update this file

### Cleanup Cycle
Run `/cleanup` periodically to scan for undocumented tech debt. Add findings here.

---

*See `docs/exec-plans/` for execution plans. See `CLAUDE.md` for the full project map.*
