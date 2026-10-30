BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "battle" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "arena_run" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "petId" bigint NOT NULL,
    "opponentKey" text NOT NULL,
    "petMaxHp" bigint NOT NULL,
    "petAttack" bigint NOT NULL,
    "petDefense" bigint NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "status" text NOT NULL,
    "finishedAt" timestamp without time zone,
    "durationMs" bigint,
    "damageDealt" bigint,
    "damageTaken" bigint,
    "verified" boolean NOT NULL DEFAULT true,
    "coinsEarned" bigint NOT NULL DEFAULT 0,
    "xpEarned" bigint NOT NULL DEFAULT 0,
    "energyChange" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE INDEX "arena_run_owner_idx" ON "arena_run" USING btree ("ownerId", "status");


--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261030133004167', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030133004167', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
