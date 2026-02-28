# Frontend Architecture and Conventions

> Frontend-specific patterns, component structure, and UI conventions for [PROJECT_NAME].

## Component Architecture

### Component Types

| Type | Purpose | State? | Side Effects? |
|------|---------|--------|--------------|
| **Page** | Route-level containers | Yes | Yes (data fetching) |
| **Feature** | Domain-specific UI | Yes | Minimal |
| **UI** | Reusable, presentational | No (props only) | No |
| **Layout** | Structural wrappers | No | No |

### Component Structure

```
components/
├── [ComponentName]/
│   ├── [ComponentName].tsx       # Component implementation
│   └── index.ts                 # Public export
```

### Rules

1. **Props over state** — Prefer passing data as props; lift state to the nearest common ancestor
2. **Composition over configuration** — Build complex UI from simple, composable components
3. **No business logic in components** — Call service layer functions; components handle rendering only
4. **Test at the user level** — Don't unit-test components in isolation; cover them with E2E tests that verify real user flows

## State Management

### Local State
Use framework-native state for component-scoped data (e.g., `useState`, `useReducer`).

### Global State
Use [state management library] for cross-component state. Organize by domain:

```
stores/
├── [domain]Store.ts
└── ...
```

### Server State
Use [data fetching library] for server state. Keep caching and synchronization in the data layer, not in components.

## Routing

[Describe routing conventions — file-based, config-based, naming patterns]

## Forms

### Conventions
- Use [form library] for form state management
- Validate with schemas (same schemas used on the backend)
- Show inline validation errors immediately on blur
- Disable submit button while submitting

## Performance

### Guidelines
- Lazy-load routes and heavy components
- Memoize expensive computations
- Avoid unnecessary re-renders — profile before optimizing
- Image optimization: use appropriate formats and sizes

### Budgets
| Metric | Target |
|--------|--------|
| First Contentful Paint | < [target] |
| Largest Contentful Paint | < [target] |
| Cumulative Layout Shift | < [target] |
| Bundle size (initial) | < [target] |

## Testing

### E2E First

Frontend features are tested primarily through **browser-based E2E tests** that simulate real user behavior:

```
tests/e2e/
├── auth.test.ts              # Login, signup, logout
├── [feature].test.ts         # Feature-specific user journeys
└── accessibility.test.ts     # Keyboard nav, screen reader checks
```

Use **MCP browser tools** (Brave MCP, Claude MCP) or **Playwright** to drive a real browser:
- Click buttons, fill forms, navigate pages — like a human would
- Assert on visible text and UI state — not component internals
- Test the full stack: frontend + API + database together

### What NOT to Do
- No snapshot tests — they test nothing useful and create noise
- No shallow rendering or component-level unit tests — test real pages instead
- No mocking the entire backend — run against a real local instance

### Accessibility Testing
Include accessibility checks in E2E tests:
- Tab through interactive elements and verify focus order
- Verify ARIA labels are present and correct
- Check color contrast programmatically

## Accessibility

- All interactive elements must be keyboard-navigable
- Use semantic HTML elements (`button`, `nav`, `main`, etc.)
- ARIA labels for elements without visible text
- Color contrast: WCAG AA minimum
- Verify with E2E accessibility tests (not manual spot-checks)

## Styling

[Describe styling approach — CSS modules, Tailwind, styled-components, etc.]

### Conventions
- Use design system tokens for colors, spacing, typography
- Mobile-first responsive design
- No inline styles in production code
- See `docs/references/design-system.md` for the design language

---

*See `docs/references/design-system.md` for visual standards. See `CLAUDE.md` for the full project map.*
