-- Auto-generated from schema-map-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  session_audit
CREATE INDEX IF NOT EXISTS idx_session_audit_token_hash ON session_audit (session_token_hash);

CREATE INDEX IF NOT EXISTS idx_session_audit_session_id ON session_audit (session_id);

CREATE INDEX IF NOT EXISTS idx_session_audit_user_id ON session_audit (user_id);

CREATE INDEX IF NOT EXISTS idx_session_audit_created_at ON session_audit (created_at);

CREATE INDEX IF NOT EXISTS idx_session_audit_event ON session_audit (event);

CREATE INDEX IF NOT EXISTS idx_session_audit_ip_hash ON session_audit (ip_hash);

CREATE INDEX IF NOT EXISTS idx_session_audit_event_time ON session_audit (event, created_at);

CREATE INDEX IF NOT EXISTS idx_session_audit_user_event_time ON session_audit (user_id, event, created_at);

CREATE INDEX IF NOT EXISTS idx_session_audit_token_time ON session_audit (session_token_hash, created_at);

CREATE INDEX IF NOT EXISTS gin_session_audit_meta ON session_audit USING GIN (meta_json jsonb_path_ops);

CREATE INDEX IF NOT EXISTS idx_session_audit_event_user_time ON session_audit (event, user_id, created_at DESC);
