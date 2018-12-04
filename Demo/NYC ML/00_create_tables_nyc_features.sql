USE [NYCTaxi_Sample]
GO

DROP TABLE IF EXISTS [dbo].[nyc_features]
GO

CREATE TABLE [dbo].[nyc_features](
	[fare_amount] [float] NULL,
	medallion varchar(50) not null,
	hack_license varchar(50) not null,
	[passenger_count] [int] NULL,
	[pickup_longitude_n] [float] NULL,
	[pickup_latitude_n] [float] NULL,
	[dropoff_longitude_n] [float] NULL,
	[dropoff_latitude_n] [float] NULL,
	[pickup_month] [int] NULL,
	[pickup_day] [int] NULL,
	[pickup_hour] [int] NULL,
	[is_weekend] [int] NULL,
	[distance] [float] NULL,
	[pickup_distance_jfk] [float] NULL,
	[dropoff_distance_jfk] [float] NULL,
	[pickup_distance_ewr] [float] NULL,
	[dropoff_distance_ewr] [float] NULL,
	[pickup_distance_lgr] [float] NULL,
	[dropoff_distance_lgr] [float] NULL,
	[is_airport] [int] NULL
) ON [PRIMARY] 
GO


DROP TABLE IF EXISTS [dbo].[nyc_features_prep]
GO

CREATE TABLE [dbo].[nyc_features_prep](
	[fare_amount] [float] NULL,
	medallion varchar(50) not null,
	hack_license varchar(50) not null,
	[passenger_count] [int] NULL,
	[pickup_longitude_n] [float] NULL,
	[pickup_latitude_n] [float] NULL,
	[dropoff_longitude_n] [float] NULL,
	[dropoff_latitude_n] [float] NULL,
	[pickup_month] [int] NULL,
	[pickup_day] [int] NULL,
	[pickup_hour] [int] NULL,
	[is_weekend] [int] NULL,
	[distance] [float] NULL,
	[pickup_distance_jfk] [float] NULL,
	[dropoff_distance_jfk] [float] NULL,
	[pickup_distance_ewr] [float] NULL,
	[dropoff_distance_ewr] [float] NULL,
	[pickup_distance_lgr] [float] NULL,
	[dropoff_distance_lgr] [float] NULL,
	[is_airport] [int] NULL
) ON [PRIMARY] 
GO


DROP TABLE IF EXISTS [dbo].[nyc_features_train]
GO

CREATE TABLE [dbo].[nyc_features_train](
	[fare_amount] [float] NULL,
	medallion varchar(50) not null,
	hack_license varchar(50) not null,
	[passenger_count] [int] NULL,
	[pickup_longitude_n] [float] NULL,
	[pickup_latitude_n] [float] NULL,
	[dropoff_longitude_n] [float] NULL,
	[dropoff_latitude_n] [float] NULL,
	[pickup_month] [int] NULL,
	[pickup_day] [int] NULL,
	[pickup_hour] [int] NULL,
	[is_weekend] [int] NULL,
	[distance] [float] NULL,
	[pickup_distance_jfk] [float] NULL,
	[dropoff_distance_jfk] [float] NULL,
	[pickup_distance_ewr] [float] NULL,
	[dropoff_distance_ewr] [float] NULL,
	[pickup_distance_lgr] [float] NULL,
	[dropoff_distance_lgr] [float] NULL,
	[is_airport] [int] NULL
) ON [PRIMARY] 
GO


DROP TABLE IF EXISTS [dbo].[nyc_features_test]
GO

CREATE TABLE [dbo].[nyc_features_test](
	[fare_amount] [float] NULL,
	medallion varchar(50) not null,
	hack_license varchar(50) not null,
	[passenger_count] [int] NULL,
	[pickup_longitude_n] [float] NULL,
	[pickup_latitude_n] [float] NULL,
	[dropoff_longitude_n] [float] NULL,
	[dropoff_latitude_n] [float] NULL,
	[pickup_month] [int] NULL,
	[pickup_day] [int] NULL,
	[pickup_hour] [int] NULL,
	[is_weekend] [int] NULL,
	[distance] [float] NULL,
	[pickup_distance_jfk] [float] NULL,
	[dropoff_distance_jfk] [float] NULL,
	[pickup_distance_ewr] [float] NULL,
	[dropoff_distance_ewr] [float] NULL,
	[pickup_distance_lgr] [float] NULL,
	[dropoff_distance_lgr] [float] NULL,
	[is_airport] [int] NULL
 ) ON [PRIMARY] 
GO






