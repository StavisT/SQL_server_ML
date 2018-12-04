USE NYCTaxi_Sample
GO

DROP PROCEDURE IF EXISTS [sp_prepare_dataset]
GO
create procedure [sp_prepare_dataset]
as
begin
declare @max_lon float = -72.986532
declare @min_lon float = -74.263242 
declare @max_lat float = 41.709555
declare @min_lat float = 40.573143

insert into nyc_features_prep
select * from nyc_features f
where f.fare_amount >0
and f.dropoff_latitude_n>@min_lat
and f.pickup_latitude_n>@min_lat
and f.dropoff_latitude_n<@max_lat
and f.pickup_latitude_n<@max_lat
and f.dropoff_longitude_n>@min_lon
and f.pickup_longitude_n>@min_lon
and f.dropoff_longitude_n<@max_lon
and f.pickup_longitude_n<@max_lon
end
