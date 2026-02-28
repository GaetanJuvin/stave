# Harness Engineering vs. oh-my-claudecode (OMC)

Two different approaches to scaling AI-assisted software engineering with Claude Code.

---

## TL;DR

| | Harness Engineering (this repo) | oh-my-claudecode (OMC) |
|---|---|---|
| **What it is** | A methodology / operating system for engineering teams | A plugin / orchestration tool you install |
| **Philosophy** | Design the environment so the agent succeeds | Orchestrate multiple agents to brute-force tasks |
| **Approach** | Depth-first scaffolding | Width-first parallelism |
| **Focus** | Architecture, legibility, feedback loops | Agent routing, multi-model orchestration |
| **Complexity** | High upfront investment, compounds over time | Low setup, immediate parallelism |

---

## Detailed Comparison

### 1. Core Philosophy

**Harness Engineering** — "Humans steer. Agents execute."
- The bottleneck is human time and attention
- Invest in making the *environment* better for the agent
- When something fails, ask "what capability is missing?" not "try harder"
- Code quality comes from architectural enforcement, not more agents

**OMC** — "Zero learning curve. Maximum power."
- The bottleneck is agent throughput
- Invest in orchestrating *more agents* in parallel
- When something fails, use verify/fix loops (Ralph mode) to retry
- Code quality comes from cross-validation between models

### 2. Multi-Agent Strategy

**Harness Engineering:**
- Agent-to-agent *review* (one writes, another reviews)
- Sequential pipeline: write → self-review → PR → agent review → iterate
- Agents are specialized by *role* (writer, reviewer, gardener)
- Focus on quality gates between stages

**OMC:**
- Multi-agent *execution* (many agents work in parallel)
- Team pipeline: plan → PRD → execute → verify → fix loop
- 32 specialized agents for architecture, research, design, testing
- Focus on throughput and automatic delegation
- Cross-model orchestration (Claude + Codex + Gemini)

### 3. Architecture Enforcement

**Harness Engineering:**
- Custom linters enforce dependency direction rules
- Structural tests validate layer boundaries
- CI blocks architectural violations
- "Taste invariants" encoded as lintable checks
- Error messages teach the agent remediation

**OMC:**
- Relies on Claude's built-in understanding of architecture
- No custom enforcement tooling
- Quality comes from specialized agents (architecture agent, testing agent)
- Less structural — more dependent on model capability

### 4. Knowledge Management

**Harness Engineering:**
- Structured `docs/` directory as system of record
- Lean CLAUDE.md as table of contents (~100 lines)
- Progressive disclosure — agents follow pointers to deeper docs
- Mechanical freshness checks via CI
- "Doc-gardening" agent for automated cleanup

**OMC:**
- Uses Claude Code's built-in CLAUDE.md
- Skill learning — extracts reusable patterns from sessions
- HUD statusline for real-time visibility
- Analytics and cost tracking
- Less emphasis on repo-local documentation

### 5. Autonomy Model

**Harness Engineering:**
- Gradual autonomy increase as scaffolding matures
- End-to-end capability requires heavy tooling investment
- Human escalation is a designed path
- Application must be made *legible* to the agent (DevTools, logs, metrics)

**OMC:**
- Immediate autonomy via autopilot mode
- Ralph mode: persistent until verified complete
- Built-in retry loops for failure recovery
- Less investment in making app internals visible

### 6. Cost Model

**Harness Engineering:**
- Heavy upfront investment in tooling and architecture
- Pays off over time as agents become more autonomous
- Single model (Claude) — focused optimization
- Long-running single-agent tasks (up to 6+ hours)

**OMC:**
- Low upfront cost (install plugin, run)
- Smart model routing (Haiku for simple, Opus for complex) saves 30-50%
- Multi-model cost: ~$60/month for 3 Pro plans
- Short-burst parallel tasks

---

## When to Use Which

### Use Harness Engineering when:
- Building a product with a dedicated team over months
- Codebase will grow to hundreds of thousands of lines
- Architectural coherence matters more than speed
- You want to minimize human review over time
- You're willing to invest upfront in tooling

### Use OMC when:
- You want immediate productivity gains
- Tasks are parallelizable and relatively independent
- You benefit from cross-model validation (Claude + Codex + Gemini)
- You prefer a plug-and-play tool over building methodology
- Your team wants maximum throughput with minimal setup

### Use Both Together:
- Use Harness Engineering's methodology for repo structure and architecture
- Use OMC's orchestration for parallel execution within that structure
- Harness provides the *guardrails*, OMC provides the *throughput*

---

## Key Insight

Harness Engineering answers: **"How do I make one agent maximally effective?"**
OMC answers: **"How do I coordinate many agents at once?"**

They're complementary. The strongest setup is a well-scaffolded repo (Harness) with multi-agent orchestration (OMC) running inside it.

---

*Sources: [OpenAI Harness Engineering](https://openai.com/index/harness-engineering/) | [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode)*
