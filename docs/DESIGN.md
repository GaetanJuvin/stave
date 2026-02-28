# Design Patterns and Conventions

> Standard patterns used across [PROJECT_NAME]. Follow these when writing new code.
> When a pattern is repeated in code review, promote it to a rule here.

## Naming Conventions

### Files
| Type | Convention | Example |
|------|-----------|---------|
| Component | PascalCase | `UserProfile.tsx` |
| Utility | camelCase | `formatDate.ts` |
| Type/Schema | camelCase | `userTypes.ts` |
| Test | Same name + `.test` | `UserProfile.test.tsx` |
| Constant | SCREAMING_SNAKE | `MAX_RETRY_COUNT` |

### Code
| Type | Convention | Example |
|------|-----------|---------|
| Functions | camelCase | `getUserById()` |
| Classes | PascalCase | `UserService` |
| Constants | SCREAMING_SNAKE_CASE | `DEFAULT_TIMEOUT` |
| Types/Interfaces | PascalCase | `UserProfile` |
| Boolean variables | `is`/`has`/`should` prefix | `isActive`, `hasPermission` |

## Error Handling

### Pattern: Result Types
Prefer returning result types over throwing exceptions for expected failures:

```typescript
type Result<T, E = Error> = { ok: true; value: T } | { ok: false; error: E };
```

### Pattern: Error Messages That Teach
Error messages should explain what went wrong **and** suggest how to fix it:

```
// Bad
"Invalid input"

// Good
"User email is required. Provide a valid email address in the 'email' field."
```

## Data Validation

### Pattern: Validate at Boundaries
Use schema validation (e.g., Zod) at every system boundary:
- API request/response
- Database reads
- User input
- External service responses

Inside boundaries, trust the types.

## Logging

### Rules
- No `console.log` in production code
- Use structured logging with consistent fields
- Include correlation IDs for request tracing

### Log Levels
| Level | Usage |
|-------|-------|
| `error` | Something failed that shouldn't have |
| `warn` | Something unexpected but handled |
| `info` | Significant business events |
| `debug` | Diagnostic detail (not in production) |

## Testing

### Philosophy: Test Like a Human

The best test is one that proves the software works the way a real user would experience it. Prefer **end-to-end UI tests** that drive a real browser over unit tests that assert implementation details. A passing E2E test means the feature actually works. A passing unit test means one function returns the right value — the user doesn't care.

### Testing Pyramid (Inverted)

```
┌─────────────────────────────────────────────┐
│         E2E / UI Tests (PRIMARY)            │  ← Most investment here
│   Real browser, real clicks, real flows     │
├─────────────────────────────────────────────┤
│       Integration Tests (SECONDARY)         │  ← API boundaries, DB queries
├─────────────────────────────────────────────┤
│        Unit Tests (SUPPORTING)              │  ← Pure logic, algorithms
└─────────────────────────────────────────────┘
```

### E2E / UI Tests — The Primary Layer

Use browser automation via MCP tools (Brave MCP, Claude MCP, Playwright) to test the application the way a human would:

- **Navigate to a page, fill in a form, click submit, verify the result**
- **Test the full flow** — not isolated components in a fake DOM
- **Assert what the user sees** — visible text, navigation, error messages
- **Cover critical user journeys** — signup, login, core actions, error states

```
tests/
├── e2e/
│   ├── auth.test.ts          # Login, signup, logout flows
│   ├── [feature].test.ts     # Core feature journeys
│   └── ...
```

#### Rules
- Every new feature must have at least one E2E test covering the happy path
- E2E tests run against a real (or locally running) application — no mocks
- Test names describe user actions: `"user can create a new project and see it in the dashboard"`
- Use MCP browser tools (Brave MCP, etc.) so Claude can write and run these tests autonomously

#### What Makes a Good E2E Test
```
// Good: tests what the user actually does
"user fills in signup form, submits, and lands on the dashboard"
"user clicks delete, confirms the modal, and the item disappears"

// Bad: tests implementation details
"component renders with correct props"
"Redux store updates when action is dispatched"
```

### Integration Tests — The Secondary Layer

Test system boundaries where components talk to each other:
- API endpoints: real HTTP requests, real responses
- Database queries: real queries against a test database
- External service integrations: real calls or contract tests

### Unit Tests — The Supporting Layer

Use unit tests sparingly, only for **pure logic** that is genuinely complex:
- Algorithms and calculations
- Data transformations and parsing
- Business rules with many edge cases
- Schema validation logic

Unit tests live next to the code they test. Test names describe behavior: `"should return 404 when user not found"`.

### What NOT to Test

- **No snapshot tests** — they test nothing meaningful and break on every change
- **No testing implementation details** — private methods, internal state, component props
- **No testing framework behavior** — the framework already has tests
- **No mocking everything** — if you need 10 mocks, you're testing the wrong thing
- **No testing simple getters/setters** — waste of time

## Code Organization

### File Size
- Keep files under 300 lines
- If a file exceeds this, split it by responsibility

### Import Order
1. External libraries
2. Internal shared modules
3. Local modules
4. Types
5. Styles (if applicable)

---

*See `ARCHITECTURE.md` for layer rules. See `CLAUDE.md` for the full project map.*
