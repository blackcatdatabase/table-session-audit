-- Auto-generated from schema-views-mysql.psd1 (map@mtime:2025-10-24T09:19:46Z)
-- engine: mysql
-- table:  session_audit
-- Contract view for [session_audit]
-- Session token is typically hashed; included for correlation. Adjust if you treat it as sensitive.
CREATE OR REPLACE VIEW vw_session_audit AS
SELECT
  id,
  session_token,
  session_token_key_version,
  csrf_key_version,
  session_id,
  event,
  user_id,
  ip_hash,
  ip_hash_key_version,
  user_agent,
  meta_json,
  outcome,
  created_at
FROM session_audit;
