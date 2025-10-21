-- Auto-generated from schema-map.psd1 on 2025-10-21T02:32:05
-- table: session_audit
ALTER TABLE session_audit ADD CONSTRAINT fk_session_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;
