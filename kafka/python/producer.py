from confluent_kafka import Producer
from confluent_kafka import SerializingProducer
from json import dumps
from time import sleep

producer = SerializingProducer({"bootstrap.servers": "localhost:9092"})

for i in range(1000):
    producer.poll(0)
    producer.produce('input', i)
    sleep(2)