USE NYCTaxi_Sample
GO
--Select statement as input
declare @inp nvarchar(max)
set @inp=N'select cast(fare_amount as float) as fare_amount 
      ,passenger_count int
      ,convert(varchar(30),pickup_datetime,120) as pickup_datetime
      ,cast(pickup_longitude as float) as pickup_longitude_n
      ,cast(pickup_latitude as float) as pickup_latitude_n
      ,cast(dropoff_longitude as float) as dropoff_longitude_n
      ,cast(dropoff_latitude as float) as dropoff_latitude_n
      from [dbo].[nyctaxi_sample] 
	  where datepart(mm,pickup_datetime)=1'

execute sp_execute_external_script 
@language = N'Python', 
@script = N'
import pandas as pd
import numpy as np
def coordinates2distance(lat1,lat2,long1,long2):
    R=6373.0 #radius of earth in km
    p = 0.017453292519943295 # Pi/180 to convert to radians
    lat1=lat1*p
    lat2=lat2*p
    long1=long1*p
    long2=long2*p
    dlon=(long2-long1)
    dlat=(lat2-lat1)
    a=(np.sin(dlat/2)**2)+(np.cos(lat1)*np.cos(lat2)*np.sin(dlon/2)**2)
    c=2*np.arctan2(np.sqrt(a),np.sqrt(1-a))
    return R*c

df=pd.DataFrame(MyInput)
df["distance"]=coordinates2distance(df["pickup_latitude_n"].values,df["dropoff_latitude_n"].values,df["pickup_longitude_n"].values,df["dropoff_longitude_n"].values)
MyOutput = df
',
@input_data_1_name = N'MyInput',
@input_data_1 =@inp,
@output_data_1_name = N'MyOutput'
WITH RESULT SETS ((fare_amount float,  passenger_count int, pickup_datetime varchar(50), pickup_longitude_n float, pickup_latitude_n float, dropoff_longitude_n float, dropoff_latitude_n float, 
distance float))