-- Upgrade MetaStore schema from 3.2.0 to 4.0.0
-- HIVE-19416
ALTER TABLE "APP"."TBLS" ADD WRITE_ID bigint DEFAULT 0;
ALTER TABLE "APP"."PARTITIONS" ADD WRITE_ID bigint DEFAULT 0;

-- HIVE-20793
ALTER TABLE "APP"."WM_RESOURCEPLAN" ADD NS VARCHAR(128);
UPDATE "APP"."WM_RESOURCEPLAN" SET NS = 'default' WHERE NS IS NULL;
DROP INDEX "APP"."UNIQUE_WM_RESOURCEPLAN";
CREATE UNIQUE INDEX "APP"."UNIQUE_WM_RESOURCEPLAN" ON "APP"."WM_RESOURCEPLAN" ("NS", "NAME");

-- HIVE-21063
CREATE UNIQUE INDEX "APP"."NOTIFICATION_LOG_EVENT_ID" ON "APP"."NOTIFICATION_LOG" ("EVENT_ID");

-- This needs to be the last thing done.  Insert any changes above this line.
UPDATE "APP".VERSION SET SCHEMA_VERSION='4.0.0', VERSION_COMMENT='Hive release version 4.0.0' where VER_ID=1;

