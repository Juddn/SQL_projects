--duration of trip
select top(100) ended_at - started_at as duration
from divvy
order by duration desc

--INSPECTING DATA
select *
from divvy

select distinct start_station_name, start_station_id
from divvy
where start_station_name is not null
order by start_station_name

select distinct start_station_name, start_station_id
from divvy
where start_station_id is not null
order by start_station_id


--using existing id and name to fill nulls for start
select d1.start_station_name, d1.start_station_id, d2.start_station_name, d2.start_station_id, ISNULL(d1.start_station_id, d2.start_station_id) as replacement_id
from divvy d1
join divvy d2
	on d1.start_station_name = d2.start_station_name
where 
	d1.start_station_id is null and d2.start_station_id is not null

update d1
set start_station_id = ISNULL(d1.start_station_id, d2.start_station_id)-- as replacement_id
from divvy d1
join divvy d2
	on d1.start_station_name = d2.start_station_name
where 
	d1.start_station_id is null and d2.start_station_id is not null


select d1.start_station_name, d1.start_station_id, d2.start_station_name, d2.start_station_id, ISNULL(d1.start_station_name, d2.start_station_name) as replacement_name
from divvy d1
join divvy d2
	on d1.start_station_id = d2.start_station_id
where 
	d1.start_station_name is null and d2.start_station_name is not null

update d1
set d1.start_station_id=ISNULL(d1.start_station_name, d2.start_station_name)-- as replacement_name
from divvy d1
join divvy d2
	on d1.start_station_id = d2.start_station_id
where 
	d1.start_station_name is null and d2.start_station_name is not null

--using existing id and name to fill nulls for end
select d1.end_station_name, d1.end_station_id, d2.end_station_name, d2.end_station_id, ISNULL(d1.end_station_id, d2.end_station_id) as replacement_id
from divvy d1
join divvy d2
	on d1.end_station_name = d2.end_station_name
where 
	d1.end_station_id is null and d2.end_station_id is not null

update d1
set d1.end_station_id = isnull(d1.end_station_id, d2.end_station_id)-- as replacement_id
from divvy d1
join divvy d2
	on d1.end_station_name = d2.end_station_name
where 
	d1.end_station_id is null and d2.end_station_id is not null


--removing duplicates duplicates
select ride_id, count(1) as count
from divvy
group by ride_id
having count(1) > 1

delete
from divvy
where ride_id in
	(
	select ride_id
	from divvy
	group by ride_id
	having COUNT(ride_id) >1
	)


--removing rows where start_time is after end_time 'negative duration'
select ride_id, started_at-ended_at as errDuration
from divvy
where (started_at-ended_at)>0

delete
from divvy
where ride_id in
	(
	select ride_id
	from divvy
	where (started_at-ended_at) > 0
	)

--missing end name,id,lat, and lng; cant recover
select *
from divvy
where end_station_name is null and end_station_id is null and end_lat is null and end_lng is null

delete from divvy
where end_station_name is null and end_station_id is null and end_lat is null and end_lng is null

--select *
--from divvy
--where start_station_name is null and start_station_id is null and start_lat is null and start_lng is null

select *
from divvy
where start_station_name is null and end_station_name is null

delete from divvy
where start_station_name is null and end_station_name is null


--delete existing nulls
select *
from divvy
where start_station_name is null or end_station_name is null

delete
from divvy
where start_station_name is null or end_station_name is null