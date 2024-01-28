
SELECT * 
FROM indianfood
WHERE Servings >= 4;
SELECT Course, COUNT(*) AS RecipeCount 
FROM IndianRecipe 
GROUP BY Course;
SELECT * FROM indianfood 
WHERE Cuisine LIKE '%Andhra%';
SELECT * FROM indianfood 
ORDER BY TotalTimeInMins DESC LIMIT 10;
SELECT DISTINCT Cuisine 
FROM indianfood; 
SELECT AVG(PrepTimeInMins) AS AvgPrepTime, MAX(PrepTimeInMins) AS MaxPrepTime 
FROM indianfood;
SELECT * FROM IndianRecipe 
WHERE Cuisine = 'North Indian';
SELECT * FROM IndianRecipe 
WHERE Course = 'Main Course';
SELECT * FROM IndianRecipe 
WHERE Diet = 'Vegetarian';
SELECT * FROM indianfood 
WHERE TotalTimeInMins > (SELECT AVG(TotalTimeInMins) 
FROM indianfood);
SELECT TranslatedRecipeName, TotalTimeInMins, RANK() OVER (ORDER BY TotalTimeInMins) AS RecipeRank 
FROM indianfood;
SELECT TranslatedRecipeName, CookTimeInMins, 
       AVG(CookTimeInMins) OVER (ORDER BY Srno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvgCookTime
FROM indianfood;
WITH RankedRecipes AS (
   SELECT *, RANK() OVER (PARTITION BY Cuisine ORDER BY CookTimeInMins DESC) AS CookTimeRank
   FROM indianfood
)
SELECT * FROM RankedRecipes WHERE CookTimeRank = 1;
SELECT Diet, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM indianfood) AS PercentageVegetarian FROM indianfood GROUP BY Diet;
SELECT TranslatedRecipeName, TotalTimeInMins, RANK() OVER (ORDER BY TotalTimeInMins) AS RecipeRank FROM indianfood;
UPDATE indianfood
SET Diet = 'Non-Vegetarian'
WHERE Cuisine = 'MeatCuisine';
UPDATE indianfood
SET Diet = 'Vegetarian'
WHERE PrepTimeInMins < 30;
UPDATE indianfood
SET CookTimeInMins = CookTimeInMins + 5;




