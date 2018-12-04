USE NYCTaxi_Sample
GO

DECLARE @query_string nvarchar(max) -- Specify input query
  SET @query_string='
  SELECT TOP (10000) 
       fare_amount
	   ,passenger_count
      ,pickup_longitude_n
      ,pickup_latitude_n
      ,dropoff_longitude_n
      ,dropoff_latitude_n
      ,pickup_month
      ,pickup_day
      ,pickup_hour
      ,is_weekend
      ,distance
      ,pickup_distance_jfk
      ,dropoff_distance_jfk
      ,pickup_distance_ewr
      ,dropoff_distance_ewr
      ,pickup_distance_lgr
      ,dropoff_distance_lgr
      ,is_airport
  FROM NYCTaxi_Sample.dbo.nyc_features_test
   where pickup_month=4'

exec [dbo].[sp_predict_fare] 'SK_gradientboostregressor_2', @query_string

exec [dbo].[sp_predict_fare] 'SK_adaboostregressor', @query_string

