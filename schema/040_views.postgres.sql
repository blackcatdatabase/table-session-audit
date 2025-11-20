-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  session_audit
-- Contract view for [session_audit]
-- Includes hashed token; adds hex helpers; meta_json -> meta.
CREATE OR REPLACE VIEW vw_session_audit AS
SELECT
  id,
  session_token_hash,
  UPPER(encode(session_token_hash,'hex')) AS session_token_hash_hex,
  session_token_key_version,
  csrf_token_hash,
  UPPER(encode(csrf_token_hash,'hex')) AS csrf_token_hash_hex,
  csrf_key_version,
  session_id,
  event,
  user_id,
  ip_hash,
  UPPER(encode(ip_hash,'hex')) AS ip_hash_hex,
  ip_hash_key_version,
  user_agent,
  meta_json AS meta,
  outcome,
  created_at
FROM session_audit;
