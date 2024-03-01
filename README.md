Tools Utilized: SQL, Tableau

This dataset from Inside Airbnb provides data for Airbnb's in Seattle for the year of 2016. The goal of this project was to analyze the data in order to learn what are the characteristics of the most profitable Airbnbs. By gaining insights into the Airbnb market in Seattle an investor could make an informed decision on what type of airbnb would be the most profitable. 

I began cleaning the data by removing the columns that were unusable due to too many nulls. I then proceeded to use string functions to make the amenities and host_verfication more usable. I found that an important column, the zipcode column, had many nulls. To fill these null entries I filtered all the listings where the zipcode was null and found its corresponding latitude, longitude, or neighborhood. By using these other columns I was able to use other rows with the same value, indetify its zipcode, and fill it in for the missing entry. 

Once the data was cleaned I began analyzing it. I focused on understanding the role that Location, type of property, and blah had on a listings price. 

I found that 66% of listings were entire homes/apt, and shared rooms made up only 3% of listings. Although deciding to rent out an entire home/apt one will face more competition, it may also have a higher demand. 

When looking at location I found the zipcodes with highest and lowest average prices, they were 98134 and 98106 respectively. However, I wanted to see how the type of property affected the price of differnt zipcodes. Perhaps a zipcode had a lower average price because it had more shared room listings as opposed to full homes/apts. 

