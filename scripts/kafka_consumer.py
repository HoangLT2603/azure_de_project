from confluent_kafka import Consumer, KafkaError
from azure.eventhub import EventHubProducerClient, EventData
import json


# Kafka broker address
bootstrap_servers = 'localhost:9092'
# Kafka topic to consume messages from
topic = 'fake_events'


# Create Kafka consumer
kafka_consumer = Consumer({
    'bootstrap.servers': bootstrap_servers,
    'group.id': 'my_consumer',
    'auto.offset.reset': 'earliest'
})
kafka_consumer.subscribe([topic])

# Azure Event Hubs configuration
eventhub_connection_string = "Endpoint=sb://demostreamevent.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=2nd9twkDEE84PpvER9WoE8Z1QWsfyCl/L+AEhNhVu3A="  
eventhub_name = "fake_inspection_events" 
eventhub_producer = EventHubProducerClient.from_connection_string(conn_str=eventhub_connection_string,
                                                         eventhub_name=eventhub_name)


def produce_to_eventhub(message):
    batch = eventhub_producer.create_batch()
    event_data = EventData(json.dumps(message))
    batch.add(event_data)
    eventhub_producer.send_batch(batch)


def consume_from_kafka():
    try:
        while True:
            msg = kafka_consumer.poll(1.0)
            if msg is None:
                continue
            if msg.error():
                print("Consumer error: {}".format(msg.error()))
                continue
            
            message = msg.value()
            data = json.loads(message)

            print("Received message from Kafka: {}".format(data))

            #send to event hub
            produce_to_eventhub(data)

            kafka_consumer.commit()

    except KeyboardInterrupt:
        pass

    finally:
        kafka_consumer.close()
        eventhub_producer.close()


consume_from_kafka()