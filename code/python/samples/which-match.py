import pandas as pd
#import os
#os.getcwd()
#os.chdir('/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/python/samples/')

with open('sample-list.txt', 'r') as file:
    lines = file.readlines()

pd_samples = []
for i, line in enumerate(lines, start=1):
    line = line.strip()
    parts = line.split("_")
    # get "Song Title"
    number = int(parts[1].strip())
    pd_samples.append(number)

df_pd_samples = pd.DataFrame(pd_samples)

total_samps = []
for x in range(85):
    tot = x+1
    total_samps.append(tot)

df_tot_samps = pd.DataFrame(total_samps)

### finish the tutorial from here
# Merge dataframes on columns 'A' and 'B' (default is inner join)
matching_rows = pd.merge(df_pd_samples, df_tot_samps, how='inner')
print(matching_rows)

## do not worry about adding more data