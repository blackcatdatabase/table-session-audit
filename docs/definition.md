<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – session_audit

Low-level session lifecycle and security events.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | — | AS | Surrogate primary key. |  |
| session_token_hash | BYTEA | YES | — |  |  |
| session_token_key_version | VARCHAR(64) | YES | — | Key version for session_token. |  |
| csrf_token_hash | BYTEA | YES | — |  |  |
| csrf_key_version | VARCHAR(64) | YES | — | Key version for CSRF related data. |  |
| session_id | VARCHAR(128) | YES | — | Framework session id (string). |  |
| event | VARCHAR(64) | NO | — | Event code (e.g., created, rotated, revoked). |  |
| user_id | BIGINT | YES | — | User (FK users.id), optional. |  |
| ip_hash | BYTEA | YES | — | Hashed IP. | PII: hashed |
| ip_hash_key_version | VARCHAR(64) | YES | — | Key version for ip_hash. |  |
| user_agent | VARCHAR(1024) | YES | — | Client user agent. |  |
| meta_json | JSONB | YES | — | JSON metadata. |  |
| outcome | VARCHAR(32) | YES | — | Outcome label (e.g., success, fail). |  |
| created_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Event timestamp (UTC). |  |