BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "challenge" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "ownerId" uuid NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "challenge_code_idx" ON "challenge" USING btree ("code");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "challenge_member" (
    "id" bigserial PRIMARY KEY,
    "challengeId" bigint NOT NULL,
    "userId" uuid NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "challenge_member_idx" ON "challenge_member" USING btree ("challengeId", "userId");
CREATE INDEX "challenge_member_user_idx" ON "challenge_member" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "friendship" (
    "id" bigserial PRIMARY KEY,
    "requesterId" uuid NOT NULL,
    "addresseeId" uuid NOT NULL,
    "accepted" boolean NOT NULL,
    "sharedStreak" bigint NOT NULL,
    "sharedStreakDay" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "friendship_pair_idx" ON "friendship" USING btree ("requesterId", "addresseeId");
CREATE INDEX "friendship_addressee_idx" ON "friendship" USING btree ("addresseeId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "pet" ADD COLUMN "friendCode" text;
CREATE UNIQUE INDEX "pet_friend_code_idx" ON "pet" USING btree ("friendCode");

--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261028081428474', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261028081428474', "timestamp" = now();

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
