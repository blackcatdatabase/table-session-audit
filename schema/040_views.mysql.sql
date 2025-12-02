-- Auto-generated from schema-views-mysql.yaml (map@94ebe6c)
-- engine: mysql
-- table:  session_audit

-- Contract view for [session_audit]
-- Includes hashed token + HEX helpers; meta_json -> meta.
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_session_audit AS
SELECT
  id,
  session_token_hash,
  CAST(LPAD(HEX(session_token_hash), 64, '0') AS CHAR(64)) AS session_token_hash_hex,
  session_token_key_version,
  csrf_token_hash,
  CAST(LPAD(HEX(csrf_token_hash), 64, '0') AS CHAR(64)) AS csrf_token_hash_hex,
  csrf_key_version,
  session_id,
  `event`,
  user_id,
  ip_hash,
  CAST(LPAD(HEX(ip_hash), 64, '0')  AS CHAR(64)) AS ip_hash_hex,
  ip_hash_key_version,
  user_agent,
  meta_json AS meta,
  outcome,
  created_at
FROM session_audit;
