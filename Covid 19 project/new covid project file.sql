select * from covid_deaths;

# loading the data that we are going to analysis
select Location, date_, total_cases, total_deaths, population
from covid_deaths
order by 1,2;


#Looking at total cases vs Total Deaths
select Location, date_, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from covid_deaths
where location like '%India%'
order by 1,2 desc;
#As of now, Date - 15th June 2021, India has a Death percentage of about 1.2809%

#Looking at total Cases vs Population
select Location, date_, total_cases, population, (total_cases/population)*100 as PercentOfPopulationAffected
from covid_deaths
where location like '%India%'
order by 1,2 desc;
#As we can see around 2.1473 percentage of Indian have already been tested positive.


#Looking at countries with highest infection rate compared to Population
select Location, max(total_cases) as HighestInfectionCount, population, Max((total_cases/population))*100 as PercentOfPopulationAffected
from covid_deaths
#where location like '%India%'
group by Location, population
order by PercentOfPopulationAffected desc;



select continent from covid_deaths;

update covid_deaths set continent=if(continent='',NULL,continent);

#Showing Countries with Highest Death Count per Population
select Location, max(total_deaths) as totalDeathCount, population
from covid_deaths
-- where location like '%India%'
where continent is not null 
group by Location
order by totalDeathCount desc;
#maximum Death Count is found in United States followed by Brazil and than India.



-- Lets break things out by continent 
select location, max(total_deaths) as totalDeathCount, population
from covid_deaths
-- where location like '%India%'
where continent is null 
group by location
order by totalDeathCount desc;



-- GLOBAL NUMBERS

select Location, date_, total_cases, population, (total_cases/population)*100 as PercentOfPopulationAffected
from covid_deaths
-- where location like '%India%'
where continent is not null
order by PercentOfPopulationAffected desc; 



#Checking sum of new cases in india according to the date
select Location, date_, sum(new_cases)-- , population, (total_cases/population)*100 as PercentOfPopulationAffected
from covid_deaths
where location like '%India%'
and continent is not null
group by date_
order by 2 desc; 
#we can see that the cases in India has been decreasing day by day.
#but as we can on 15th june there was incrase in cases by 2000 comapred to the previous day.
#Does it mean the 3rd way has already started in India.



select Location, date_, sum(new_cases) as totalCases, sum(new_deaths) as totalDeaths, sum(new_cases)/sum(new_deaths)*100 as deathPercentage-- , population, (total_cases/population)*100 as PercentOfPopulationAffected
from covid_deaths
where location like '%India%'
and continent is not null
group by date_
order by 2 desc; 
#As we can see on 10th June There was seen a serge in covid deaths.
#around 7374 new deaths we reported






