BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "activity_day" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "day" timestamp without time zone NOT NULL,
    "steps" bigint NOT NULL,
    "sleepMinutes" bigint NOT NULL,
    "energyAwarded" bigint NOT NULL,
    "healthAwarded" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "activity_day_owner_day_idx" ON "activity_day" USING btree ("ownerId", "day");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_ideas" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "day" timestamp without time zone NOT NULL,
    "ideas" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "meal_ideas_owner_day_idx" ON "meal_ideas" USING btree ("ownerId", "day");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "season_result" ADD COLUMN "challengeCompleted" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "streak_buddy" (
    "id" bigserial PRIMARY KEY,
    "aUserId" uuid NOT NULL,
    "bUserId" uuid NOT NULL,
    "accepted" boolean NOT NULL,
    "streak" bigint NOT NULL,
    "bestStreak" bigint NOT NULL,
    "aLastFedDay" timestamp without time zone,
    "bLastFedDay" timestamp without time zone,
    "lastStreakDay" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "streak_buddy_pair_idx" ON "streak_buddy" USING btree ("aUserId", "bUserId");
CREATE INDEX "streak_buddy_b_idx" ON "streak_buddy" USING btree ("bUserId");


--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261030155434741', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030155434741', "timestamp" = now();

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
