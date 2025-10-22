<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\SessionAudit;

final class Definitions {
    // --- základní metadata ---
    public static function table(): string { return 'session_audit'; }
    public static function contractView(): string { return 'v_session_audit_contract'; }
    /** @return string[] */
    public static function columns(): array { return [ 'id', 'session_token', 'session_token_key_version', 'csrf_key_version', 'session_id', 'event', 'user_id', 'ip_hash', 'ip_hash_key_version', 'user_agent', 'meta_json', 'outcome', 'created_at' ]; }
    public static function pk(): string { return 'id'; }

    // --- volitelná metadata (mohou být prázdná) ---
    public static function softDeleteColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null;
    }
    public static function updatedAtColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null;
    }
    public static function versionColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null; // pro optimistic locking
    }
    /** např. "created_at DESC, id DESC" */
    public static function defaultOrder(): ?string {
        $c = 'created_at DESC, id DESC'; return $c !== '' ? $c : null;
    }
    /** @return array<int,array<int,string>> seznam unikátních klíčů (sloupcových kombinací) */
    public static function uniqueKeys(): array { return []; }
    /** @return string[] JSON sloupce kvůli castům/operacím */
    public static function jsonColumns(): array { return [ 'meta_json' ]; }

    // --- pomocníci ---
    public static function hasColumn(string $col): bool {
        static $set = null;
        if ($set === null) { $set = array_fill_keys(self::columns(), true); }
        return isset($set[$col]);
    }
}
