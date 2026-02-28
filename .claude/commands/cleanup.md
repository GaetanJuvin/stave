# Garbage Collection Scan

Scan the codebase for deviations from golden principles and technical debt.

## Steps

1. **Read golden principles**: Read `docs/design-docs/core-beliefs.md` for the rules to check against.

2. **Scan for violations**:
   - **Duplicated utilities**: Search for similar helper functions that should be consolidated into `src/shared/utils/`
   - **Raw console.log**: Search for `console.log`, `console.warn`, `console.error` in production code
   - **Missing validation**: Check API boundaries and data entry points for schema validation
   - **Large files**: Find files exceeding 300 lines
   - **Upward dependencies**: Check for imports that violate the layer architecture
   - **Dead code**: Look for unused exports, unreachable code, commented-out blocks
   - **Hardcoded values**: Find magic numbers or strings that should be constants or config

3. **Check quality scores**: Read `docs/QUALITY_SCORE.md` and verify grades still reflect reality.

4. **Check tech debt tracker**: Read `docs/exec-plans/tech-debt-tracker.md` for known debt.

5. **Report findings**:
   For each issue found, report:
   - File and line number
   - Which golden principle it violates
   - Suggested fix
   - Priority (P0-P3)

6. **Propose updates**:
   - Update `docs/QUALITY_SCORE.md` with revised grades
   - Add new items to `docs/exec-plans/tech-debt-tracker.md`
   - Suggest targeted refactoring PRs (each PR should fix one category of issue)

Output a structured cleanup report with: summary, issues by category, updated quality scores, and recommended next actions.
