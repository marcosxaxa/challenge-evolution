from time import sleep,time, timezone
import time
from datetime import date, datetime, tzinfo



from datetime import datetime, timezone

test_data = 1630711870727


utc_d = datetime.utcfromtimestamp(test_data/1000)
local_d = datetime.fromtimestamp(test_data / 1000)
# print(time.gmtime(test_data))
# d_utc = datetime.utcnow()
# print(d_utc)
# print(utc_d)
# print(local_d)
# d = d.replace(tzinfo=timezone.utc)
# print(d)
print(utc_d.isoformat())
d_converted = datetime.strftime(utc_d, "%Y-%m-%dT%H:%M:%S.%fZ")


# dt = datetime.utcnow()
# dt = dt.replace(tzinfo=timezone.utc)

# print(dt.isoformat())
# '2017-01-12T22:11:31+00:00'




# print(time())

# now = time()
# d = datetime.fromtimestamp(now,)
# d_converted = datetime.strftime(d, "%Y-%m-%dT%H:%M:%S.%fZ")

# print(d_converted)

# print(datetime.now())


# dt = datetime.now()
  
# utc_time = dt.replace(tzinfo=timezone.utc)
# utc_timestamp = utc_time.timestamp()

# print(utc_timestamp)