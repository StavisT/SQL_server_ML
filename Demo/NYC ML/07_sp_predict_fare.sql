USE NYCTaxi_Sample
GO

DROP PROCEDURE IF EXISTS [sp_predict_fare]
GO

CREATE PROCEDURE [dbo].[sp_predict_fare] (@model varchar(50), @inquery nvarchar(max))
AS
BEGIN
DECLARE @lmodel2 varbinary(max) = (select model from nyc_taxi_models where model_name = @model);

EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
import pickle
import numpy as np
import pandas as pd
from sklearn import metrics

mod = pickle.loads(lmodel2)
df=pd.DataFrame(InputDataSet)
X = df.drop(["fare_amount"],axis=1)
probArray = mod.predict(X)

predictions = pd.DataFrame(data = probArray, columns = ["predictions"])
OutputDataSet = pd.concat([predictions,df["fare_amount"]],axis=1)
',    
@input_data_1 = @inquery,
@input_data_1_name = N'InputDataSet',
@params = N'@lmodel2 varbinary(max)',
@lmodel2 = @lmodel2
WITH RESULT SETS ((predictions float, fare_amount float));
END
GO