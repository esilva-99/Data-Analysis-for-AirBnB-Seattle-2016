--The Goal is to get insight on the pricing differences between airbnb's
-------Part 1: Cleaning the Data-------

--Remove quotation marks from reviews table and Add to Table
UPDATE dbo.Reviews
SET	listing_id = TRIM('"'  FROM listing_id) 

UPDATE project2.dbo.Reviews
SET	review_id = TRIM('"'  FROM review_id) 

UPDATE dbo.Reviews
SET	date = TRIM('"'  FROM date) 

UPDATE dbo.Reviews
SET	reviewer_id = TRIM('"'  FROM listing_id) 

--Standardize Date Format from reviews table

ALTER TABLE dbo.reviews
Add DateConverted Date;

Update dbo.reviews
SET DateConverted = CONVERT(Date,Date)

--Clean ameneties column from listings table
SELECT TRIM('[, ], "' FROM amenities)
FROM project2.dbo.Listings


UPDATE Project2.dbo.Listings$
SET	amenities = TRIM(BOTH '[ , "'  FROM amenities) 

UPDATE [Project 2].[dbo].[Listings]
SET amenities = REPLACE(amenities, '"', '')

--Standardize host_since date format from listings table
ALTER TABLE dbo.Listings
ADD HostSince_Converted Date;

UPDATE  [Project 2].[dbo].[Listings]
SET [HostSince_Converted] = CONVERT(date,host_since) 

--checking to see if listing_id in Listing Table is unique 
SELECT COUNT(listing_id), COUNT(DISTINCT listing_id)
FROM project2.dbo.Listings

--Checking to see if review_id in Reviews Table is qunique
SELECT COUNT(review_id) AS total, COUNT(DISTINCT review_id) AS unique_total
FROM project2.dbo.Reviews

--Checking to see if listing_id is unique in Reviews Table
SELECT COUNT(listing_id), COUNT(DISTINCT listing_id)
FROM Project2.dbo.Reviews

--Identifying the duplicate review_id's
WITH CTE AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY review_id ORDER BY review_id) AS row_number
		FROM project2.dbo.reviews)
SELECT * 
FROM CTE
WHERE row_number > 1 
ORDER BY review_id

--Checking to see if they are duplicated entries by testing some duplicate review_id's
WITH CTE AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY review_id ORDER BY review_id) AS row_number
		FROM project2.dbo.reviews)
SELECT * 
FROM CTE
WHERE review_id = 200088015 OR review_id =205182329  OR review_id = 223954194 OR review_id=256197483 OR review_id=256940062 OR review_id=267670224 OR review_id=268584240 OR review_id=273473836

--160 Duplicate review_id's also have the same date but have different listing_id's and reviewer_id.
--Therefore, this is not duplicate entries and I will therefore be ignoring dbo.reviews table because it is unreliable
--Upon further inspection it appears that the reviwer_id and listing_id is the same for every entry in reviews table


---------------PART 2: DATA EXPLORATION---------------
------QUESTION 1: How does the airbnb market vary between citites

--Number of listings per city

SELECT city, COUNT(*) AS count
FROM project2.dbo.listings
GROUP BY city
ORDER BY count DESC

--Which city has the highest number of instant bookable?
WITH CTE AS (
SELECT city, instant_bookable 
FROM Project2.dbo.Listings
WHERE instant_bookable = 't'
)

SELECT city, COUNT(city) AS count
FROM CTE
GROUP BY city
ORDER BY count DESC

--How does the price of the airbnb compare across cities? 
--Note: price in each country's currency, and I can't convert it all to U.S dollars because litings don't have a date i can use for the exchange rate
--therefore, can only compare price among cities

Select city, amenities, AVG(price) AS average_price
FROM Project2.dbo.Listings
GROUP BY city, amenities
ORDER BY average_price DESC


--correlation between amenities and price 
