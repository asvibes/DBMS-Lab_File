
CREATE DATABASE IF NOT EXISTS Railway_Optimization;
USE Railway_Optimization;

DROP TABLE IF EXISTS Railway_Booking;

-- 2. CREATE TABLE

CREATE TABLE Railway_Booking (
    booking_id INT PRIMARY KEY,
    passenger_name VARCHAR(100),
    train_no INT,
    train_name VARCHAR(100),
    source_station VARCHAR(50),
    destination_station VARCHAR(50),
    journey_date DATE,
    seat_no INT,
    ticket_price DECIMAL(10,2),
    booking_status VARCHAR(20),
    payment_mode VARCHAR(30)
);

-- 3. GENERATE 10,000 RECORDS

SET SESSION cte_max_recursion_depth = 11000;

INSERT INTO Railway_Booking
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10000
)
SELECT
    n,
    CONCAT('Passenger_', n),
    12000 + (n % 100),
    CONCAT('Express_', n % 100),

    CASE n % 6
        WHEN 0 THEN 'Delhi'
        WHEN 1 THEN 'Mumbai'
        WHEN 2 THEN 'Lucknow'
        WHEN 3 THEN 'Kolkata'
        WHEN 4 THEN 'Chennai'
        ELSE 'Bangalore'
    END,

    CASE n % 6
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Kolkata'
        WHEN 3 THEN 'Chennai'
        WHEN 4 THEN 'Bangalore'
        ELSE 'Lucknow'
    END,

    DATE_ADD('2026-01-01', INTERVAL (n % 365) DAY),

    (n % 72) + 1,

    300 + (n % 2000),

    CASE n % 3
        WHEN 0 THEN 'Confirmed'
        WHEN 1 THEN 'Waiting'
        ELSE 'Cancelled'
    END,

    CASE n % 3
        WHEN 0 THEN 'UPI'
        WHEN 1 THEN 'Card'
        ELSE 'Cash'
    END

FROM numbers;

-- 4. VERIFY DATASET

SELECT COUNT(*) AS Total_Records
FROM Railway_Booking;

SELECT * FROM Railway_Booking LIMIT 10;


-- =====================================================
-- 5. FIVE SLOW QUERIES (BEFORE OPTIMIZATION)
-- =====================================================

-- SLOW QUERY 1:
-- Search passengers by train number

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE train_no = 12005;


-- SLOW QUERY 2:
-- Search bookings by source, destination and date

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
AND destination_station = 'Mumbai'
AND journey_date = '2026-01-10';


-- SLOW QUERY 3:
-- Search bookings by status and payment mode

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE booking_status = 'Confirmed'
AND payment_mode = 'UPI';


-- SLOW QUERY 4:
-- Find expensive tickets using a calculation
-- on the indexed candidate column

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE ticket_price * 2 > 2000;


-- SLOW QUERY 5:
-- Find bookings in a particular year
-- Using a function on journey_date

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE YEAR(journey_date) = 2026;


-- =====================================================
-- 6. CREATE INDEXES FOR OPTIMIZATION
-- =====================================================

-- Single-column index

CREATE INDEX idx_train
ON Railway_Booking(train_no);


-- Composite index for route and date

CREATE INDEX idx_route_date
ON Railway_Booking(
    source_station,
    destination_station,
    journey_date
);


-- Composite index for status and payment

CREATE INDEX idx_status_payment
ON Railway_Booking(
    booking_status,
    payment_mode
);


-- Single-column index for ticket price

CREATE INDEX idx_price
ON Railway_Booking(ticket_price);


-- Single-column index for journey date

CREATE INDEX idx_journey_date
ON Railway_Booking(journey_date);


-- =====================================================
-- 7. OPTIMIZED QUERIES (AFTER INDEXING)
-- =====================================================

-- OPTIMIZED QUERY 1:
-- Uses train number index

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE train_no = 12005;


-- OPTIMIZED QUERY 2:
-- Uses composite route and date index

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
AND destination_station = 'Mumbai'
AND journey_date = '2026-01-10';


-- OPTIMIZED QUERY 3:
-- Uses composite status and payment index

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE booking_status = 'Confirmed'
AND payment_mode = 'UPI';


-- OPTIMIZED QUERY 4:
-- Removes multiplication from WHERE condition

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE ticket_price > 1000;


-- OPTIMIZED QUERY 5:
-- Removes YEAR() function from indexed date column

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE journey_date >= '2026-01-01'
AND journey_date < '2027-01-01';


-- =====================================================
-- 8. MEASURE EXECUTION TIME AFTER OPTIMIZATION
-- =====================================================

-- QUERY 1

SET @start_time = NOW(6);

SELECT *
FROM Railway_Booking
WHERE train_no = 12005;

SET @end_time = NOW(6);

SELECT TIMESTAMPDIFF(
    MICROSECOND, @start_time, @end_time
) AS Query1_Time_Microseconds;


-- QUERY 2

SET @start_time = NOW(6);

SELECT *
FROM Railway_Booking
WHERE source_station = 'Delhi'
AND destination_station = 'Mumbai'
AND journey_date = '2026-01-10';

SET @end_time = NOW(6);

SELECT TIMESTAMPDIFF(
    MICROSECOND, @start_time, @end_time
) AS Query2_Time_Microseconds;


-- QUERY 3

SET @start_time = NOW(6);

SELECT *
FROM Railway_Booking
WHERE booking_status = 'Confirmed'
AND payment_mode = 'UPI';

SET @end_time = NOW(6);

SELECT TIMESTAMPDIFF(
    MICROSECOND, @start_time, @end_time
) AS Query3_Time_Microseconds;


-- QUERY 4

SET @start_time = NOW(6);

SELECT *
FROM Railway_Booking
WHERE ticket_price > 1000;

SET @end_time = NOW(6);

SELECT TIMESTAMPDIFF(
    MICROSECOND, @start_time, @end_time
) AS Query4_Time_Microseconds;


-- QUERY 5

SET @start_time = NOW(6);

SELECT *
FROM Railway_Booking
WHERE journey_date >= '2026-01-01'
AND journey_date < '2027-01-01';

SET @end_time = NOW(6);

SELECT TIMESTAMPDIFF(
    MICROSECOND, @start_time, @end_time
) AS Query5_Time_Microseconds;


-- =====================================================
-- 9. DISPLAY ALL INDEXES
-- =====================================================

SHOW INDEX FROM Railway_Booking;


-- =====================================================
-- 10. FINAL DATASET VERIFICATION
-- =====================================================

SELECT COUNT(*) AS Total_Bookings
FROM Railway_Booking;

SELECT
    booking_status,
    COUNT(*) AS Total_Bookings
FROM Railway_Booking
GROUP BY booking_status;

-- -- =====================================================
-- -- END OF PRACTICAL
-- -- =====================================================
