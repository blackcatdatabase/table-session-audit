# session_audit

Low-level session lifecycle and security events.

## Columns
| Column | Type | Null | Default | Description | Crypto |
| --- | --- | --- | --- | --- | --- |
| id | BIGINT | NO |  | Surrogate primary key. |  |
| session_token_hash | mysql: BINARY(32) / postgres: BYTEA | YES |  | Hashed session token. | `hmac`<br/>ctx: `db.hmac.session_audit.session_token_hash`<br/>kv: `session_token_key_version` |
| session_token_key_version | VARCHAR(64) | YES |  | Key version for session_token_hash. | key version for: `session_token_hash` |
| csrf_token_hash | mysql: BINARY(32) / postgres: BYTEA | YES |  | Hashed CSRF token. | `hmac`<br/>ctx: `db.hmac.session_audit.csrf_token_hash`<br/>kv: `csrf_key_version` |
| csrf_key_version | VARCHAR(64) | YES |  | Key version for csrf_token_hash. | key version for: `csrf_token_hash` |
| session_id | VARCHAR(128) | YES |  | Framework session id (string). |  |
| event | VARCHAR(64) | NO |  | Event code (e.g., created, rotated, revoked). |  |
| user_id | BIGINT | YES |  | User (FK users.id), optional. |  |
| ip_hash | mysql: BINARY(32) / postgres: BYTEA | YES |  | Hashed IP. | `hmac`<br/>ctx: `db.hmac.session_audit.ip_hash`<br/>kv: `ip_hash_key_version` |
| ip_hash_key_version | VARCHAR(64) | YES |  | Key version for ip_hash. | key version for: `ip_hash` |
| user_agent | VARCHAR(1024) | YES |  | Client user agent. |  |
| meta_json | mysql: JSON / postgres: JSONB | YES |  | JSON metadata. |  |
| outcome | VARCHAR(32) | YES |  | Outcome label (e.g., success, fail). |  |
| created_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Event timestamp (UTC). |  |

## Engine Details

### mysql

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_session_audit_created_at | created_at | CREATE INDEX idx_session_audit_created_at ON session_audit (created_at) |
| idx_session_audit_event | event | CREATE INDEX idx_session_audit_event ON session_audit (event) |
| idx_session_audit_event_time | event,created_at | CREATE INDEX idx_session_audit_event_time ON session_audit (event, created_at) |
| idx_session_audit_event_user_time | event,user_id,created_atDESC | CREATE INDEX idx_session_audit_event_user_time ON session_audit (event, user_id, created_at DESC) |
| idx_session_audit_ip_hash | ip_hash | CREATE INDEX idx_session_audit_ip_hash ON session_audit (ip_hash) |
| idx_session_audit_ip_key | ip_hash_key_version | INDEX idx_session_audit_ip_key (ip_hash_key_version) |
| idx_session_audit_session_id | session_id | CREATE INDEX idx_session_audit_session_id ON session_audit (session_id) |
| idx_session_audit_token_hash | session_token_hash | CREATE INDEX idx_session_audit_token_hash ON session_audit (session_token_hash) |
| idx_session_audit_token_time | session_token_hash,created_at | CREATE INDEX idx_session_audit_token_time ON session_audit (session_token_hash, created_at) |
| idx_session_audit_user_event_time | user_id,event,created_at | CREATE INDEX idx_session_audit_user_event_time ON session_audit (user_id, event, created_at) |
| idx_session_audit_user_id | user_id | CREATE INDEX idx_session_audit_user_id ON session_audit (user_id) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_session_audit_user | user_id | users(id) | ON DELETE SET |

### postgres

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| gin_session_audit_meta | meta_jsonjsonb_path_ops | CREATE INDEX IF NOT EXISTS gin_session_audit_meta ON session_audit USING GIN (meta_json jsonb_path_ops) |
| idx_session_audit_created_at | created_at | CREATE INDEX IF NOT EXISTS idx_session_audit_created_at ON session_audit (created_at) |
| idx_session_audit_event | event | CREATE INDEX IF NOT EXISTS idx_session_audit_event ON session_audit (event) |
| idx_session_audit_event_time | event,created_at | CREATE INDEX IF NOT EXISTS idx_session_audit_event_time ON session_audit (event, created_at) |
| idx_session_audit_event_user_time | event,user_id,created_atDESC | CREATE INDEX IF NOT EXISTS idx_session_audit_event_user_time ON session_audit (event, user_id, created_at DESC) |
| idx_session_audit_ip_hash | ip_hash | CREATE INDEX IF NOT EXISTS idx_session_audit_ip_hash ON session_audit (ip_hash) |
| idx_session_audit_ip_key | ip_hash_key_version | CREATE INDEX IF NOT EXISTS idx_session_audit_ip_key ON session_audit (ip_hash_key_version) |
| idx_session_audit_session_id | session_id | CREATE INDEX IF NOT EXISTS idx_session_audit_session_id ON session_audit (session_id) |
| idx_session_audit_token_hash | session_token_hash | CREATE INDEX IF NOT EXISTS idx_session_audit_token_hash ON session_audit (session_token_hash) |
| idx_session_audit_token_time | session_token_hash,created_at | CREATE INDEX IF NOT EXISTS idx_session_audit_token_time ON session_audit (session_token_hash, created_at) |
| idx_session_audit_user_event_time | user_id,event,created_at | CREATE INDEX IF NOT EXISTS idx_session_audit_user_event_time ON session_audit (user_id, event, created_at) |
| idx_session_audit_user_id | user_id | CREATE INDEX IF NOT EXISTS idx_session_audit_user_id ON session_audit (user_id) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_session_audit_user | user_id | users(id) | ON DELETE SET |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_session_audit | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views.mysql.sql](../schema/040_views.mysql.sql) |
| vw_session_audit | postgres |  | [../schema/040_views.postgres.sql](../schema/040_views.postgres.sql) |
