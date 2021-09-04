from kafka import KafkaProducer, KafkaConsumer
from json import dumps, loads
from time import sleep,time
from datetime import datetime, timezone



consumer = KafkaConsumer(
    'input',
     bootstrap_servers=['localhost:9092'],
     auto_offset_reset='earliest',
     enable_auto_commit=True,
     group_id='my-group',
     value_deserializer=lambda x: loads(x.decode('utf-8')))


producer_output = KafkaProducer(bootstrap_servers=['localhost:9092'], value_serializer=lambda y: dumps(y).encode('utf-8'))

def convert_epoch_3339(message):
    d = datetime.utcfromtimestamp(message/1000)
    # print(d)
    # d = d.replace(tzinfo=timezone.utc)
    # print(d)
    # d_converted = datetime.strftime(d, "%Y-%m-%dT%H:%M:%S.%fZ")
    d_converted = d.isoformat()
    print(d_converted)
    return d_converted

for message in consumer:
    message = message.value
    # # Convert timestamp to rfc3339 date type
    producer_output.send('output', convert_epoch_3339(message))
    # print('This is the message converted {}'.format(d_converted))

