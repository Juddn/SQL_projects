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
