CREATE OR REPLACE STREAM "DESTINATION_CAPTAINS_SCORES" ("favoritecaptain" VARCHAR(32), average_rating INTEGER, total_rating INTEGER);

CREATE OR REPLACE  PUMP "STREAM_PUMP" AS INSERT INTO "DESTINATION_CAPTAINS_SCORES"

    SELECT STREAM "favoritecaptain", avg("rating") as average_rating, sum("rating") as total_rating
    FROM "SOURCE_SQL_STREAM_001"

    GROUP BY "favoritecaptain", STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '1' MINUTE)
    ORDER BY STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '1' MINUTE), sum("rating") DESC;
