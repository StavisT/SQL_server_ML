-- Create matrix and output as table using dataframe
execute sp_execute_external_script 
@language = N'Python', 
@script = N'
import numpy as np
import pandas as pd
lis1=np.random.randint(5,size=(2,4))
print(lis1)
output=pd.DataFrame(lis1)
',
@output_data_1_name = N'output'
WITH Result SETS ((Rand1 int, Rand2 int, Rand3 int, Rand4 int))