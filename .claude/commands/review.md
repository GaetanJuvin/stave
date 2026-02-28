# Self-Review Before PR

Before opening a PR, perform a thorough self-review of all changes.

## Steps

1. **Read the diff**: Run `git diff` to see all staged and unstaged changes.

2. **Check architecture compliance**:
   - Read `ARCHITECTURE.md` for layer rules
   - Verify no upward dependencies (layers only import from below)
   - Run `scripts/lint-architecture.sh`

3. **Check conventions**:
   - Read `docs/DESIGN.md` for naming and pattern conventions
   - Verify error messages are descriptive and actionable
   - Confirm no `console.log` in production code
   - Check file sizes are under 300 lines

4. **Check security**:
   - Read `docs/SECURITY.md` for security policies
   - Verify no secrets, tokens, or credentials in the diff
   - Confirm input validation at all boundaries
   - Check for XSS, SQL injection, and other OWASP top 10 risks

5. **Check tests**:
   - Verify new features have E2E tests covering the critical user journey
   - Run E2E tests via browser automation (Brave MCP or Playwright) and confirm they pass
   - Run the unit/integration test suite and confirm all tests pass
   - Check that tests assert on real user-visible behavior, not implementation details
   - No snapshot tests — if any were added, flag for removal

6. **Check documentation**:
   - Verify any new modules are documented
   - Update `ARCHITECTURE.md` if new domains were added
   - Update relevant design docs or specs

7. **Summarize findings**:
   - List any issues found
   - Fix all issues before proceeding
   - If no issues, confirm the changes are ready for PR

Output a structured review summary with: changes overview, compliance status, issues found, and recommendation (ready / needs fixes).
