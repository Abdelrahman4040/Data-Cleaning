# Data-Cleaning
SQL Data Cleaning Project - Layoffs Dataset This project demonstrates the process of data cleaning and preprocessing on a layoffs dataset sourced from Kaggle. The goal of this project is to clean the dataset and make it ready for analysis by handling issues such as duplicates, null values, inconsistencies, and irrelevant data.

Key Steps: Data Duplication Removal:

Duplicates were identified using ROW_NUMBER() and eliminated to ensure data integrity. Data Standardization:

Standardized categorical values, such as correcting variations in industry names (e.g., "Crypto Currency" to "Crypto") and normalizing country names (e.g., removing trailing periods). Reformatted date columns to a consistent format using STR_TO_DATE(). Handling Null Values:

Replaced empty strings with NULL for consistency. Populated missing industry values by joining rows with the same company name. Data Pruning:

Deleted unnecessary rows where key fields like total_laid_off and percentage_laid_off were null. Removed redundant columns after data cleaning. Outcome: The result is a clean, standardized dataset that is ready for exploratory data analysis (EDA), enabling further insights into the layoffs trends and patterns.
