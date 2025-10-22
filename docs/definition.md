<!-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00) -->
# Definition – session_audit

Low-level session lifecycle and security events.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT UNSIGNED | — | — | Surrogate primary key. |  |
| session_token | BINARY(32) | YES | — | Hashed session token. | PII: hashed |
| session_token_key_version | VARCHAR(64) | YES | — | Key version for session_token. |  |
| csrf_key_version | VARCHAR(64) | YES | — | Key version for CSRF related data. |  |
| session_id | VARCHAR(128) | YES | — | Framework session id (string). |  |
| event | VARCHAR(64) | NO | — | Event code (e.g., created, rotated, revoked). |  |
| user_id | BIGINT UNSIGNED | YES | — | User (FK users.id), optional. |  |
| ip_hash | BINARY(32) | YES | — | Hashed IP. | PII: hashed |
| ip_hash_key_version | VARCHAR(64) | YES | — | Key version for ip_hash. |  |
| user_agent | VARCHAR(1024) | YES | — | Client user agent. |  |
| meta_json | JSON | YES | — | JSON metadata. |  |
| outcome | VARCHAR(32) | YES | — | Outcome label (e.g., success, fail). |  |
| created_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Event timestamp (UTC). |  |