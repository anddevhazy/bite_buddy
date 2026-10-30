BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "duel" ADD COLUMN "aPortraitId" bigint;
ALTER TABLE "duel" ADD COLUMN "bPortraitId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "pet" ADD COLUMN "portraitId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "pet_portrait" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "image" bytea NOT NULL,
    "animal" text NOT NULL,
    "used" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "pet_portrait_owner_idx" ON "pet_portrait" USING btree ("ownerId");


--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261030161715810', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030161715810', "timestamp" = now();

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
