CREATE TABLE covid_deaths (
    
    iso_code VARCHAR(255) ,
    continent VARCHAR(255) ,
    location VARCHAR(255) ,
    date_ DATE not NULL,
    population int,
    total_cases int, 
    new_cases int, 
    new_cases_smoothed int,
    total_deaths int, 
    new_deaths int, 
    new_deaths_smoothed int, 
    total_cases_per_million int, 
    new_cases_per_million int,
    new_cases_smoothed_per_million int, 
    total_deaths_per_million int, 
    new_deaths_per_million int, 
    new_deaths_smoothed_per_million int,
    reproduction_rate int,
    icu_patients int,
    icu_patients_per_million int,
    hosp_patients int,
    hosp_patients_per_million int,
    weekly_icu_admissions int,
    weekly_icu_admissions_per_million int,
    weekly_hosp_admissions int,
    weekly_hosp_admissions_per_million int
);

SET GLOBAL local_infile=1;


LOAD DATA local INFILE 'E:/Covid 19 project/covid_deaths.csv' 
INTO TABLE covid_deaths 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



select * from covid_deaths;



CREATE TABLE covid_vaccination (
    
    
    new_tests int,
    total_tests int, 
    total_tests_per_thousand int, 
    new_tests_per_thousand int,
    new_tests_smoothed int, 
    new_tests_smoothed_per_thousand int, 
    tests_per_case int, 
    tests_units varchar(225), 
    total_vaccinations int,
    people_vaccinated int, 
    people_fully_vaccinated int, 
    new_vaccinations int, 
    new_vaccinations_smoothed int,
    total_vaccinations_per_hundred int,
    people_vaccinated_per_hundred int,
    people_fully_vaccinated_per_hundred int,
    new_vaccinations_smoothed_per_million int,
    stringency_index int,
    population_density int,
    median_age int,
    aged_65_older int,
    aged_70_older int,
    gdp_per_capita int,
    extreme_poverty int,
    cardiovasc_death_rate int,
    diabetes_prevalence int,
    female_smokers int,
    male_smokers int,
    handwashing_facilities int,
    hospital_beds_per_thousand int,
    life_expectancy int,
    human_development_index int,
    excess_mortality int
);

LOAD DATA local INFILE 'E:/Covid 19 project/covid_vaccination.csv' 
INTO TABLE covid_vaccination 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select * from covid_vaccination;
select * from covid_deaths;
