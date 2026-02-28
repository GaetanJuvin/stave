# Quality Score

> Quality grades per domain and layer. Updated during cleanup cycles.
> Use this to identify areas that need attention and track improvement over time.

## Grading Scale

| Grade | Meaning |
|-------|---------|
| **A** | Excellent — follows all conventions, well-tested, clean |
| **B** | Good — minor issues, mostly follows conventions |
| **C** | Acceptable — some technical debt, needs attention |
| **D** | Poor — significant issues, should be prioritized |
| **F** | Critical — actively causing problems, fix immediately |

## Domain Scores

| Domain | Types | Config | Repo | Service | UI | Overall | Last Reviewed |
|--------|-------|--------|------|---------|-----|---------|--------------|
| [domain-1] | — | — | — | — | — | — | YYYY-MM-DD |
| [domain-2] | — | — | — | — | — | — | YYYY-MM-DD |
| shared | — | — | — | — | — | — | YYYY-MM-DD |

## Cross-Cutting Scores

| Area | Grade | Notes | Last Reviewed |
|------|-------|-------|--------------|
| E2E test coverage | — | | YYYY-MM-DD |
| Unit/integration test coverage | — | | YYYY-MM-DD |
| Documentation | — | | YYYY-MM-DD |
| Error handling | — | | YYYY-MM-DD |
| Logging | — | | YYYY-MM-DD |
| Security | — | | YYYY-MM-DD |
| Performance | — | | YYYY-MM-DD |
| Accessibility | — | | YYYY-MM-DD |

## Recent Changes

| Date | Area | Change | Grade Before | Grade After |
|------|------|--------|-------------|-------------|
| | | | | |

## Process

### Reviewing Quality
1. Run `/cleanup` to scan for deviations from `docs/design-docs/core-beliefs.md`
2. Update grades based on findings
3. Add items to `docs/exec-plans/tech-debt-tracker.md` for anything below **B**
4. Open a PR with updated scores

### Improving Quality
1. Prioritize **D** and **F** grades
2. Create execution plans for improvements
3. Make targeted, focused changes
4. Re-score after changes are merged

---

*See `docs/exec-plans/tech-debt-tracker.md` for the debt backlog. See `CLAUDE.md` for the full project map.*
