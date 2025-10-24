-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-10-24T09:46:38Z)
-- engine: postgres
-- table:  session_audit
CREATE INDEX idx_session_audit_token ON session_audit (session_token);

CREATE INDEX idx_session_audit_session_id ON session_audit (session_id);

CREATE INDEX idx_session_audit_user_id ON session_audit (user_id);

CREATE INDEX idx_session_audit_created_at ON session_audit (created_at);

CREATE INDEX idx_session_audit_event ON session_audit (event);

CREATE INDEX idx_session_audit_ip_hash ON session_audit (ip_hash);

CREATE INDEX idx_session_audit_ip_key ON session_audit (ip_hash_key_version);

CREATE INDEX idx_session_audit_event_time ON session_audit (event, created_at);

CREATE INDEX idx_session_audit_user_event_time ON session_audit (user_id, event, created_at);

CREATE INDEX idx_session_audit_token_time ON session_audit (session_token, created_at);
