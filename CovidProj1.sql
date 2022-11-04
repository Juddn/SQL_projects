select * 
from PortfolioProject..CovidDeaths
order by 3,4

--select * 
--from PortfolioProject..CovidVaccinations
--order by 3,4

Select Location,date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

--total cases vs total deaths
Select Location,date, total_cases, new_cases, total_deaths, population, (total_deaths / total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2

--total cases vs population
Select Location,date, total_cases, population, (total_cases/population)*100 as CasesPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2

--looking at countries with highest infection rate to population
Select Location, max(total_cases) as HighestInfectionCount, population, max((total_cases/population)*100) as CasesPercentage
from PortfolioProject..CovidDeaths
--where location like '%states%'
group by location,population
order by CasesPercentage desc

--show countries with highest death count per population
Select location, MAX(cast(Total_deaths as bigint)) as TotDeathCnt
from PortfolioProject..CovidDeaths
group by location
order by TotDeathCnt desc

--show by continent
Select location, MAX(cast(Total_deaths as bigint)) as TotDeathCnt
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by TotDeathCnt desc

--global numbers
select sum(new_cases) as totCases, sum(cast(new_deaths as bigint)) as totDeaths,
	(sum(cast(new_deaths as bigint))/sum(new_cases))*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by 1,2

--total pop vs vac
select dea.location, vac.location, dea.population, vac.new_vaccinations, dea.date
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date =vac.date
order by 2,5

--global numbers
select SUM(new_cases) as totCases, SUM(cast(new_deaths as int)) as totDeaths
	,SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as deathPercentage
from PortfolioProject..CovidDeaths