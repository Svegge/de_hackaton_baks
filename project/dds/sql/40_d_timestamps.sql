--d_timestamps
WITH ts AS (
 SELECT DISTINCT event_timestamp
 FROM stg.stg_logs
)
INSERT INTO dds.d_timestamps
(ts, "year", "month", "day", "hour", "minute", "second")
SELECT 
 DISTINCT event_timestamp::TIMESTAMP AS ts,
 DATE_PART('year', event_timestamp::TIMESTAMP) AS "year",
 DATE_PART('month', event_timestamp::TIMESTAMP) AS "month",
 DATE_PART('day', event_timestamp::TIMESTAMP) AS "day",
 DATE_PART('hour', event_timestamp::TIMESTAMP) AS "hour",
 DATE_PART('minute', event_timestamp::TIMESTAMP) AS "minute",
 DATE_PART('second', event_timestamp::TIMESTAMP)::INT  AS "second"
FROM ts;
