<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\SessionAudit\Dto;

/**
 * Simple immutable DTO with public readonly properties.
 * - No logic; just a data carrier.
 * - Strong types enforce the contract across layers.
 */
final class SessionAuditDto implements \JsonSerializable {
    public function __construct(
        public readonly int $id,
        public readonly ?string $sessionTokenHash,
        public readonly ?string $sessionTokenKeyVersion,
        public readonly ?string $csrfTokenHash,
        public readonly ?string $csrfKeyVersion,
        public readonly ?string $sessionId,
        public readonly string $event,
        public readonly ?int $userId,
        #[\SensitiveParameter] public readonly ?string $ipHash,
        public readonly ?string $ipHashKeyVersion,
        public readonly ?string $userAgent,
        public readonly array|null $metaJson,
        public readonly ?string $outcome,
        public readonly \DateTimeImmutable $createdAt
    ) {}

    /** Suitable for serialization/logging (without large blobs). */
    public function toArray(): array {
        return get_object_vars($this);
    }

    /** toArray() without null values - for clean logging/diffs. */
    public function toArrayNonNull(): array {
        return array_filter(get_object_vars($this), static fn($v) => $v !== null);
    }

    public function jsonSerialize(): array {
       $a = $this->toArray();
       foreach ($a as $k => $v) {
           if ($v instanceof \DateTimeInterface) {
               // ISO-8601 with a timezone; switch to 'Y-m-d H:i:s.u' if needed
               $a[$k] = $v->format(\DateTimeInterface::ATOM);
           }
       }
       return $a;
   }
}
