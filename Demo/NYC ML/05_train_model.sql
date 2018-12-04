USE NYCTaxi_Sample
GO

DROP PROCEDURE IF EXISTS [sp_train_model]
GO

create procedure [dbo].[sp_train_model] (@trained_model varbinary(max) OUTPUT)
as
begin

execute sp_execute_external_script 
@language = N'Python', 
@script = N' 
import pickle
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.metrics import mean_squared_error

df=pd.DataFrame(InputDataSet)
X=df.drop(["fare_amount"],axis=1)
y=np.ravel(df["fare_amount"])
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.3)

params = {"n_estimators": 500, "max_depth": 6, "min_samples_split": 2,
          "learning_rate": 0.01, "loss": "ls"}
clf = GradientBoostingRegressor(**params)
clf.fit(X_train, y_train)
mse = mean_squared_error(y_test, clf.predict(X_test))
print("MSE: %.4f" % mse)

trained_model = pickle.dumps(clf)
',
@input_data_1 = N'Select top 600000 cast(fare_amount as float) as fare_amount 
      ,cast(passenger_count as int) as passenger_count
      ,cast(pickup_longitude_n as float) as pickup_longitude_n
      ,cast(pickup_latitude_n as float) as pickup_latitude_n
      ,cast(dropoff_longitude_n as float) as dropoff_longitude_n
      ,cast(dropoff_latitude_n as float) as dropoff_latitude_n
	  ,cast(pickup_month as int) as pickup_month
      ,cast(pickup_day as int) as pickup_day
      ,cast(pickup_hour as int) as pickup_hour
      ,cast(is_weekend as int) as is_weekend
      ,cast(distance as float) as distance
      ,cast(pickup_distance_jfk as float) as pickup_distance_jfk
      ,cast(dropoff_distance_jfk as float) as dropoff_distance_jfk
      ,cast(pickup_distance_ewr as float) as pickup_distance_ewr
      ,cast(dropoff_distance_ewr as float) as dropoff_distance_ewr
      ,cast(pickup_distance_lgr as float) as pickup_distance_lgr
      ,cast(dropoff_distance_lgr as float) as dropoff_distance_lgr
      ,cast(is_airport as int) as is_airport
  FROM NYCTaxi_Sample.dbo.nyc_features_prep',
@input_data_1_name = N'InputDataSet',
@params = N'@trained_model varbinary(max) OUTPUT',
@trained_model = @trained_model OUTPUT;
END