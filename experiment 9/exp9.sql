-- ============================================
-- RAILWAY BOOKING INDEX PERFORMANCE BENCHMARK
-- ============================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS RailwayDB;
USE RailwayDB;

-- -- 2. CREATE TABLE
-- DROP TABLE IF EXISTS Railway_Booking;

CREATE TABLE Railway_Booking (
    booking_id INT PRIMARY KEY,
    passenger_name VARCHAR(50),
    train_no INT,
    train_name VARCHAR(50),
    source_station VARCHAR(50),
    destination_station VARCHAR(50),
    journey_date DATE,
    seat_no INT,
    ticket_price DECIMAL(10,2),
    booking_status VARCHAR(20)
);

-- 3. INSERT 5000 RECORDS
 SET SESSION cte_max_recursion_depth = 6000;

INSERT INTO Railway_Booking
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 5000
)
SELECT
    n,
    CONCAT('Passenger_', n),
    12000 + (n % 20),
    CONCAT('Express_', n % 20),
    CASE n % 5
        WHEN 0 THEN 'Delhi'
        WHEN 1 THEN 'Mumbai'
        WHEN 2 THEN 'Lucknow'
        WHEN 3 THEN 'Kolkata'
        ELSE 'Chennai'
    END,
    CASE n % 5
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Kolkata'
        WHEN 3 THEN 'Chennai'
        ELSE 'Lucknow'
    END,
    DATE_ADD('2026-01-01', INTERVAL (n % 365) DAY),
    n % 72 + 1,
    300 + (n % 1700),
    CASE n % 3
        WHEN 0 THEN 'Confirmed'
        WHEN 1 THEN 'Waiting'
        ELSE 'Cancelled'
    END
FROM numbers;

-- -- 4. VERIFY RECORDS
SELECT COUNT(*) AS Total_Records
FROM Railway_Booking;

SELECT * FROM Railway_Booking LIMIT 10;

-- ============================================
-- 5. BEFORE INDEXING
-- ============================================

-- Query 1: Search by train number
EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE train_no = 12005;

-- Query 2: Search by route and journey date
EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
AND destination_station = 'Mumbai'
AND journey_date = '2026-01-10';

-- ============================================
-- 6. CREATE SINGLE COLUMN INDEX
-- ============================================

CREATE INDEX idx_train_no
ON Railway_Booking(train_no);

-- Check query execution after single index
EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE train_no = 12005;

-- ============================================
-- 7. CREATE COMPOSITE INDEX
-- ============================================

CREATE INDEX idx_route_date
ON Railway_Booking(
    source_station,
    destination_station,
    journey_date
);

-- Check query execution after composite index
EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
AND destination_station = 'Mumbai'
AND journey_date = '2026-01-10';

-- ============================================
-- 8. DISPLAY ALL INDEXES
-- ============================================

SHOW INDEX FROM Railway_Booking;

-- ============================================
-- 9. FINAL EXECUTION PLAN
-- ============================================

EXPLAIN
SELECT *
FROM Railway_Booking
WHERE train_no = 12005;

EXPLAIN
SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
AND destination_station = 'Mumbai'
AND journey_date = '2026-01-10';

-- ============================================
-- 10. BENCHMARK EXECUTION TIME
-- ============================================

-- Train number query timing
SET @start_time = NOW(6);

SELECT *
FROM Railway_Booking
WHERE train_no = 12005;

SET @end_time = NOW(6);

SELECT TIMESTAMPDIFF(
    MICROSECOND,
    @start_time,
    @end_time
) AS Train_Query_Time_Microseconds;

-- Route query timing
SET @start_time = NOW(6);

SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
AND destination_station = 'Mumbai'
AND journey_date = '2026-01-10';

SET @end_time = NOW(6);

SELECT TIMESTAMPDIFF(
    MICROSECOND,
    @start_time,
    @end_time
) AS Route_Query_Time_Microseconds;



