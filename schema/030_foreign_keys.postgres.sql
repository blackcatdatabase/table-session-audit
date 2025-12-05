-- Auto-generated from schema-map-postgres.yaml (map@sha1:F0EE237771FBA8DD7C4E886FF276F91A862C3718)
-- engine: postgres
-- table:  session_audit

ALTER TABLE session_audit ADD CONSTRAINT fk_session_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;
