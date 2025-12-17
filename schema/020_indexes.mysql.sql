-- Auto-generated from schema-map-mysql.yaml (map@sha1:7AAC4013A2623AC60C658C9BF8458EFE0C7AB741)
-- engine: mysql
-- table:  session_audit

CREATE INDEX idx_session_audit_token_hash ON session_audit (session_token_hash);

CREATE INDEX idx_session_audit_session_id ON session_audit (session_id);

CREATE INDEX idx_session_audit_user_id ON session_audit (user_id);

CREATE INDEX idx_session_audit_created_at ON session_audit (created_at);

CREATE INDEX idx_session_audit_event ON session_audit (event);

CREATE INDEX idx_session_audit_ip_hash ON session_audit (ip_hash);

CREATE INDEX idx_session_audit_event_time ON session_audit (event, created_at);

CREATE INDEX idx_session_audit_user_event_time ON session_audit (user_id, event, created_at);

CREATE INDEX idx_session_audit_token_time ON session_audit (session_token_hash, created_at);

CREATE INDEX idx_session_audit_event_user_time ON session_audit (event, user_id, created_at DESC);
