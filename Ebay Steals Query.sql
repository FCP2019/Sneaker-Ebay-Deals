WITH cte as (SELECT Shoe,  ListingTitle, AVGEbayPrice, Price, URL, AVGEbayPrice-Price AS DistanceFromAvg, 
CASE WHEN Shoe LIKE '%yeezy boost 700%' THEN 'Yeezy Boost 700'
			WHEN Shoe LIKE '%yeezy boost 350%' THEN 'Yeezy Boost 350'
			WHEN Shoe LIKE '%yeezy 500%' THEN 'Yeezy 500'
			WHEN Shoe LIKE '%yeezy slides%' THEN 'Yeezy Slides'
			WHEN Shoe LIKE '%yeezy foam runner%' THEN 'Yeezy Foam Runner'
			WHEN Shoe LIKE '%air max%' THEN 'Air Max'
			WHEN Shoe LIKE '%vapormax%' THEN 'vapor max'
			WHEN Shoe LIKE '%jordan 1 %' THEN 'Jordan 1'
			WHEN Shoe LIKE '%jordan 2%' THEN 'Jordan 2'
			WHEN Shoe LIKE '%jordan 3%' THEN 'Jordan 3'
			WHEN Shoe LIKE '%jordan 4%' THEN 'Jordan 4'
			WHEN Shoe LIKE '%jordan 5%' THEN 'Jordan 5'
			WHEN Shoe LIKE '%jordan 6%' THEN 'Jordan 6'
			WHEN Shoe LIKE '%jordan 7%' THEN 'Jordan 7'
			WHEN Shoe LIKE '%jordan 8%' THEN 'Jordan 8'
			WHEN Shoe LIKE '%jordan 9%' THEN 'Jordan 9'
			WHEN Shoe LIKE '%jordan 10%' THEN 'Jordan 10'
			WHEN Shoe LIKE '%jordan 11%' THEN 'Jordan 11'
			WHEN Shoe LIKE '%jordan 12%' THEN 'Jordan 12'
			WHEN Shoe LIKE '%jordan 13%' THEN 'Jordan 13'
			WHEN Shoe LIKE '%jordan 14%' THEN 'Jordan 14'
			WHEN Shoe LIKE '%nmd%' THEN 'NMD'
			WHEN Shoe LIKE '%dunk low%' THEN 'Dunk Low'
			WHEN Shoe LIKE '%dunk high%' THEN 'Dunk High'
			WHEN Shoe LIKE '%air force 1%' THEN 'Air Force 1'
			WHEN Shoe LIKE '%550%' THEN 'New Balance 550'
			WHEN Shoe LIKE '%blazer%' THEN 'Blazer'
			ELSE 'Other' END AS Model,
			
CASE WHEN Shoe LIKE '%yeezy%' THEN 'Adidas'
			WHEN Shoe LIKE '%adidas%' THEN 'Adidas'
			WHEN Shoe LIKE '%jordan%' THEN 'Air Jordan'
			WHEN Shoe LIKE '%550%' THEN 'New Balance'
			WHEN Shoe LIKE '%dunk%' THEN 'Nike'
			WHEN Shoe LIKE '%air max%' THEN 'Nike'
			WHEN Shoe LIKE '%vapormax%' THEN 'Nike'
			WHEN Shoe LIKE '%air force 1%' THEN 'Nike'
			WHEN Shoe LIKE '%blazer' THEN 'Nike'
			ELSE 'Other' END AS Brand
			
FROM (SELECT  ListingTitle, ROUND(avg(Price) OVER (PARTITION BY Shoe),2) as AVGEbayPrice, Price, URL, Shoe
FROM products
))

SELECT *
FROM cte
WHERE ListingTitle NOT  IN
	(SELECT ListingTitle
	  FROM cte
	 WHERE ListingTitle LIKE '%youth%' 
	 OR ListingTitle LIKE '%shirt%' 
	 OR ListingTitle LIKE '%pendant%'  
	 OR ListingTitle LIKE '%CARDHOLDER%' 
	 OR ListingTitle LIKE '%sunglasses%'
	 OR ListingTitle LIKE '%lanyard%'
	 OR ListingTitle LIKE '%bag%'
	 OR ListingTitle LIKE '%tee%'
	 OR ListingTitle LIKE '%paracord%'
	)
ORDER BY DistanceFromAvg desc
