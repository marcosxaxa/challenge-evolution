from kafka import KafkaProducer
from json import dumps
from time import sleep,time

producer = KafkaProducer(bootstrap_servers=['my-cluster-kafka-bootstrap:9092'], value_serializer=lambda x: dumps(x).encode('utf-8'))


while True:
    ms = int(time() * 1000)
    print("Time in ms since epoch {}".format(ms))
    producer.send('input', ms)
    sleep(1)
