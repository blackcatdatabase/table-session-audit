-- Auto-generated from schema-views-mysql.psd1 (map@38d5403)
-- engine: mysql
-- table:  session_audit
-- Contract view for [session_audit]
-- Includes hashed token + HEX helpers; meta_json -> meta.
CREATE OR REPLACE SQL SECURITY INVOKER VIEW vw_session_audit AS
SELECT
  id,
  session_token,
  HEX(session_token) AS session_token_hex,
  session_token_key_version,
  csrf_key_version,
  session_id,
  event,
  user_id,
  ip_hash,
  HEX(ip_hash) AS ip_hash_hex,
  ip_hash_key_version,
  user_agent,
  meta_json AS meta,
  outcome,
  created_at
FROM session_audit;
