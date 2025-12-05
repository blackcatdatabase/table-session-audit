<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\SessionAudit;

use BlackCat\Database\SqlDialect;
use BlackCat\Database\Contracts\ModuleInterface;
use BlackCat\Database\Support\SqlIdentifier;
use BlackCat\Database\Support\SqlDirectoryRunner;
use BlackCat\Database\Support\SchemaIntrospector;
use BlackCat\Core\Database as Database;

final class SessionAuditModule implements ModuleInterface
{
    public function name(): string { return 'table-session_audit'; }
    public function table(): string { return 'session_audit'; }
    public function version(): string { return '1.0.0'; }

    /** @return string[] */
    public function dialects(): array { return [ 'mysql', 'postgres' ]; }
    /** @return string[] */
    public function dependencies(): array { return [ 'table-users' ]; }

    public static function contractView(): string { return 'vw_session_audit'; }

    public function install(Database $db, SqlDialect $d): void
    {
        // 1) Run schema files from ../schema for the dialect (NNN_*.sql order respected)
        SqlDirectoryRunner::run($db, $d, __DIR__ . '/../schema');

        // 2) Contract view = SELECT * FROM <table>
        $table = SqlIdentifier::qi($db, $this->table());
        $view  = SqlIdentifier::qi($db, self::contractView());

        if ($d->isMysql()) {
            $createViewSql = <<<'SQL'
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
SQL;
        } else {
            $createViewSql = <<<'SQL'
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
SQL;
        }

        if (\class_exists('\\BlackCat\\Database\\Support\\DdlGuard')) {
            (new \BlackCat\Database\Support\DdlGuard($db, $d))->applyCreateView($createViewSql);
        } else {
            // Prefer CREATE OR REPLACE VIEW (gentle on dependencies)
            $db->exec($createViewSql);
        }

    }

    public function upgrade(Database $db, SqlDialect $d, string $from): void
    {
        // Optional: generator may place module-specific upgrade steps here (e.g., data migrations).
    }

    /** Does not drop the table, only the contract (view). */
    public function uninstall(Database $db, SqlDialect $d): void
    {
        $qiV = SqlIdentifier::qi($db, self::contractView());
        try {
            $db->exec("DROP VIEW IF EXISTS {$qiV}" . ($d->isMysql() ? "" : " CASCADE"));
        } catch (\Throwable) {
            // swallow
        }
    }

    public function status(Database $db, SqlDialect $d): array
    {
        $table = $this->table();
        $view  = self::contractView();

        $hasTable = SchemaIntrospector::hasTable($db, $d, $table);
        $hasView  = SchemaIntrospector::hasView($db, $d, $view);

        // Quick index/FK check â€“ generator injects names (case-sensitive per DB)
        $expectedIdx = [ 'idx_session_audit_created_at', 'idx_session_audit_event', 'idx_session_audit_event_time', 'idx_session_audit_event_user_time', 'idx_session_audit_ip_hash', 'idx_session_audit_session_id', 'idx_session_audit_token_hash', 'idx_session_audit_token_time', 'idx_session_audit_user_event_time', 'idx_session_audit_user_id' ];
        if ($d->isMysql()) {
            // Drop PG-only index naming patterns (e.g., GIN/GiST)
            $expectedIdx = array_values(array_filter(
                $expectedIdx,
                static fn(string $n): bool => !str_starts_with($n, 'gin_') && !str_starts_with($n, 'gist_')
            ));
        }
        $expectedFk  = [ 'fk_session_audit_user' ];

        $haveIdx = $hasTable ? SchemaIntrospector::listIndexes($db, $d, $table)     : [];
        $haveFk  = $hasTable ? SchemaIntrospector::listForeignKeys($db, $d, $table) : [];

        $missingIdx = array_values(array_diff($expectedIdx, $haveIdx));
        $missingFk  = array_values(array_diff($expectedFk, $haveFk));

        return [
            'table'       => $hasTable,
            'view'        => $hasView,
            'missing_idx' => $missingIdx,
            'missing_fk'  => $missingFk,
            'version'     => $this->version(),
        ];
    }

    public function info(): array
    {
        return [
            'table'       => $this->table(),
            'view'        => self::contractView(),
            'columns'     => Definitions::columns(),
            'version'     => $this->version(),
            'dialects'    => [ 'mysql', 'postgres' ],
            'indexes'     => [ 'idx_session_audit_created_at', 'idx_session_audit_event', 'idx_session_audit_event_time', 'idx_session_audit_event_user_time', 'idx_session_audit_ip_hash', 'idx_session_audit_session_id', 'idx_session_audit_token_hash', 'idx_session_audit_token_time', 'idx_session_audit_user_event_time', 'idx_session_audit_user_id' ],
            'foreignKeys' => [ 'fk_session_audit_user' ],
        ];
    }
}
