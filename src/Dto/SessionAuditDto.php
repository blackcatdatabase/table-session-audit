<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\SessionAudit\Dto;

/**
 * Jednoduché, neměnné DTO s veřejnými readonly vlastnostmi.
 * - Žádná logika; pouze nosič dat.
 * - Silné typy drží kontrakt napříč vrstvami.
 */
final class SessionAuditDto {
    public function __construct(
        public readonly ?int $id,
        public readonly ?string $sessionToken,
        public readonly ?string $sessionTokenKeyVersion,
        public readonly ?string $csrfKeyVersion,
        public readonly ?string $sessionId,
        public readonly string $event,
        public readonly ?int $userId,
        public readonly ?string $ipHash,
        public readonly ?string $ipHashKeyVersion,
        public readonly ?string $userAgent,
        public readonly array|null $metaJson,
        public readonly ?string $outcome,
        public readonly \DateTimeImmutable $createdAt
    ) {}

    /** Vhodné pro serializaci/logování (bez binárních/velkých blobů). */
    public function toArray(): array {
        // get_object_vars funguje dobře s public readonly vlastnostmi
        return get_object_vars($this);
    }
}
