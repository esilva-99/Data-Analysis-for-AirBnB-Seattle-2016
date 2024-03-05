Tools Utilized: SQL, Tableau


This dataset from Inside Airbnb provides data for Airbnbs in Seattle for the year 2016. The goal of this project was to analyze the data in order to learn the characteristics of the most profitable Airbnbs. By gaining insights into the Airbnb market in Seattle, an investor could make an informed decision on what type of Airbnb would be the most profitable.

I began cleaning the data by removing the columns that were unusable due to too many null values. I then proceeded to use string functions to make the amenities and host_verification columns more usable. I found that an important column, the zipcode column, had too many null values. To fill these null entries, I filtered all the listings where the zipcodes were null and found their corresponding latitude, longitude, or neighborhood. By using these other columns, I was able to identify their zip code from other rows with the same value and fill it in for the missing entries.

Once the data was cleaned, I began analyzing it. I focused on understanding the role that location, property type, and seasons have on listing price.

I found that 66% of listings were entire homes/apartments, and shared rooms made up only 3% of listings. Although deciding to rent out an entire home/apartment may result in facing more competition, it may also likely have higher demand.

When looking at location, I found the zip codes with the highest and lowest average prices, which were 98134 and 98106 respectively. However, I wanted to see how the type of property affected the price of different zip codes. Perhaps a zip code had a lower average price because it had more shared room listings as opposed to full homes/apartments. I went on to investigate what a potential investor could expect to charge for an Airbnb based on location and room type.

Demand is extremely important when picking an Airbnb location; after all, you can't charge a high price if demand for your property is low. I was limited in ways to measure demand, and I ended up settling with using review_count. This is going to be a very rough estimate for demand, and it's important to be aware of this measure's biases. First of all, Airbnb does not require its users to leave reviews, so not all bookings have a review. Secondly, Airbnb users could be more compelled to leave a review if they had an extremely positive or negative experience. However, for the purpose of this analysis, I am assuming that neighborhoods with the greatest number of reviews are a direct result of a higher number of listings. Given this assumption, Broadway, Belltown, and Minor are the neighborhoods with the highest demand.

Just as important as a decision as to where to invest in Airbnb is also when. For many hosts, Airbnb is a business they engage in seasonally, so it's important to know when the business is most lucrative. Additionally, even for those hosts who are planning on hosting year-round, it's important to be aware of seasonal business trends so they know what to expect and can plan accordingly. Based on both the number of reviews and the price of listings (assuming price and demand are positively correlated), the three busiest months for Airbnb hosts in Seattle for the year 2016 were June, July, and August. Meanwhile, January and February on average generate the least amount of income for hosts. This conclusion was reached using only 2016 data, but in order to reach a more reliable conclusion, it would be necessary to have several years of data.

Lastly, I wanted to give a potential investor a guide on how much to charge for security deposits. I created an easy-to-use table which shows the average security deposits charged based on the price range of the listings.

I compiled all my findings into a comprehensive Tableau dashboard to provide a possible investor with easily digestible information on the nature and trends that he/she can expect from the Seattle Airbnb market.



