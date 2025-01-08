# Netflix_Movies_and_TV-Shows_Analysis

## Project overview

This project showcases key SQL skills for exploring, cleaning, and analyzing Netflix's movies and TV shows data.The project seeks to derive insights, address business inquiries, and classify content based on factors like distribution, ratings, release years, countries, and durations.The project explores the practical use of SQL to address business-related queries and reveal insights.

---
## Objectives
- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Data source

Netflix movies and tv show data: The primary dataset used for this analysis is the "netflix_titles.csv", containing detailed information about netflix movies and tv shows.

## Tools

- SQL Server - used for data analyses

## Project structure.
### Data Cleaning

- Checked for null or missing values across all columns using SQL queries.
- Removed rows containing null values to maintain data integrity.

### Exploratory Data Analysis

EDA involved exploring the Netflix data to answer key questions, such as:
- What are the top 5 countries with the most extensive content libraries available on Netflix?
- Which movie has the longest duration?
- What content was added to Netflix in the past 3 years?
- Which movies and TV shows were directed by a specific director,in this case Martin Scorsese?
- Which TV shows has over 4 seasons added on Netflix?
- How much content does Netflix release on average per year?
- Determine the top 5 actors who have appeared in the most movies in the dataset.
- Categorize the content based on the presence of the keywords 'detective' and 'investigation' in the description field.

#### Sample queries
```
SELECT *
FROM netflix 
WHERE types  = 'Movie'  AND release_year = 2021
```

## Insights and Conclusion

- Content Distribution: The dataset includes a wide variety of movies and TV shows with different ratings and genres.
- Common Ratings: Understanding the most common ratings offers insights into the content's target audience.
- Geographical Insights: The leading countries and the average content releases from India emphasize the distribution of regional content
- Content Categorization: Classifying content using specific keywords aids in comprehending the nature of content available on Netflix.


