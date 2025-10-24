-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-10-24T09:46:38Z)
-- engine: postgres
-- table:  session_audit
ALTER TABLE session_audit ADD CONSTRAINT fk_session_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;
