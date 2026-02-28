# Harness Engineering for Claude Code

> Adapted from [OpenAI's Harness Engineering](https://openai.com/index/harness-engineering/) — their methodology for building software with AI agents. This document translates their principles for teams using **Claude Code** (Anthropic's CLI agent).

---

## Core Philosophy

**Humans steer. Agents execute.**

The engineer's role shifts from writing code to designing environments, specifying intent, and building feedback loops that allow Claude to do reliable work. The scarce resource is human time and attention — optimize everything around that.

---

## 1. Repository as the System of Record

### The Map, Not the Manual

Don't create one massive `CLAUDE.md`. Treat it as a **table of contents** (~100 lines) that points to deeper sources of truth.

**Why monolithic instructions fail with Claude:**
- Context is scarce — a giant file crowds out the task and relevant code
- When everything is "important," nothing is — Claude pattern-matches locally instead of navigating intentionally
- Monolithic files rot instantly and are hard to verify

### Recommended Structure

```
CLAUDE.md                    # ~100 lines, the map
ARCHITECTURE.md              # Top-level system map
docs/
├── design-docs/
│   ├── index.md
│   ├── core-beliefs.md      # Agent-first operating principles
│   └── ...
├── exec-plans/
│   ├── active/              # Current work
│   ├── completed/           # Done work (for reference)
│   └── tech-debt-tracker.md
├── product-specs/
│   ├── index.md
│   └── ...
├── references/
│   ├── design-system.md
│   └── ...
├── DESIGN.md
├── FRONTEND.md
├── QUALITY_SCORE.md         # Grades per domain/layer
├── RELIABILITY.md
└── SECURITY.md
```

### Progressive Disclosure

Claude starts with `CLAUDE.md` (small, stable entry point) and follows pointers to deeper docs as needed. This is how Claude Code's built-in `CLAUDE.md` system already works — lean into it.

### Keep It Fresh

- Use CI linters to validate docs are up-to-date and cross-linked
- Run periodic "doc-gardening" sessions where Claude scans for stale documentation and opens fix-up PRs
- Anything discussed in Slack/meetings that matters must be committed to the repo — if Claude can't see it, it doesn't exist

---

## 2. Enforce Architecture Mechanically

### Strict Boundaries, Local Autonomy

Define architectural layers with strictly validated dependency directions. Enforce with:

- **Custom linters** (have Claude write them)
- **Structural tests** that validate import/dependency rules
- **CI checks** that block violations

### Example: Domain Layer Architecture

```
Types → Config → Repo → Service → Runtime → UI
```

Each business domain follows the same layering. Cross-cutting concerns (auth, telemetry, feature flags) enter through explicit Provider interfaces.

### Claude-Specific Enforcement

```bash
# In CLAUDE.md, reference the rules:
# "Before modifying any module, read docs/ARCHITECTURE.md for layer rules"
# "All boundary data must be validated with Zod schemas"
# "Run `npm run lint:architecture` before opening a PR"
```

### Taste Invariants

Encode style and quality rules as lintable checks:
- Structured logging (no `console.log`)
- Naming conventions for schemas and types
- File size limits
- Platform-specific reliability requirements

**Write error messages that teach Claude how to fix the issue** — custom linters with remediation instructions in the error output.

---

## 3. Make the Application Legible to Claude

### Give Claude Eyes and Ears

The more Claude can directly observe and interact with the running system, the more autonomous it becomes:

| Capability | How to Enable |
|---|---|
| **UI Testing** | Wire Chrome DevTools Protocol — Claude can take screenshots, inspect DOM, navigate |
| **Logs** | Expose via local observability stack; Claude queries with structured log tools |
| **Metrics** | Expose via local metrics; prompts like "ensure startup < 800ms" become tractable |
| **Isolated Environments** | Boot app per git worktree so Claude gets its own instance per task |

### Claude Code Specifics

- Use `claude --worktree` to isolate work per feature
- Configure MCP servers to give Claude access to browser, databases, APIs
- Use hooks (`hooks` in `settings.json`) to run validation automatically on tool calls
- Write custom skills (`/commands`) that encapsulate complex workflows

---

## 4. Agent-to-Agent Review

### Push Review to Agents

Over time, shift review effort from human-only to agent-assisted:

1. **Self-review**: Instruct Claude to review its own changes before opening a PR
2. **Agent review**: Use Claude subagents or parallel agents to cross-review
3. **Human review**: Humans review only what agents flag or what's architecturally significant

### Review Loop Pattern

```
Claude writes code
  → Claude reviews its own changes
  → Opens PR
  → Another Claude agent reviews the PR
  → Responds to feedback
  → Iterates until reviewer is satisfied
  → Human spot-checks or approves
```

### With Claude Code

- Use the `superpowers:requesting-code-review` skill after completing work
- Use `superpowers:code-reviewer` agent for automated review
- Configure CI to run Claude-powered review on PRs via GitHub Actions

---

## 5. Plans as First-Class Artifacts

### Version Your Plans

Plans aren't throwaway — they're checked into the repo:

- **Lightweight plans**: For small changes (ephemeral, inline)
- **Execution plans**: For complex work — include progress logs, decision history, and verification criteria
- **Active/completed/debt tracking**: All versioned and co-located

### Claude Code Integration

```bash
# Use plan mode for complex tasks
# Claude enters plan mode → writes plan to file → user approves → Claude executes

# Store execution plans in docs/exec-plans/active/
# Move to docs/exec-plans/completed/ when done
# Track tech debt in docs/exec-plans/tech-debt-tracker.md
```

---

## 6. Throughput Changes the Merge Philosophy

### Speed Over Perfection

When agent throughput exceeds human review capacity:

- **Minimize blocking merge gates** — keep PRs short-lived
- **Address test flakes with follow-up runs** rather than blocking progress
- **Corrections are cheap, waiting is expensive**

### Practical Rules

- Automate what can be automated (linting, type checking, test runs)
- Trust the architecture enforcement to catch structural issues
- Reserve human review for judgment calls: product decisions, security, and architectural shifts
- Use `superpowers:verification-before-completion` to ensure Claude verifies its own work

---

## 7. Entropy and Garbage Collection

### The Problem

Claude replicates patterns that exist in the repo — even bad ones. Without active management, drift compounds.

### The Solution: Continuous Cleanup

Instead of "AI slop Fridays," encode **golden principles** and run automated cleanup:

1. **Define golden principles** in `docs/design-docs/core-beliefs.md`
   - Prefer shared utility packages over hand-rolled helpers
   - Validate boundaries, don't probe data YOLO-style
   - Use typed SDKs over raw API calls

2. **Run recurring cleanup tasks**
   - Background Claude tasks scan for deviations
   - Update quality grades in `QUALITY_SCORE.md`
   - Open targeted refactoring PRs
   - Most can be reviewed in under a minute and automerged

3. **Capture taste as code**
   - Review comments → documentation updates
   - Repeated feedback → lint rules
   - When docs fall short, promote the rule into code

---

## 8. Increasing Autonomy Over Time

### The Maturity Ladder

As you build more scaffolding, Claude can handle increasingly autonomous workflows:

```
Level 1: Claude writes code, human reviews everything
Level 2: Claude writes + self-reviews, human spot-checks
Level 3: Claude writes + agent-reviews + auto-merges routine PRs
Level 4: Claude reproduces bugs, implements fixes, validates, opens PRs
Level 5: Claude handles end-to-end feature delivery with human escalation
```

### End-to-End Capability (Level 5)

With sufficient scaffolding, a single Claude prompt can:
- Validate current codebase state
- Reproduce a reported bug
- Implement a fix
- Validate the fix
- Open a PR
- Respond to feedback
- Detect and remediate build failures
- Escalate to humans only when judgment is required

**This requires heavy investment in tooling, testing, and architecture — don't expect it for free.**

---

## 9. Technology Choices for Agent Legibility

### Prefer "Boring" Technology

Technologies that are composable, API-stable, and well-represented in training data are easier for Claude to model. Favor:

- Well-documented, stable libraries
- Standard patterns over clever abstractions
- In-repo implementations over opaque upstream dependencies (when the abstraction is small)

### When to Reimplement

Sometimes it's cheaper to have Claude reimplement a small utility than to work around an opaque library. Do this when:
- The functionality is small and well-defined
- You need tight integration with your observability/testing
- The upstream library has unpredictable behavior
- You want 100% test coverage on the behavior

---

## Quick Start Checklist

- [ ] Create a lean `CLAUDE.md` (~100 lines) as a map, not a manual
- [ ] Set up `docs/` directory structure with design docs, specs, and plans
- [ ] Write `ARCHITECTURE.md` with layer rules and dependency directions
- [ ] Create custom linters that enforce architectural boundaries
- [ ] Configure MCP servers for browser, database, and API access
- [ ] Set up git worktree-based isolation for parallel work
- [ ] Write custom skills (`/commands`) for your common workflows
- [ ] Create `QUALITY_SCORE.md` to track codebase health per domain
- [ ] Set up CI that runs Claude-powered review
- [ ] Define golden principles in `docs/design-docs/core-beliefs.md`
- [ ] Schedule recurring cleanup tasks for entropy management

---

## Key Differences: Claude Code vs. Codex

| Aspect | Codex (OpenAI) | Claude Code (Anthropic) |
|---|---|---|
| **Context management** | AGENTS.md | CLAUDE.md (+ hierarchical per-directory) |
| **Plan mode** | Custom execution plans | Built-in plan mode (`EnterPlanMode`) |
| **Multi-agent** | Cloud Codex instances | Subagents, worktrees, parallel agents |
| **Tool access** | gh, local scripts, skills | MCP servers, hooks, custom skills |
| **Review** | Agent-to-agent in cloud | Code reviewer subagent, CI integration |
| **Isolation** | Git worktrees | Git worktrees (built-in support) |
| **Autonomy control** | Custom harness | Permission modes, hooks, settings |

---

*Adapted from [Harness Engineering](https://openai.com/index/harness-engineering/) by Ryan Lopopolo, OpenAI (February 2026). Translated for Claude Code by the stave project.*
