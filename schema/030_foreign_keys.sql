-- Auto-generated from schema-map.psd1 (map@1e83bb6)
-- table: session_audit
ALTER TABLE session_audit ADD CONSTRAINT fk_session_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;
