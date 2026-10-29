BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "battle" ADD COLUMN "opponentNextMove" text;
ALTER TABLE "battle" ADD COLUMN "opponentTell" text;

--
-- MIGRATION VERSION FOR bite_buddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bite_buddy', '20261029100527397', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261029100527397', "timestamp" = now();

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
