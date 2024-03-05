Tools Utilized: SQL, Tableau

This dataset from Inside Airbnb provides data for Airbnbs in Seattle for the year of 2016. The goal of this project was to analyze the data in order to learn what are the characteristics of the most profitable Airbnbs. By gaining insights into the Airbnb market in Seattle an investor could make an informed decision on what type of airbnb would be the most profitable. 

I began cleaning the data by removing the columns that were unusable due to too many nulls. I then proceeded to use string functions to make the amenities and host_verfication columns more usable. I found that an important column, the zipcode column, had too many nulls. To fill these null entries I filtered all the listings where the zipcodes were null and found their corresponding latitude, longitude, or neighborhood. By using these other columns I was able to use other rows with the same value, indetify its zipcode, and fill it in for the missing entries. 

Once the data was cleaned I began analyzing it. I focused on understanding the role that Location, type of property, and blah had on a listings price. 

I found that 66% of listings were entire homes/apt, and shared rooms made up only 3% of listings. Although deciding to rent out an entire home/apt one will face more competition, it may also likely have a higher demand. 

When looking at location I found the zipcodes with highest and lowest average prices, they were 98134 and 98106 respectively. However, I wanted to see how the type of property affected the price of differnt zipcodes. Perhaps a zipcode had a lower average price because it had more shared room listings as opposed to full homes/apts. I went on to investigate what could a potential investor expect to charge for an Airbnb based on location and room_type. 

Demand is extremely important when picking an Airbnb location, afterall you can charge a high price if demand for your property is low. I was limited in ways to measure demand, and I ended settling with using review_count. This is going to be a very rough estimate for demand, and it's important to be aware of this measure's biases. First of all, Airbnb does not require its users to leave reviews, so not all bookings necessarily have a review. Secondly, Airbnb users could be more compelled to leave a review if they had an extremely positive or negative experience. However, for the purpose of this analyses I am assuming that nighborhoods with the greatest number of reviews are a direct result of higher number of listings. Given this assumption Broadway, Belltown, and Minor are the neighborhoods with highest demand. 
