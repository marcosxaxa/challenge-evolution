# from confluent_kafka import Producer
# from confluent_kafka.serialization import IntegerSerializer, Serializer
# from confluent_kafka import SerializingProducer
from kafka import KafkaProducer, KafkaConsumer
from json import dumps, loads
from time import sleep,time
from datetime import datetime

producer = KafkaProducer(bootstrap_servers=['localhost:9092'], value_serializer=lambda x: dumps(x).encode('utf-8'))
# producer = Producer({"bootstrap.servers": "localhost:9092"})


while True:
    ms = int(time() * 1000)
    print("Time in ms since epoch {}".format(ms))
    # print("The date is {}".format(d))
    producer.send('input', ms)
    sleep(1)




# # Convert timestamp to rfc3339 date type
# d = datetime.fromtimestamp(ms/1000)
# d_converted = datetime.strftime(d, "%Y-%m-%dT%H:%M:%S.%fZ")
# print(d_converted)

# for i in range(1000):
#     # producer.poll(0)
#     producer.send('input', i)
#     sleep(2)