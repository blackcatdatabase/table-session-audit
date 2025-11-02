-- Auto-generated from schema-views-postgres.psd1 (map@db2f8b8)
-- engine: postgres
-- table:  session_audit
-- Contract view for [session_audit]
-- Includes hashed token; adds hex helpers; meta_json -> meta.
CREATE OR REPLACE VIEW vw_session_audit AS
SELECT
  id,
  session_token,
  UPPER(encode(session_token,'hex'))::char(64) AS session_token_hex,
  session_token_key_version,
  csrf_key_version,
  session_id,
  event,
  user_id,
  ip_hash,
  UPPER(encode(ip_hash,'hex'))::char(32) AS ip_hash_hex,
  ip_hash_key_version,
  user_agent,
  meta_json AS meta,
  outcome,
  created_at
FROM session_audit;
