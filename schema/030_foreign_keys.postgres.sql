-- Auto-generated from schema-map-postgres.psd1 (map@c5e4097)
-- engine: postgres
-- table:  session_audit
ALTER TABLE session_audit ADD CONSTRAINT fk_session_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;
