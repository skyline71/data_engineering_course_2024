from datetime import datetime, UTC
import pytz


date = datetime.now(UTC).replace(microsecond=0, tzinfo=None)
new_date = date.astimezone(pytz.timezone('Europe/Moscow'))

date1 = datetime.now()

print(date)
print(new_date)

print(date1.replace(microsecond=0))