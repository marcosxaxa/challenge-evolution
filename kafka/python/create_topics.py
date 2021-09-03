from confluent_kafka.admin import AdminClient, NewTopic


admin_client = AdminClient({"bootstrap.servers": "localhost:9092"})


topic_list = []
topic_list.append(NewTopic("input", 1, 1))
topic_list.append(NewTopic("output", 1, 1))
# print(topic_list)
admin_client.create_topics(topic_list)

topics_list = admin_client.list_topics().topics

print(topics_list)