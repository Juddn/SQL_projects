--for tableau
select* from divvy

--members vs casuals
select member_casual, count(member_casual) as count
from divvy
group by member_casual

--members vs casuals over time
select member_casual, count(member_casual) as memCount, datename(MONTH,started_at)
from divvy
group by member_casual, datename(month,started_at)


select member_casual, count(member_casual) as memCount, datename(DAY,started_at)
from divvy
group by member_casual, datename(,started_at)



--MvC by dayofweek
select top(100) DATENAME(WEEKDAY,started_at) as date, count(1) as cnt, member_casual
from divvy
group by DATENAME(WEEKDAY,started_at), member_casual

--type of bike
select rideable_type, count(rideable_type) as Count, member_casual
from divvy
group by rideable_type, member_casual

--???
select *
from divvy
where rideable_type like 'docked_bike' and member_casual like 'member'

----common starts
--select start_station_name, count(start_station_name) as count
--from divvy
--where start_station_name is not null
--group by start_station_name
--order by count desc

----common ends
--select end_station_name, count(end_station_name) as count
--from divvy
--where end_station_name is not null
--group by end_station_name
--order by count desc

--common routes
select top(50) start_station_name + ' to ' + end_station_name as Route, member_casual, count(member_casual) as count
from divvy
group by member_casual, start_station_name, end_station_name
order by count desc

select top(50) start_station_name + ' to ' + end_station_name as memRoute, count(member_casual) as count
from divvy
where member_casual like 'member'
group by member_casual, start_station_name, end_station_name
order by count desc

select top(50) start_station_name + 'to ' + end_station_name as casRoute, count(member_casual) as count
from divvy
where member_casual like 'casual'
group by member_casual, start_station_name, end_station_name
order by count desc

-- break into duration groups

select member_casual, ended_at-started_at as duration
from divvy
where ended_at-started_at < '1900-01-02 00:00:00.000'
order by duration desc


select member_casual, DATEDIFF(hour,started_at,ended_at) as duration, count(*) as cnt
from divvy
where DATEDIFF(hour,started_at,ended_at) < 25
group by member_casual, DATEDIFF(hour,started_at,ended_at)
order by member_casual, duration desc

-- breaking datetime to time
with cte as
(
select member_casual, (ended_at-started_at) as TotDuration
from divvy
where ended_at-started_at < '1900-01-02 00:00:00.000'

)

select member_casual, cast(TotDuration as time) as duration
from cte
order by TotDuration desc

with cte as
(
select member_casual, (ended_at-started_at) as TotDuration
from divvy
-- where ended_at-started_at < '1900-01-02 00:00:00.000'

)

select member_casual, left(cast(TotDuration as time),2) as hours, count(*) as cnt
from cte
group by member_casual, left(cast(TotDuration as time),2)
order by hours desc