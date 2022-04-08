-- SQL Skills demonstrated in this script include: Joins, Common Table Expressions (CTE), Aggregation, Type Conversion, Temp Tables

-- The purpose of this script is to explore COVID-19 data, particularly surrounding death counts and vaccination statistics.
-- The data used in this project was sourced from https://ourworldindata.org/covid-deaths
-- Records in this dataset were current and pulled on March 5, 2022


--Selecting the fields/columns that are applicable to deaths
SELECT location, continent, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1, 2;


-- Comparing total cases vs total deaths
-- DeathPercentage represents probability of dying if tested positive (per country)
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS "Death Percentage"
FROM CovidDeaths
ORDER BY 1, 2;


-- Comparing total cases vs population
-- Shows what percentage of the population contracted COVID-19
SELECT location, date, total_cases, population, (total_cases/population)*100 AS "Positive Percentage"
FROM CovidDeaths
ORDER BY 1 , 2;


-- Showing highest covid case count and percentage of population infected per country
SELECT location, MAX(total_cases) AS "Infection High", MAX((total_cases/population))*100 AS "Percentage High"
FROM CovidDeaths
GROUP BY location, population
ORDER BY [Percentage High] DESC;


-- Showing countries with highest death count vs population
-- Casting total deaths to fix type inconsistency
SELECT location, MAX(CAST(total_deaths AS INT)) AS "Total Deaths"
FROM CovidDeaths
--WHERE statement needed to filter results
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY [Total Deaths] DESC;


-- Querying the COVID-19 statistics for the United States
SELECT location, MAX(total_cases) AS "Total Cases", MAX(CAST(total_deaths AS INT)) AS "Total Deaths",
				MAX(CAST(total_deaths AS INT))/MAX(total_cases)*100 AS "Death Percentage",
				MAX((total_cases/population))*100 AS "Percentage High", MAX(population) AS "Population"
FROM CovidDeaths
WHERE location LIKE '%states'
GROUP BY location;


-- Showing the breakdown of COVID-19 statistics by continent
SELECT location, MAX(CAST(total_deaths AS INT)) AS "Total Deaths"
FROM CovidDeaths
--Filtering for the income statistics
WHERE continent IS NULL 
		AND location NOT LIKE '%income'
GROUP BY location
ORDER BY "Total Deaths" DESC;


-- The previous query output two unexpected results 'European Union' and 'International'
-- Performing isolated queries on these results to explore them further.
SELECT *
FROM CovidDeaths
WHERE location = 'International'
		OR location = 'European Union'
ORDER BY location;


-- Global statistics on COVID-19 cases, deaths, and percentage of deaths per case/mortality rate
SELECT SUM(new_cases) AS "Global Cases", SUM(CAST(new_deaths AS INT)) AS "Global Deaths", SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS "Death Percentage"
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;


-- Looking at total population vs vaccinations with a rolling count of new vaccinations
SELECT death.location, death.date, death.population, vacc.new_vaccinations,
		SUM(CONVERT(BIGINT, vacc.new_vaccinations)) OVER (PARTITION BY death.location ORDER BY
		death.date ROWS UNBOUNDED PRECEDING) AS "Rolling Vaccines"
FROM CovidDeaths death
JOIN CovidVaccinations vacc
ON death.location = vacc.location
	AND death.date = vacc.date
WHERE death.continent IS NOT NULL
	AND vacc.new_vaccinations IS NOT NULL
ORDER BY 1, 2;


-- Using CTE to reference the Rolling Vaccine column and calculating the percentage
-- of vaccinated individuals in a country's population
WITH "Population Vaccinated" (location, date, population, new_vaccinations, "Rolling Vaccines")
AS
(
SELECT death.location, death.date, death.population, vacc.new_vaccinations,
		SUM(CONVERT(BIGINT, vacc.new_vaccinations)) OVER (PARTITION BY death.location ORDER BY
		death.date ROWS UNBOUNDED PRECEDING) AS "Rolling Vaccines"
FROM CovidDeaths death
JOIN CovidVaccinations vacc
ON death.location = vacc.location
		AND death.date = vacc.date
WHERE death.continent IS NOT NULL
		AND vacc.new_vaccinations IS NOT NULL
)

SELECT *, ("Rolling Vaccines"/population)*100 AS "Rolling Percent Vaccinated"
FROM "Population Vaccinated";


-- Creating a Temp table to reference the Rolling Vaccine column and to calculate the
-- percentage of vaccinations vs population
-- This query accomplishes the same tasks as the previous one but demonstrates
-- use of a temp table instead
DROP TABLE IF EXISTS PercentPopulationVaccinated
CREATE TABLE PercentPopulationVaccinated
(
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingVaccines numeric
)

INSERT INTO PercentPopulationVaccinated
SELECT death.location, death.date, death.population, vacc.new_vaccinations,
		SUM(CONVERT(BIGINT, vacc.new_vaccinations)) OVER (PARTITION BY death.location ORDER BY
		death.date ROWS UNBOUNDED PRECEDING) AS "RollingVaccines"
FROM CovidDeaths death
JOIN CovidVaccinations vacc
ON death.location = vacc.location
		AND death.date = vacc.date
WHERE death.continent IS NOT NULL
		AND vacc.new_vaccinations IS NOT NULL

SELECT *, ("RollingVaccines"/population)*100 AS "Percent Vaccinated"
FROM PercentPopulationVaccinated;


-- Inspection of outputs shows that some countries had over 100% of the population vaccinated.
-- The likely reason for this is that the new_vaccinations data does not distinguish between first or second
-- vaccine doses, resulting in a single member receiving more than 1 vaccine.
SELECT *, (RollingVaccines/population)*100 AS "Percent Vaccinated"
FROM PercentPopulationVaccinated
WHERE (RollingVaccines/population)*100 > 100;


-- We can use the people_fully_vaccinated variable to gain more granularity
-- and compare fully vaccinated individuals vs population
SELECT death.location, MAX(death.population) AS population, MAX(CAST(vacc.people_fully_vaccinated AS BIGINT)) AS "Fully Vaccinated",
		MAX((vacc.people_fully_vaccinated/death.population))*100 AS "Percent Fully Vaccinated"
FROM CovidDeaths death
JOIN CovidVaccinations vacc
ON death.location = vacc.location
		AND death.date = vacc.date
WHERE death.continent IS NOT NULL
GROUP BY death.location
ORDER BY location;


-- Creating a view for visualization in Tableau
CREATE VIEW PercentFullyVaccinated 
AS
SELECT death.location, MAX(death.population) AS population, MAX(CAST(vacc.people_fully_vaccinated AS BIGINT)) AS "Fully Vaccinated",
		MAX((vacc.people_fully_vaccinated/death.population))*100 AS "Percent Fully Vaccinated"
FROM CovidDeaths death
JOIN CovidVaccinations vacc
ON death.location = vacc.location
		AND death.date = vacc.date
WHERE death.continent IS NOT NULL
GROUP BY death.location;


