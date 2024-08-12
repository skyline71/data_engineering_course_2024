# Lesson 9: Import, pip install, packages

import datetime
import pandas as pd
from Utils.Utility1 import Human
from Utils.Utility1 import Roth
from Utils.Utility1 import Regiment

# Task 1
date = datetime.datetime.now(datetime.UTC)
date1 = date - datetime.timedelta(hours=1)
print(type(date))
print(date)
print(date1)
print('')

# Task 2
df = pd.DataFrame()
print(df)
print('')

# Task 3
meat1 = Human()
meat2 = Human('Stas', 34)
meat3 = Human('Volodimir', 46)
meat4 = Human('Peter', 58)
meat5 = Human('Joe', 81)
meat6 = Human('Vadim', 61)

roth1 = Roth('Azov stal', [meat1, meat2, meat3])
roth2 = Roth('Russian piece', [meat4, meat5, meat6])

regiment = Regiment([roth1, roth2])
regiment.print_regiment()

roth2.remove_soldier(meat2) # Exception
print('')
roth1.remove_soldier(meat2)
regiment.print_regiment()

regiment.remove_soldier(roth1, meat5) # Exception
print('')
regiment.remove_soldier(roth2, meat5)
regiment.print_regiment()
