import pandas as pd
import sys
sys.path.append('..')

df = pd.read_csv('Utils/C_2024-09-16 22-46-35.csv')
for index, record in df.iterrows():
    print(record['date'])
