BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "crypto_wallet" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "address" text NOT NULL,
    "isTest" boolean NOT NULL,
    "showPetPhoto" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "crypto_wallet_owner_idx" ON "crypto_wallet" USING btree ("ownerId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "keepsake" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "key" text NOT NULL,
    "editionGroup" text NOT NULL,
    "edition" bigint NOT NULL,
    "title" text NOT NULL,
    "emoji" text NOT NULL,
    "petName" text NOT NULL,
    "speciesKey" text NOT NULL,
    "portraitId" bigint,
    "stat" text,
    "earnedAt" timestamp without time zone NOT NULL,
    "walletAddress" text NOT NULL,
    "txHash" text,
    "chainId" bigint NOT NULL,
    "mintedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "keepsake_owner_key_idx" ON "keepsake" USING btree ("ownerId", "key");
CREATE UNIQUE INDEX "keepsake_edition_idx" ON "keepsake" USING btree ("editionGroup", "edition");


--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261030171654965', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030171654965', "timestamp" = now();

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
