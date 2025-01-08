-- 1. Count the number of Movies vs TV Shows
SELECT 
	type,
	COUNT(*)
FROM 
	netflix
GROUP BY 1;

-- 2. Find the most common rating for movies and TV shows
WITH Ratings AS (
	SELECT 
	type,
	rating, 
	count(rating),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
	FROM 
	netflix
	GROUP BY 
	type, rating
	)	
	
SELECT 
	type,
	rating
FROM 
	Ratings
WHERE 
	ranking = 1;

-- 3. List all movies released in a specific year (e.g., 2020)

SELECT 
	* 
FROM 
	netflix
WHERE 
	release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix
WITH country_data AS (
    SELECT
	TRIM(SUBSTR(country, 1, INSTR(country, ',') - 1)) AS country
    FROM
	netflix
    WHERE
	country LIKE '%,%' 
    UNION ALL
    
    SELECT
	TRIM(country) AS country
    FROM
	netflix
    WHERE
	country NOT LIKE '%,%'
	AND country IS NOT NULL
	AND country <> ''
)
SELECT
    country,
    COUNT(*) AS content_count
FROM
    country_data
GROUP BY
    country
ORDER BY
    content_count DESC
LIMIT 5;

-- 5. Identify the longest movie
SELECT 
	types,
	MAX(duration) AS Longest_movie
FROM 
	netflix 
WHERE 
	types = 'Movie';

-- 6. Find content added in the last 5 years
SELECT 
	*
FROM 
	netflix
WHERE 
	date_added >= DATE('now', '-5 years');


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT 
	*
FROM 
	netflix  
WHERE 
	director LIKE '%Rajiv Chilaka%' COLLATE NOCASE;

-- 8. List all TV shows with more than 5 seasons
SELECT 
	* 
FROM
	netflix 
WHERE 
	types = 'TV Show'
	AND 
	duration > '5 Seasons';

-- 9. Count the number of content items in each genre
WITH each_genre AS (
	SELECT
	TRIM(SUBSTRING(listed_in, 1, INSTR(listed_in, ',') - 1)) AS genre
	FROM 
	netflix 
	WHERE 
	listed_in LIKE '%,%'
	UNION ALL
	SELECT 
	TRIM(listed_in) AS genre
	FROM
	netflix 
	WHERE 
	listed_in NOT LIKE '%,%'
	)

SELECT 
	genre,
	COUNT(*) AS count
FROM 
	each_genre
GROUP BY 
	genre
ORDER BY 
	count DESC;


-- 10. Calculate the average number of content releases per year in the dataset.
WITH YearlyReleaseCounts AS (
	SELECT
   	release_year,
	COUNT(*) AS num_releases
	FROM 
	netflix
    GROUP BY 
   	release_year
),
TotalYears AS (
    SELECT COUNT(DISTINCT release_year) AS total_years
    FROM netflix
)

SELECT 
	SUM(num_releases) / (SELECT total_years FROM TotalYears) AS avg_releases_per_year
FROM 
	YearlyReleaseCounts;

-- 11. List all movies that are documentaries
SELECT 
	*
FROM 
	netflix 
WHERE 
	types = 'Movie'AND listed_in LIKE '%Documentaries%' COLLATE NOCASE;

-- 12. Find all content without a director
SELECT 
	*
FROM 
	netflix
WHERE 
	director IS NULL OR director = '';

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT 
	* 
FROM 
	netflix
WHERE 
	casts LIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
WITH SplitActors AS (
    SELECT 
	TRIM(SUBSTR(casts, 1, INSTR(casts, ',') - 1)) AS actor
    FROM 
	netflix
    WHERE 
	casts LIKE '%,%'
    UNION ALL 
    SELECT 
	TRIM(casts) AS actor
    FROM 
	netflix 
    WHERE 
	casts NOT LIKE '%,%'
	AND 
	casts IS NOT NULL 
	AND
	casts <> ''
)

SELECT 
    actor,
    COUNT(*) AS total_appearances
FROM 
    SplitActors
WHERE 
    actor IS NOT NULL AND actor <> ''
GROUP BY 
    actor
ORDER BY 
    total_appearances DESC
LIMIT 5;

-- Question 15: Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other  content as 'Good'. Count how many items fall into each category.

WITH MoviesData AS (
   SELECT 
	*,
	CASE WHEN 
	description LIKE '%kill%' COLLATE NOCASE
	OR description LIKE '%violence%' COLLATE NOCASE
	THEN 'Bad'
	ELSE 
	'Good'
	END AS movie_category
    FROM 
	netflix
    )    
SELECT
    movie_category,
    COUNT(*) AS total_movies_in_category
FROM 
    MoviesData
GROUP BY 
    movie_category
-- End of reports