# Create Execution Plan

Create a versioned execution plan for a complex task.

## Instructions

$ARGUMENTS

## Steps

1. **Understand the task**: Clarify the objective, scope, and constraints. Ask the user if anything is unclear.

2. **Research the codebase**:
   - Read relevant design docs in `docs/design-docs/`
   - Read relevant product specs in `docs/product-specs/`
   - Check `ARCHITECTURE.md` for layer rules that apply
   - Check `docs/exec-plans/active/` for related in-progress work
   - Check `docs/exec-plans/tech-debt-tracker.md` for relevant debt

3. **Design the approach**:
   - Break the work into concrete, ordered steps
   - Identify files that need to be created or modified
   - Identify risks and dependencies
   - Define verification criteria (how we know it's done)

4. **Write the plan**:
   - Copy `docs/exec-plans/TEMPLATE.md`
   - Fill in all sections
   - Name the file descriptively: `docs/exec-plans/active/YYYY-MM-DD-[short-name].md`
   - Save the plan

5. **Update tracking**:
   - Note any tech debt implications in `docs/exec-plans/tech-debt-tracker.md`

6. **Present the plan** to the user for approval before starting execution.

The plan is a first-class artifact — it gets committed to the repo and serves as a record of what was done and why.
