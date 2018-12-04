--Create List
execute sp_execute_external_script 
@language = N'Python', 
@script = N'
import numpy as np
lis1=np.arange(10)
print(lis1)
'

-- Create Matrix
execute sp_execute_external_script 
@language = N'Python', 
@script = N'
import numpy as np
lis1=np.random.randint(5,size=(2,4))
print(lis1)
'
