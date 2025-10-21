-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00)
-- table: session_audit
CREATE TABLE IF NOT EXISTS session_audit (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  session_token BINARY(32) NULL,
  session_token_key_version VARCHAR(64) NULL,
  csrf_key_version VARCHAR(64) NULL,
  session_id VARCHAR(128) NULL,
  event VARCHAR(64) NOT NULL,
  user_id BIGINT UNSIGNED NULL,
  ip_hash BINARY(32) NULL,
  ip_hash_key_version VARCHAR(64) NULL,
  user_agent VARCHAR(1024) NULL,
  meta_json JSON NULL,
  outcome VARCHAR(32) NULL,
  created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  INDEX idx_session_audit_token (session_token),
  INDEX idx_session_audit_session_id (session_id),
  INDEX idx_session_audit_user_id (user_id),
  INDEX idx_session_audit_created_at (created_at),
  INDEX idx_session_audit_event (event),
  INDEX idx_session_audit_ip_hash (ip_hash),
  INDEX idx_session_audit_ip_key (ip_hash_key_version),
  INDEX idx_session_audit_event_time (event, created_at),
  INDEX idx_session_audit_user_event_time (user_id, event, created_at),
  INDEX idx_session_audit_token_time (session_token, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
