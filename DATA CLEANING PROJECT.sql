-- Preparing data for analysis
-- 1-Identiying duplicates 
WITH dup AS (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
        `date`, stage, country, funds_raised_millions) AS ROW_NUM
    FROM layoffs
 )
SELECT *
FROM dup
WHERE ROW_NUM > 1;

    -- Creating a dublicate table with row_num column
CREATE TABLE layoffs_cpy
like layoffs;

ALTER TABLE layoffs_cpy
ADD COLUMN row_num INT;

INSERT INTO layoffs_cpy
SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
        `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs;

    -- Cleaning Dublicates
DELETE
FROM layoffs_cpy
WHERE row_num > 1;

-- 2- Standardizing Data
    -- Cleaning whitespaces and dots
UPDATE layoffs_cpy
SET company = TRIM(company),
    location = TRIM(TRAILING '.' FROM location),
    industry = TRIM(industry),
    country = TRIM(TRAILING '.' FROM country);
    
    -- Unifing
UPDATE layoffs_cpy
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_cpy
SET industry = NULL
WHERE industry = '' ;

    -- Changing date from text to date type
UPDATE layoffs_cpy
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_cpy
MODIFY COLUMN `date` DATE;

-- 3-Null Values
    -- Copying from other rows
UPDATE layoffs_cpy AS l1
JOIN layoffs_cpy AS l2
SET l1.industry = l2.industry
WHERE l1.industry IS NULL
    AND l2.industry IS NOT NULL
    AND l1.company = l2.company
    AND l1.location = l2.location;

    -- Removing unnecessary rows
DELETE
FROM layoffs_cpy
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- 4- Removing extra columns
ALTER TABLE layoffs_cpy
DROP COLUMN row_num;

SELECT * 
FROM layoffs_cpy;
