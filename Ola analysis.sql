-- Create and use database
CREATE DATABASE IF NOT EXISTS OLA;
USE OLA;

-- --------------------------------------------------
-- 1. Retrieve all successful bookings
-- --------------------------------------------------
CREATE OR REPLACE VIEW Successful_Bookings AS 
SELECT * 
FROM bookings 
WHERE Booking_Status = 'Success';

-- --------------------------------------------------
-- 2. Average ride distance for each vehicle type
-- --------------------------------------------------
CREATE OR REPLACE VIEW ride_distance_for_each_vehicle AS 
SELECT 
    Vehicle_Type, 
    ROUND(AVG(Ride_Distance), 2) AS avg_distance
FROM bookings 
GROUP BY Vehicle_Type;

-- --------------------------------------------------
-- 3. Total number of rides canceled by customers
-- --------------------------------------------------
CREATE OR REPLACE VIEW canceled_rides_by_customers AS 
SELECT 
    COUNT(Customer_ID) AS total_canceled
FROM bookings 
WHERE Booking_Status = 'Canceled by Customer';

-- --------------------------------------------------
-- 4. Top 5 customers by number of rides
-- --------------------------------------------------
CREATE OR REPLACE VIEW top_5_customers AS 
SELECT 
    Customer_ID, 
    COUNT(Booking_ID) AS total_rides
FROM bookings 
GROUP BY Customer_ID 
ORDER BY total_rides DESC 
LIMIT 5;

-- --------------------------------------------------
-- 5. Rides canceled by drivers (personal/car issues)
-- --------------------------------------------------
CREATE OR REPLACE VIEW canceled_rides_by_drivers AS 
SELECT 
    COUNT(*) AS total_driver_cancellations
FROM bookings 
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue'
AND Booking_Status = 'Canceled by Driver';

-- --------------------------------------------------
-- 6. Max and Min driver ratings for Prime Sedan
-- --------------------------------------------------
CREATE OR REPLACE VIEW Max_Min_Driver AS
SELECT 
    MAX(Driver_Ratings) AS max_rating,
    MIN(Driver_Ratings) AS min_rating
FROM bookings 
WHERE Vehicle_Type = 'Prime Sedan'
AND Driver_Ratings IS NOT NULL;

-- --------------------------------------------------
-- 7. All rides paid using UPI
-- --------------------------------------------------
CREATE OR REPLACE VIEW UPI_Payment AS 
SELECT * 
FROM bookings 
WHERE Payment_Method = 'UPI';

-- --------------------------------------------------
-- 8. Average customer rating per vehicle type
-- --------------------------------------------------
CREATE OR REPLACE VIEW AVG_Cust_Rating AS 
SELECT 
    Vehicle_Type,
    ROUND(AVG(Customer_Rating), 2) AS avg_customer_rating
FROM bookings 
GROUP BY Vehicle_Type 
ORDER BY avg_customer_rating DESC;

-- --------------------------------------------------
-- 9. Total booking value of successful rides
-- --------------------------------------------------
CREATE OR REPLACE VIEW total_successful_ride_value AS 
SELECT 
    SUM(Booking_Value) AS total_revenue
FROM bookings 
WHERE Booking_Status = 'Success';

-- --------------------------------------------------
-- 10. Incomplete rides with reason
-- --------------------------------------------------
CREATE OR REPLACE VIEW Incomplete_Rides_Reason AS 
SELECT 
    Booking_ID,
    Incomplete_Rides_Reason
FROM bookings 
WHERE Incomplete_Rides = 'Yes';