# Core Beliefs

> Golden principles that guide how we build software — for both humans and agents.
> These are the **non-negotiable** operating rules. When in doubt, defer to these.

## Agent-First Operating Rules

### 1. Repository Is the Source of Truth

If it's not in the repo, it doesn't exist. All decisions, conventions, and standards must be committed. Slack messages, verbal agreements, and meeting notes are ephemeral — they must be translated into documentation that Claude can read.

### 2. Validate at Boundaries, Trust Internally

All data crossing a system boundary (user input, API responses, database results) must be validated with schemas. Inside the boundary, trust the types — don't defensive-code everywhere.

### 3. Prefer Shared Utilities Over Hand-Rolled Helpers

Before writing a new utility, check `src/shared/utils/`. Duplicated helpers diverge over time and create inconsistency. One well-tested utility is better than three similar ones.

### 4. Make It Legible

Code, logs, errors, and documentation should teach the next reader — whether that reader is a human or an agent. Write error messages that explain what went wrong and suggest how to fix it.

### 5. Encode Taste as Code

When a pattern is repeated in code review feedback, promote it to a lint rule. When a convention is explained in documentation, verify it with a test. Documentation that can be verified should be.

### 6. Architecture Is Non-Negotiable

Layer rules and dependency directions are enforced mechanically. No "just this once" exceptions. The cost of one violation is every future violation it enables.

### 7. Small, Focused Changes

Prefer many small PRs over few large ones. Each PR should do one thing. This makes review faster, rollbacks safer, and agent work more predictable.

### 8. Corrections Are Cheap, Waiting Is Expensive

When agent throughput is high, it's faster to merge and fix-forward than to block on perfect review. Trust the architecture enforcement and test suite to catch structural issues. Reserve human judgment for product decisions and security.

### 9. Boring Technology Wins

Prefer well-documented, stable, widely-known libraries and patterns. Clever abstractions and bleeding-edge tools are harder for agents to model and harder for new team members to learn.

### 10. Test Like a Human

The best test proves the software works the way a real user experiences it. Invest primarily in **E2E tests** that drive a real browser — click buttons, fill forms, navigate pages, and verify what the user sees. Unit tests are a supporting layer for complex pure logic only. No snapshot tests. No testing implementation details. If a test doesn't correspond to something a user would do or notice, question whether it's worth writing.

### 11. Continuous Cleanup

Entropy is the default. Schedule regular cleanup: scan for deviations from these principles, update quality scores, and open targeted refactoring PRs. Prevention is cheaper than remediation.

---

## How to Use This Document

- **Before starting work:** Re-read the relevant principles
- **During code review:** Check changes against these beliefs
- **When adding a rule:** Open a PR to update this file — principles evolve
- **When a principle is violated:** Fix it, then add enforcement (lint rule, test, or CI check)

---

*See `docs/design-docs/index.md` for all design docs. See `CLAUDE.md` for the full project map.*
