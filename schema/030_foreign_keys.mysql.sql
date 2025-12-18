-- Auto-generated from schema-map-mysql.yaml (map@sha1:0D716345C0228A9FD8972A3D31574000D05317DB)
-- engine: mysql
-- table:  session_audit

ALTER TABLE session_audit ADD CONSTRAINT fk_session_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;
