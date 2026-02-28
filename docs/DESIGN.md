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

### Conventions
- Unit tests live next to the code they test
- Integration tests in a separate `__tests__/` directory
- Test names describe behavior: `"should return 404 when user not found"`
- One assertion per test when possible

### What to Test
- Business logic in service layer (high coverage)
- Schema validation at boundaries
- Edge cases and error paths
- Integration points (API, DB)

### What NOT to Test
- Implementation details (private methods, internal state)
- Framework behavior
- Simple getters/setters

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
