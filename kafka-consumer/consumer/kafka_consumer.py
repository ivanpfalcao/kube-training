# -*- coding: utf-8 -*-

import os
import random
import string
import logging
import json
import datetime


from logging import Logger
from json import dumps, loads
from kafka import KafkaConsumer
from kafka.errors import NoBrokersAvailable
from sqlalchemy import create_engine, text

# Logging
log_level = os.environ.get('LOG_LEVEL', 'INFO').upper()
root_logger_level = os.environ.get('ROOT_LOG_LEVEL', 'INFO').upper() 
logging.basicConfig(encoding='utf-8', level=root_logger_level)
logger = logging.getLogger('orchestrator')
logger.setLevel(log_level)

logger.info('Log level: {}'.format(log_level))
logger.info('Root Log level: {}'.format(root_logger_level))

# Get Kafka configs
kafka_bootstrap_servers=os.environ.get('KAFKA_BOOTSTRAP_SERVERS','127.0.0.1:9092')
kafka_input_topic=os.environ.get('KAFKA_INPUT_TOPIC','default-topic')
kafka_input_key=os.environ.get('KAFKA_INPUT_TOPIC_KEY','').encode('utf-8')
rand_format = string.ascii_lowercase
rand_len = 10     
kafka_group_id=os.environ.get('KAFKA_GROUP_ID',''.join(random.choice(rand_format) for i in range(rand_len)))
auto_offset_reset=os.environ.get('KAFKA_OFFSET_RESET','earliest')

# Set postgres connection
postgres_user = os.environ['POSTGRES_USERNAME']
postgres_pswd = os.environ['POSTGRES_PASSWORD']
postgres_host = os.environ['POSTGRES_HOSTNAME']
postgres_db   = os.environ['POSTGRES_DATABASE']
db_connection='postgresql://{POSTGRES_USERNAME}:{POSTGRES_PASSWORD}@{POSTGRES_HOSTNAME}/{POSTGRES_DB}'.format(
        POSTGRES_USERNAME=postgres_user,
        POSTGRES_PASSWORD=postgres_pswd,
        POSTGRES_HOSTNAME=postgres_host,
        POSTGRES_DB=postgres_db
    )

# Creates postgres engine
logger.info('Postgres connection: {}'.format(db_connection))
engine = create_engine(db_connection, echo=True, future=True)

# Insert data on postgres
def insert_database(kube_tr_id, kube_record):
    try:
        query = "INSERT INTO kube_tr_records (kube_tr_id, upsert_timestamp, kube_record) VALUES('{kube_tr_id}', '{upsert_timestamp}', '{kube_record}') ON CONFLICT (kube_tr_id) DO NOTHING".format(
            kube_tr_id=kube_tr_id,
            kube_record=json.dumps(kube_record),
            upsert_timestamp=str(datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.%f"))
        )

        with engine.connect() as conn:
            conn.execute(text(query))
            conn.commit()

            
    except Exception as e: 
        logger.exception("Error executing query on Postgres", e)
        raise e             

def run_consumer():
    try:
        logger.debug("Bootstrap servers: {}".format(kafka_bootstrap_servers))
        logger.debug("Topic: {}".format(kafka_input_topic))
        logger.debug("Key: {}".format(kafka_input_key))
        logger.debug("Group id: {}".format(kafka_group_id))

        # Create consumer
        kafka_consumer = KafkaConsumer(kafka_input_topic, 
                bootstrap_servers=kafka_bootstrap_servers, 
                group_id=kafka_group_id,
                auto_offset_reset=auto_offset_reset,
                enable_auto_commit=False
            )  

        for msg in kafka_consumer:

            try: 
                # Add Kafka information to the dict
                msg_dict = {}        
                msg_dict['kafka_topic'] = msg.topic
                msg_dict['kafka_partition'] = msg.partition
                msg_dict['kafka_offset'] = msg.offset
                msg_dict['kafka_timestamp'] = msg.timestamp
                msg_dict['kafka_timestamp_type'] = msg.timestamp_type
                msg_dict['kafka_key'] = msg.key.decode('utf8')
                msg_value = loads(msg.value)
                msg_dict = {**msg_dict, **msg_value}

                logger.debug('Complete msg: {}'.format(msg_dict))
                # Insert into database
                insert_database(msg_dict['request_id'], msg_dict)


                # Commit message 
                offset_list=[]
                logger.debug('Commiting offset: {}'.format(msg_dict['kafka_offset']))
                kafka_consumer.commit(offset_list.append(msg_dict['kafka_offset']))
                logger.debug('Commited offset: {}'.format(msg_dict['kafka_offset']))
            except Exception as e: 
                logger.exception("Error processing Kafka message. The process will continue", e)                     

    except NoBrokersAvailable as e: 
        #logger.exception("No Brokers Available for Kafka", e)
        logger.exception("No Kafka Broker Available", e)
        raise e          
    except Exception as e: 
        logger.exception("Kafka broker generic exception", e)
        raise e  

run_consumer()