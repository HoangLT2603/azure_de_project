import random
from faker import Faker
import pandas as pd
from confluent_kafka import Producer
import json
import time

fake = Faker()

# Kafka broker address
bootstrap_servers = 'localhost:9092'
# Kafka topic to produce messages to
topic = 'fake_events'

conf = {'bootstrap.servers': bootstrap_servers}
producer = Producer(conf)
 
def delivery_report(err, msg):
    if err is not None:
        print(f'Message delivery failed: {err}')
    else:
        print(f'Message delivered to {msg.topic()} [{msg.partition()}] at offset {msg.offset()}')


def generate_random_data():

    df = pd.read_parquet("../sample_data/restaurant_inspection_results.parquet", engine='pyarrow')
    cuisine_list = df.cuisine_description.drop_duplicates().dropna().to_list() + [""]
    violation_code_list = df.violation_code.drop_duplicates().dropna().to_list() + [""]
    inspection_type_list = df.inspection_type.drop_duplicates().dropna().to_list()

    for _ in range(1000): 
        message = [{
            "camis":str(random.randint(30000000, 50199999)),  # CAMIS
            "dba":fake.company(),  # DBA
            "boro":random.choice(['Brooklyn', 'Queens', 'Manhattan', 'Bronx', 'Staten Island']),  # BORO
            "building":str(random.randint(100, 2000)),  # BUILDING
            "street":fake.street_name(),  # STREET
            "zipcode":str(random.randint(10000, 99999)),  # ZIPCODE
            "phone":fake.phone_number(),  # PHONE
            "cuisine_description":fake.random_element(cuisine_list),  # CUISINE DESCRIPTION
            "inspection_date":fake.date(),  # INSPECTION DATE
            "action":fake.word(),  # ACTION
            "violation_code":fake.random_element(violation_code_list),  # VIOLATION CODE
            "violation_description":fake.sentence(),  # VIOLATION DESCRIPTION
            "critical_flag":fake.random_element(['Not Critical', 'Critical', 'Not Applicable']),  # CRITICAL FLAG
            "scope":str(random.randint(0, 200)),  # SCORE
            "grade":fake.random_element(['A', 'B', 'C', 'Z', 'P', 'N']),  # GRADE
            "grade_date":fake.date(),  # GRADE DATE
            "record_date":fake.date(),  # RECORD DATE
            "inspection_type":fake.random_element(inspection_type_list),  # INSPECTION TYPE
            "latitude":str(fake.latitude()),  # Latitude
            "longitude":str(fake.longitude()),  # Longitude
            "community_board":str(random.randint(100, 500)),  # Community Board
            "council_district":str(random.randint(1, 50)),  # Council District
            "census_tract":str(random.randint(10000, 99999)),  # Census Tract
            "bin":str(random.randint(1000000, 9999999)),  # BIN
            "bbl":str(random.randint(1000000, 9999999)),  # BBL
            "nta":fake.random_element(['NTA1', 'NTA2', 'NTA3']),  # NTA
            "location_point1":fake.random_element(['Location Point1', 'Location Point2']),  # Location Point1
        }]

        message = json.dumps(message)
        producer.produce(topic, message, callback=delivery_report)
        producer.flush()
        time.sleep(3)


generate_random_data()