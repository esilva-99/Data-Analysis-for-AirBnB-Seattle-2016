--The Goal is to get insight on the pricing differences between airbnb's
--Skills Used: Aggregate Functions, CTE's, Joins, Window Functions, String Functions, Case Expression

-------------------------------------------------------------------Part 1 : Data Cleaning------------------------------------------------------------------------

--Dropping columns that are unusable due to too many nulls
SELECT COUNT (*) AS total_number_of_nulls
FROM Project_3.dbo.Listings
WHERE square_feet IS NULL

SELECT COUNT (*) AS total__of_not_nulls
FROM Project_3.dbo.Listings
WHERE square_feet IS NOT NULL

ALTER TABLE project_3.dbo.listings
DROP COLUMN square_feet

ALTER TABLE project_3.dbo.listings
DROP COLUMN license


--Clean amenities column in Listings table
SELECT TRIM('{, }, "' FROM amenities)
FROM Project_3.dbo.Listings

UPDATE Project_3.dbo.Listings
SET amenities = TRIM('{, }, "' FROM amenities)

UPDATE Project_3.dbo.Listings
SET amenities = REPLACE(amenities, '"', '')

--Clean host_verification column
UPDATE Project_3.dbo.Listings
SET host_verifications = TRIM('[, ]' FROM host_verifications)

UPDATE Project_3.dbo.Listings
SET host_verifications = REPLACE(host_verifications, '''', '')

--Populating zip code column by using latitude and longitude
SELECT id, neighbourhood_cleansed,street, latitude, longitude, zipcode
FROM Project_3.dbo.Listings
WHERE zipcode IS NULL

UPDATE Project_3.dbo.Listings
SET zipcode = '98122'
WHERE id = 9448215

UPDATE Project_3.dbo.Listings
SET zipcode = '98122'
WHERE ID = 4172364

UPDATE Project_3.dbo.Listings
SET zipcode = '98104'
WHERE ID = 8355276

UPDATE Project_3.dbo.Listings
SET zipcode = '98199'
WHERE id = 2134911

UPDATE Project_3.dbo.Listings
SET zipcode = '98102'
WHERE id = 2332949

UPDATE Project_3.DBO.Listings
SET zipcode = '98122'
WHERE id = 9774404

UPDATE Project_3.dbo.Listings
SET zipcode = '98107'
WHERE id = 2039149

UPDATE Project_3.dbo.Listings
SET zipcode = '98119'
WHERE id = 610989

---------------------------------------Part 2: Analyzing price breakdown by zipcode--------------------------------------------------------------


--Finding all the different types of room_type
SELECT COUNT(*) AS count, room_type
FROM Project_3.dbo.Listings
GROUP BY room_type

--Percent makeup of room_type of all listings
WITH CTE AS (
SELECT COUNT(*) AS room_count, room_type
FROM Project_3.dbo.Listings
GROUP BY room_type)

SELECT room_type, room_count, 100*room_count/( SELECT SUM(room_count) FROM CTE) AS percent_of_total
FROM CTE


--Investigating price distribution by zip code
SELECT zipcode, AVG(price) AS avg_price, MIN(price) AS min, MAX(price) AS max
FROM Project_3.dbo.Listings
GROUP BY zipcode
ORDER BY avg_price DESC

--Identifying the top and bottom 5 most and least expensive zipcodes
SELECT zipcode, avg_price, row_number
FROM(
	SELECT zipcode, AVG(price) AS avg_price, ROW_NUMBER() OVER(ORDER BY AVG(price) DESC) AS row_number
	FROM Project_3.dbo.Listings
	GROUP BY zipcode) AS table_1
WHERE row_number <=5 

UNION

SELECT zipcode, avg_price, row_number
FROM(
	SELECT zipcode, AVG(price) AS avg_price, ROW_NUMBER() OVER(ORDER BY AVG(price) DESC) AS row_number
	FROM Project_3.dbo.Listings
	GROUP BY zipcode) AS table_2
WHERE row_number >22 
ORDER BY avg_price DESC


--Distribution of room_type by zip code
SELECT zipcode, room_type, count(*) AS count
FROM project_3.dbo.listings
group by zipcode, room_type
ORDER BY zipcode, room_type

--Understanding how the price distribution by zip code change when taking the variable room_type into consideration
SELECT zipcode, AVG(price) AS avg_price, MIN(price) AS min, MAX(price) AS max
FROM Project_3.dbo.Listings
WHERE room_type = 'Entire home/apt'
GROUP BY zipcode
ORDER BY avg_price DESC

SELECT zipcode, AVG(price) AS avg_price, MIN(price) AS min, MAX(price) AS max
FROM Project_3.dbo.Listings
WHERE room_type = 'private room'
GROUP BY zipcode
ORDER BY avg_price DESC

SELECT zipcode, AVG(price) AS avg_price, MIN(price) AS min, MAX(price) AS max
FROM Project_3.dbo.Listings
WHERE room_type = 'Shared room'
GROUP BY zipcode
ORDER BY avg_price DESC

--Understanding how demand differs across Seattle using number of reviews
SELECT zipcode, neighbourhood_cleansed, COUNT(r.id) AS reviews_count
FROM Project_3.DBO.Listings l
LEFT JOIN Project_3.dbo.Reviews r
		ON l.id = r.listing_id
GROUP BY neighbourhood_cleansed, zipcode
ORDER BY reviews_count DESC

-----------------------------------------------Part 3: Analyzing seasonal change
--Seasonal changes in price for airbnb (summer is the peak season)
SELECT MONTH(date) AS month, YEAR(date) AS year, AVG(price) AS avg_price
FROM Project_3.dbo.Calendar 
GROUP BY MONTH(date), Year(date)
ORDER BY year, month


--Seasonal demand using the reviews table
SELECT MONTH(date) AS month, COUNT(id) AS number_of_reviews
FROM Project_3.DBO.Reviews
GROUP BY MONTH(date)
ORDER BY month
----------------------------------------Part 3: Investigating other factors 

--What kind of listings ask for a security deposit?
select security_deposit, id, price, room_type, accommodates
from Project_3.DBO.Listings
where security_deposit IS NOT NULL

--How much should one charge for a security deposit given the price per night of their Airbnb

SELECT AVG(security_deposit) AS avg_security_deposit, 
		CASE
			WHEN price >=0 AND price <100 THEN '0-99'
			WHEN price >=100 AND price <200 THEN '100-199'
			WHEN price >=200 AND price <300 THEN '200-299'
			WHEN price >=300 AND price <400 THEN '300-399'
			WHEN price >=400 AND price <500 THEN '400-499'
			WHEN price >=500 AND price <600 THEN '500-599'
			WHEN price >=700 AND price <800 THEN '700-799'
			WHEN price >=900 AND price <1000 THEN '900-999'
			ELSE 'greater than or equal to 1000'
		END AS price_range,
	 COUNT(id) AS total_number_of_listings
FROM Project_3.dbo.Listings
GROUP BY CASE
			WHEN price >=0 AND price <100 THEN '0-99'
			WHEN price >=100 AND price <200 THEN '100-199'
			WHEN price >=200 AND price <300 THEN '200-299'
			WHEN price >=300 AND price <400 THEN '300-399'
			WHEN price >=400 AND price <500 THEN '400-499'
			WHEN price >=500 AND price <600 THEN '500-599'
			WHEN price >=700 AND price <800 THEN '700-799'
			WHEN price >=900 AND price <1000 THEN '900-999'
			ELSE 'greater than or equal to 1000'
		END 
ORDER BY price_range
