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

--CTE
with PopvsVac (contitnent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.location, dea.location, dea.date, dea.population, vac.new_vaccinations
	,SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
		as RollingPeopleVaccinated
	-- ,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date =vac.date
where dea.continent is not null
--order by 2,3
)
select *,(RollingPeopleVaccinated/Population)*100
from PopvsVac

--temp table
drop table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(continent nvarchar(255)
,location nvarchar(255)
,date datetime
,population numeric
,new_vaccines numeric
,RollingPeopleVaccinated numeric)

insert into #PercentPopulationVaccinated
select dea.location, dea.location, dea.date, dea.population, vac.new_vaccinations
	,SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
		as RollingPeopleVaccinated
	-- ,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date =vac.date
where dea.continent is not null
--order by 2,3

select *,(RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


--creating view to store data for vizualization
CREATE VIEW PercentPopulationVaccinated as
select dea.location, dea.location, dea.date, dea.population, vac.new_vaccinations
	,SUM(convert(bigint,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
		as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
