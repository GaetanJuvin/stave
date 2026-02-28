# Security Policies and Boundaries

> Security standards, policies, and boundaries for [PROJECT_NAME].
> All engineers (human and agent) must follow these rules.

## Security Principles

1. **Defense in depth** — Multiple layers of security; no single point of failure
2. **Least privilege** — Grant minimum permissions required
3. **Validate all input** — Never trust data from outside the system boundary
4. **Fail secure** — When things break, default to denying access

## Authentication

### Standards
- [e.g., JWT, session-based, OAuth 2.0]
- Tokens must have expiration
- Refresh tokens must be rotatable
- Support MFA for sensitive operations

### Rules
- Never store passwords in plain text
- Use [hashing algorithm] for password hashing
- Session timeout: [duration]
- Lock account after [N] failed attempts

## Authorization

### Model
- [e.g., RBAC, ABAC, or policy-based]
- Define roles and permissions in [location]
- Check authorization at the service layer, not the UI layer

### Rules
- Every endpoint must have an authorization check
- Default deny — endpoints are restricted unless explicitly opened
- Log all authorization failures

## Data Protection

### Sensitive Data Classification
| Classification | Examples | Storage Rules |
|---------------|----------|--------------|
| **Critical** | Passwords, API keys, tokens | Encrypted at rest, never logged |
| **Sensitive** | PII, email, phone | Encrypted at rest, masked in logs |
| **Internal** | Business data | Standard protection |
| **Public** | Marketing content | No restrictions |

### Rules
- Encrypt sensitive data at rest and in transit
- Never log sensitive data (passwords, tokens, PII)
- Use environment variables for secrets — never commit them
- Rotate secrets on a [schedule]

## Input Validation

### Rules
- Validate all user input with schemas at the API boundary
- Sanitize output to prevent XSS
- Use parameterized queries to prevent SQL injection
- Validate file uploads (type, size, content)

## API Security

### Standards
- Rate limiting on all public endpoints
- CORS configured to allow only known origins
- HTTPS required for all traffic
- API versioning strategy: [approach]

## Dependency Security

- Run dependency vulnerability scans in CI
- Update dependencies with known vulnerabilities promptly
- Prefer well-maintained, widely-used libraries
- Audit new dependencies before adding

## Agent-Specific Rules

When Claude or other agents work on this codebase:
- Never commit secrets, tokens, or credentials
- Never disable security checks or linting
- Never bypass authentication or authorization in production code
- Always validate input at boundaries, even in internal tools
- Flag security-sensitive changes for human review

## Incident Handling

See `docs/RELIABILITY.md` for incident response process. For security-specific incidents:
1. Contain the breach
2. Assess the scope
3. Notify affected parties per policy
4. Remediate and document

---

*See `docs/RELIABILITY.md` for operational standards. See `CLAUDE.md` for the full project map.*
