BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "pet" ADD COLUMN "streak" bigint NOT NULL DEFAULT 0;
ALTER TABLE "pet" ADD COLUMN "bestStreak" bigint NOT NULL DEFAULT 0;
ALTER TABLE "pet" ADD COLUMN "lastStreakDay" timestamp without time zone;
ALTER TABLE "pet" ADD COLUMN "utcOffsetMinutes" bigint NOT NULL DEFAULT 0;

--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261027232107692', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261027232107692', "timestamp" = now();

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
