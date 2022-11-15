--convert csv files into xlsx for mssql, import using import tool
--error with importing data, starting_station_id and ending_station_id where either float or nvarchar so it wouldnt union properly

create table divvy
(
	ride_id nvarchar(255)
	,rideable_type nvarchar(255)
	,started_at datetime
	,ended_at datetime
	,start_station_name nvarchar(255)
	,start_station_id nvarchar(255)
	,end_station_name nvarchar(255)
	,end_station_id nvarchar(255)
	,start_lat float
	,start_lng float
	,end_lat float
	,end_lng float
	,member_casual nvarchar(255)
)

insert into divvy
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202101-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202102-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202103-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202104-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202105-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202106-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202107-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202108-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202109-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202110-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202111-divvy-tripdata$']
union
select [ride_id],[rideable_type],[started_at],[ended_at],[start_station_name],CONVERT(nvarchar,[start_station_id]),[end_station_name],CONVERT(nvarchar,[end_station_id]),[start_lat],[start_lng],[end_lat],[end_lng],[member_casual]
from [Cyclistic]..['202112-divvy-tripdata$']

