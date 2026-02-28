# Reliability Standards

> Reliability targets, SLOs, and operational standards for [PROJECT_NAME].

## Service Level Objectives (SLOs)

| Metric | Target | Measurement Window |
|--------|--------|-------------------|
| Availability | [e.g., 99.9%] | Rolling 30 days |
| Latency (p50) | [e.g., < 200ms] | Rolling 7 days |
| Latency (p99) | [e.g., < 1000ms] | Rolling 7 days |
| Error rate | [e.g., < 0.1%] | Rolling 7 days |

## Error Budget

When the error budget is exhausted, prioritize reliability work over feature work until the budget recovers.

## Operational Standards

### Health Checks
- Every service must expose a health check endpoint
- Health checks verify downstream dependencies
- Load balancers use health checks for routing

### Graceful Degradation
- Identify critical vs. non-critical features
- Non-critical features should fail gracefully without blocking core functionality
- Implement circuit breakers for external dependencies

### Timeouts and Retries
| Operation | Timeout | Retries | Backoff |
|-----------|---------|---------|---------|
| Database query | [target] | [count] | [strategy] |
| External API | [target] | [count] | [strategy] |
| Internal service | [target] | [count] | [strategy] |

### Data Integrity
- Use transactions for multi-step operations
- Implement idempotency for mutation endpoints
- Validate data at boundaries (see `docs/DESIGN.md`)

## Incident Response

### Severity Levels
| Level | Definition | Response Time |
|-------|-----------|--------------|
| **SEV1** | Service down for all users | Immediate |
| **SEV2** | Major feature degraded | < 1 hour |
| **SEV3** | Minor feature affected | < 4 hours |
| **SEV4** | Cosmetic or minor issue | Next business day |

### Post-Incident
1. Resolve the immediate issue
2. Write a post-mortem
3. Identify action items to prevent recurrence
4. Add action items to `docs/exec-plans/tech-debt-tracker.md`

## Monitoring

### What to Monitor
- Request rate, error rate, latency (RED)
- Saturation (CPU, memory, disk, connections)
- Business metrics (signups, transactions, etc.)

### Alerting Rules
- Alert on SLO violation
- Alert on error rate spike
- Alert on resource saturation > [threshold]

---

*See `docs/SECURITY.md` for security standards. See `CLAUDE.md` for the full project map.*
