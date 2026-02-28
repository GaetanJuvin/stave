# Architecture — [PROJECT_NAME]

> System map, domain layers, dependency rules, and module layout.
> Read this before modifying any module.

## System Overview

```
┌─────────────────────────────────────────────────────┐
│                      UI Layer                       │
│         (Pages, Components, Hooks, Views)           │
├─────────────────────────────────────────────────────┤
│                   Runtime Layer                     │
│       (App bootstrap, middleware, routing)          │
├─────────────────────────────────────────────────────┤
│                   Service Layer                     │
│        (Business logic, orchestration)              │
├─────────────────────────────────────────────────────┤
│                 Repository Layer                    │
│          (Data access, external APIs)               │
├─────────────────────────────────────────────────────┤
│                   Config Layer                      │
│        (Environment, feature flags, secrets)        │
├─────────────────────────────────────────────────────┤
│                   Types Layer                       │
│     (Shared types, schemas, domain models)          │
└─────────────────────────────────────────────────────┘
```

## Dependency Rule

Dependencies flow **downward only**:

```
Types → Config → Repo → Service → Runtime → UI
```

**A layer may only import from layers below it.** Violations are caught by `scripts/lint-architecture.sh`.

| Layer | May Import From | Must NOT Import From |
|-------|----------------|---------------------|
| Types | (nothing — leaf layer) | Everything |
| Config | Types | Repo, Service, Runtime, UI |
| Repo | Types, Config | Service, Runtime, UI |
| Service | Types, Config, Repo | Runtime, UI |
| Runtime | Types, Config, Repo, Service | UI |
| UI | All layers below | (top layer) |

## Domain Structure

Each business domain follows the same layering. Replace `[domain]` with your domain name:

```
src/
├── [domain]/
│   ├── types.ts          # Domain models, schemas, enums
│   ├── config.ts         # Domain-specific configuration
│   ├── repo.ts           # Data access (DB queries, API calls)
│   ├── service.ts        # Business logic
│   └── components/       # UI components (if applicable)
├── shared/
│   ├── types/            # Cross-domain shared types
│   ├── utils/            # Shared utilities
│   └── components/       # Shared UI components
└── app/                  # Runtime / entry point
```

## Cross-Cutting Concerns

Cross-cutting concerns enter through explicit **Provider interfaces**, not direct imports:

| Concern | Pattern | Location |
|---------|---------|----------|
| Authentication | `AuthProvider` interface | `src/shared/types/auth.ts` |
| Logging | `Logger` interface | `src/shared/types/logger.ts` |
| Telemetry | `TelemetryProvider` interface | `src/shared/types/telemetry.ts` |
| Feature Flags | `FeatureFlagProvider` interface | `src/shared/types/flags.ts` |

**Rule:** Business logic never imports a concrete implementation of these concerns — only the interface.

## Data Flow

```
User Action → UI Component → Service → Repository → External System
                                ↓
                          Validation (schemas)
                                ↓
                          Side Effects (logging, telemetry)
```

All data crossing a boundary (API, DB, user input) **must** be validated with schemas.

## Module Boundaries

### Adding a New Domain

1. Create the directory under `src/[domain-name]/`
2. Add `types.ts` first — define the domain model
3. Add `repo.ts` — data access only, no business logic
4. Add `service.ts` — orchestration and business rules
5. Add components if the domain has UI
6. Update this document with the new domain

### Adding a New Shared Utility

1. Check if it already exists in `src/shared/utils/`
2. If not, add it there — **not** in a domain folder
3. Keep utilities pure and well-tested

## Key Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Schema validation | [e.g., Zod] | Runtime type safety at boundaries |
| State management | [e.g., Zustand] | Simple, minimal boilerplate |
| API layer | [e.g., tRPC, REST] | [reason] |
| Database | [e.g., PostgreSQL] | [reason] |
| Styling | [e.g., Tailwind CSS] | [reason] |

## Enforcement

- `scripts/lint-architecture.sh` — Validates dependency direction
- CI runs architectural checks on every PR
- Violations block merge

---

*See `CLAUDE.md` for the full project map. See `docs/DESIGN.md` for design patterns and conventions.*
