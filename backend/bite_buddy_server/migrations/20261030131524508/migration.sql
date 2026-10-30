BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "duel" (
    "id" bigserial PRIMARY KEY,
    "leagueId" bigint NOT NULL,
    "weekStart" timestamp without time zone NOT NULL,
    "aUserId" uuid NOT NULL,
    "bUserId" uuid NOT NULL,
    "aPetName" text NOT NULL,
    "bPetName" text NOT NULL,
    "aSpeciesKey" text NOT NULL,
    "bSpeciesKey" text NOT NULL,
    "aMaxHp" bigint NOT NULL,
    "bMaxHp" bigint NOT NULL,
    "aAttack" bigint NOT NULL,
    "bAttack" bigint NOT NULL,
    "aDefense" bigint NOT NULL,
    "bDefense" bigint NOT NULL,
    "aHp" bigint NOT NULL,
    "bHp" bigint NOT NULL,
    "aSpecialCooldown" bigint NOT NULL,
    "bSpecialCooldown" bigint NOT NULL,
    "aMove" text,
    "bMove" text,
    "aMissed" bigint NOT NULL,
    "bMissed" bigint NOT NULL,
    "aHistory" json NOT NULL,
    "bHistory" json NOT NULL,
    "round" bigint NOT NULL,
    "roundDeadline" timestamp without time zone NOT NULL,
    "status" text NOT NULL,
    "winnerUserId" uuid,
    "endReason" text,
    "lastRound" json,
    "createdAt" timestamp without time zone NOT NULL,
    "finishedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "duel_league_idx" ON "duel" USING btree ("leagueId");
CREATE INDEX "duel_a_idx" ON "duel" USING btree ("aUserId");
CREATE INDEX "duel_b_idx" ON "duel" USING btree ("bUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "league" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "inviteCode" text NOT NULL,
    "ownerId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "league_invite_code_idx" ON "league" USING btree ("inviteCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "league_member" (
    "id" bigserial PRIMARY KEY,
    "leagueId" bigint NOT NULL,
    "userId" uuid NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "league_member_unique_idx" ON "league_member" USING btree ("leagueId", "userId");
CREATE INDEX "league_member_user_idx" ON "league_member" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "season_result" (
    "id" bigserial PRIMARY KEY,
    "leagueId" bigint NOT NULL,
    "weekStart" timestamp without time zone NOT NULL,
    "winnerUserId" uuid,
    "standings" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "season_result_unique_idx" ON "season_result" USING btree ("leagueId", "weekStart");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "trophy" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "leagueId" bigint NOT NULL,
    "leagueName" text NOT NULL,
    "weekStart" timestamp without time zone NOT NULL,
    "score" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "trophy_user_idx" ON "trophy" USING btree ("userId");


--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261030131524508', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030131524508', "timestamp" = now();

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
