SELECT 
    *
FROM
    layoffs;

CREATE TABLE layoffs_staging LIKE layoffs;

SELECT 
    *
FROM
    layoffs_staging;

INSERT into layoffs_staging
select * from 
layoffs;

with cte_exe as
(
	select *,
    ROW_NUMBER() OVER(PARTITION BY 
    company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
    from layoffs_staging
)
select *
from cte_exe
where row_num > 1;


with delete_cte as
(
	select *,
    ROW_NUMBER() OVER(PARTITION BY 
    company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
    as row_num
    from layoffs_staging
)
delete
from delete_cte
where row_num > 1;

ALTER TABLE world_layoffs.layoffs_staging ADD row_num INT;

CREATE TABLE `layoffs_staging2` (
    `company` TEXT,
    `location` TEXT,
    `industry` TEXT,
    `total_laid_off` INT DEFAULT NULL,
    `percentage_laid_off` TEXT,
    `date` TEXT,
    `stage` TEXT,
    `country` TEXT,
    `funds_raised_millions` INT DEFAULT NULL,
    `row_num` INT DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

INSERT INTO `world_layoffs`.`layoffs_staging2`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging;
        
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    row_num > 1;

DELETE FROM layoffs_staging2 
WHERE
    row_num > 1;

-- Standardization of data

SELECT 
    company
FROM
    layoffs_staging2;

UPDATE layoffs_staging2 
SET 
    company = TRIM(company);

SELECT 
    *
FROM
    layoffs_staging2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;

DELETE FROM layoffs_staging2 
WHERE
    total_laid_off IS NULL
    AND percentage_laid_off IS NULL;

SELECT 
    *
FROM
    world_layoffs.layoffs_staging2
WHERE
    industry IS NULL OR industry = ''
ORDER BY industry;

UPDATE layoffs_staging2 
SET 
    industry = NULL
WHERE
    industry = '';

UPDATE layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    t1.industry IS NULL
        AND t2.industry IS NOT NULL;

SELECT 
    industry
FROM
    layoffs_staging2
WHERE
    industry LIKE 'Crypto_%';

UPDATE layoffs_staging2 
SET 
    industry = 'Crypto'
WHERE
    industry LIKE 'Crypto_%';

UPDATE layoffs_staging2 
SET 
    `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT DISTINCT
    country
FROM
    world_layoffs.layoffs_staging2
ORDER BY country;

UPDATE layoffs_staging2 
SET 
    country = TRIM(TRAILING '.' FROM country);

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;