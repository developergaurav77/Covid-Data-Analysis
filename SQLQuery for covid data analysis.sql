
SELECT * FROM covid_data_analysis..covid_deaths$;

SELECT * FROM covid_data_analysis..covid_vacinations$;


-- Displaying most important data
SELECT location, date, population, new_cases, total_cases, total_deaths FROM covid_data_analysis..covid_deaths$
ORDER BY 1,2; 

-- Calculating death percentage
SELECT location, date, population,new_cases, total_cases, new_deaths, total_deaths  FROM covid_data_analysis..covid_deaths$
WHERE location = 'Nepal';

SELECT location, date, population,new_cases, total_cases, new_deaths, total_deaths, (total_deaths/total_cases) * 100 AS death_percentage, 
CASE WHEN new_cases = 0 THEN 0 ELSE (new_deaths/ new_cases)*100 END AS death_percentage_per_day
FROM covid_data_analysis..covid_deaths$
WHERE location = 'Nepal'
ORDER BY death_percentage DESC;

-- Identifying Highest number of cases in nepal
SELECT location,date, new_cases FROM covid_data_analysis..covid_deaths$
WHERE location = 'Nepal'
ORDER BY date ASC;

-- Identifying Highest number of cases in world
SELECT location, SUM(new_cases) FROM covid_data_analysis..covid_deaths$
GROUP BY location
ORDER BY SUM(new_cases) DESC;

-- How many percentage of total population are infected from corona virus.
SELECT location, date, population, total_cases, (total_cases/population) * 100 AS corona_infected_population_per
FROM covid_data_analysis..covid_deaths$
WHERE location = 'Nepal'
ORDER BY corona_infected_population_per DESC;

-- How many percentage of total population lost their life from corona virus.
SELECT location, date, population, total_cases,total_deaths, (total_deaths/population) * 100 AS corona_infected_death_per
FROM covid_data_analysis..covid_deaths$
WHERE location = 'Nepal'
ORDER BY corona_infected_death_per DESC;


SELECT * FROM covid_data_analysis..covid_deaths$;

--Showing countries with highest percentage of death per population
SELECT location, population, MAX((total_deaths/population) * 100 )AS corona_death_population_per
FROM covid_data_analysis..covid_deaths$
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY corona_death_population_per DESC;

--Showing countries with highest count of death
SELECT location, population, MAX(CAST(total_deaths AS INT))  AS corona_deaths, (MAX(CAST(total_deaths AS INT)) /population)*100 AS death_population_per
FROM covid_data_analysis..covid_deaths$
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY corona_deaths DESC;



SELECT * FROM covid_data_analysis..covid_deaths$;


-- total cases_per_day and total deaths worldwide_per_Day
SELECT date, SUM(new_cases) AS total_cases_worldwide_perday, SUM(CAST(new_deaths AS INT)) AS total_deaths_worldwide_perday
FROM covid_data_analysis..covid_deaths$
GROUP BY date
ORDER BY date;


-- total cases and total deaths worldwide(Visualization)
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid_data_analysis..covid_deaths$
where continent is not null 
--Group By date

--Showing contenents with highest death count(Visualization)
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From covid_data_analysis..covid_deaths$
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International','Upper middle income','High income','Lower middle income','Low income')
Group by location
order by TotalDeathCount desc

-- How many percentage of total population are infected from corona virus worldwide(Visualization)
SELECT location, population AS total_population, Max(total_cases) as infected_population, MAX((total_cases/population) * 100 )AS percentage_population_infected
FROM covid_data_analysis..covid_deaths$
GROUP BY location, population
ORDER BY percentage_population_infected DESC;

-- How many percentage of total population are infected from corona virus worldwide, with date
SELECT location, population AS total_population,date, Max(total_cases) as infected_population, MAX((total_cases/population) * 100 )AS percentage_population_infected
FROM covid_data_analysis..covid_deaths$
GROUP BY location, population, date
ORDER BY percentage_population_infected DESC;

SELECT * FROM covid_data_analysis..covid_vacinations$;

--joining two tables

SELECT dea.location, dea.date, dea.population, vac.new_vaccinations,vac.total_vaccinations FROM covid_data_analysis..covid_deaths$ dea
JOIN covid_data_analysis..covid_vacinations$ vac
ON dea.location = vac.location
AND dea.date = vac.date

WHERE vac.continent IS NOT NULL
ORDER BY dea.location, total_vaccinations,new_vaccinations,vac.date

--total vacination percentage per popualtion
SELECT dea.location, MAX(dea.date), MAX(dea.population) AS population, MAX(vac.total_vaccinations) AS total_vaccination,
(MAX(vac.total_vaccinations)/MAX(dea.population))*50 AS vaccination_per
FROM covid_data_analysis..covid_deaths$ dea
JOIN covid_data_analysis..covid_vacinations$ vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE vac.continent IS NOT NULL
GROUP BY dea.location
ORDER BY vaccination_per DESC

--total vacination percentage per popualtion of Nepal
SELECT dea.location, MAX(dea.date), MAX(dea.population) AS population, MAX(vac.total_vaccinations) AS total_vaccination,
(MAX(vac.total_vaccinations)/MAX(dea.population))*50 AS vaccination_per
FROM covid_data_analysis..covid_deaths$ dea
JOIN covid_data_analysis..covid_vacinations$ vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE vac.continent IS NOT NULL AND vac.location = 'Nepal'
GROUP BY dea.location
ORDER BY vaccination_per DESC
