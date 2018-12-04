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
from datetime import datetime
import calendar
from datetime import timedelta
import datetime as dt

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

lgr=(-73.8733, 40.7746)
jfk=(-73.7900, 40.6437)
ewr=(-74.1843, 40.6924)
nyc_airports={"JFK":{"min_lng":-73.8352,
     "min_lat":40.6195,
     "max_lng":-73.7401, 
     "max_lat":40.6659},
              
    "EWR":{"min_lng":-74.1925,
            "min_lat":40.6700, 
            "max_lng":-74.1531, 
            "max_lat":40.7081

        },
    "LaGuardia":{"min_lng":-73.8895, 
                  "min_lat":40.7664, 
                  "max_lng":-73.8550, 
                  "max_lat":40.7931
        
    }

}
def isAirport(latitude,longitude):
    res=0
    for airport_name in nyc_airports:
        if latitude>=nyc_airports[airport_name]["min_lat"] and latitude<=nyc_airports[airport_name]["max_lat"] and longitude>=nyc_airports[airport_name]["min_lng"] and longitude<=nyc_airports[airport_name]["max_lng"]:
            res=1
    return res
def encodeWeekend(day_of_week):
    day_dict={"Sunday":1,"Monday":0,"Tuesday":0,"Wednesday":0,"Thursday":0,"Friday":0,"Saturday":0}
    return day_dict[day_of_week]

df=pd.DataFrame(MyInput)
#print(pd.to_datetime(df["pickup_datetime"],format="%Y-%m-%d %H:%M:%S"))
date_array=pd.to_datetime(df["pickup_datetime"],format="%Y-%m-%d %H:%M:%S")
df["pickup_day_of_week"]= date_array.apply(lambda x:calendar.day_name[x.weekday()])
df["pickup_month"]= date_array.apply(lambda x:x.month)
df["pickup_day"]= date_array.apply(lambda x:x.day)
df["pickup_hour"]= date_array.apply(lambda x:x.hour)
df["is_weekend"]= df["pickup_day_of_week"].apply(lambda x:encodeWeekend(x))

df["distance"]=coordinates2distance(df["pickup_latitude_n"].values,df["dropoff_latitude_n"].values,df["pickup_longitude_n"].values,df["dropoff_longitude_n"].values)
df["pickup_distance_jfk"]=coordinates2distance(df["pickup_latitude_n"].values,jfk[1],df["pickup_longitude_n"].values,jfk[0])
df["dropoff_distance_jfk"]=coordinates2distance(df["dropoff_latitude_n"].values,jfk[1],df["dropoff_longitude_n"].values,jfk[0])
df["pickup_distance_ewr"]=coordinates2distance(df["pickup_latitude_n"].values,ewr[1],df["pickup_longitude_n"].values,ewr[0])
df["dropoff_distance_ewr"]=coordinates2distance(df["dropoff_latitude_n"].values,ewr[1],df["dropoff_longitude_n"].values,ewr[0])
df["pickup_distance_lgr"]=coordinates2distance(df["pickup_latitude_n"].values,ewr[1],df["pickup_longitude_n"].values,ewr[0])
df["dropoff_distance_lgr"]=coordinates2distance(df["dropoff_latitude_n"].values,lgr[1],df["dropoff_longitude_n"].values,lgr[0])

airportpickup=df.apply(lambda row:isAirport(row["pickup_latitude_n"],row["pickup_longitude_n"]),axis=1)
airportdropoff=df.apply(lambda row:isAirport(row["dropoff_latitude_n"],row["dropoff_longitude_n"]),axis=1)
df["is_airport"]=airportpickup.combine(airportdropoff, lambda x1, x2: x1 if x1 > x2 else x2)
df=df.drop(["pickup_datetime","pickup_day_of_week"],axis=1)
MyOutput = df

',
@input_data_1_name = N'MyInput',
@input_data_1 =@inp,
@output_data_1_name = N'MyOutput'
WITH RESULT SETS ((fare_amount float,  passenger_count int, pickup_longitude_n float, pickup_latitude_n float, dropoff_longitude_n float, dropoff_latitude_n float, 
pickup_month int,pickup_day int, pickup_hour int, is_weekend int,
distance float, pickup_distance_jfk float,dropoff_distance_jfk float,pickup_distance_ewr float, dropoff_distance_ewr float, pickup_distance_lgr float, dropoff_distance_lgr float,is_airport int ))