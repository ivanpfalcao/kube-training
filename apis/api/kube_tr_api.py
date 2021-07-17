# -*- coding: utf-8 -*-

import os
import logging
import datetime
import random
import string
import importlib
import os.path

from json import dumps, loads

from typing import List
from fastapi import FastAPI,HTTPException
from kafka import KafkaProducer
from starlette.requests import Request
from pydantic import BaseModel
from typing import Optional


app = FastAPI()

# Logging
log_level = os.environ.get('LOG_LEVEL', 'INFO').upper()
logger = logging.getLogger('uvicorn')
logger.setLevel(log_level)
logger.info('Log level: {}'.format(log_level))

api_pod_uid=os.environ['POD_UID']

# Kafka
kafka_bootstrap_servers=os.environ.get('KAFKA_BOOTSTRAP_SERVERS','127.0.0.1:9092')
kafka_topic=os.environ.get('KAFKA_TOPIC','default-topic')
kafka_key=os.environ.get('KAFKA_TOPIC_KEY','')
rand_format = string.ascii_lowercase
rand_len = 10
kafka_group_id=os.environ.get('KAFKA_GROUP_ID',''.join(random.choice(rand_format) for i in range(rand_len)))
auto_offset_reset=os.environ.get('KAFKA_OFFSET_RESET','earliest')
logger.debug("Bootstrap servers: {}".format(kafka_bootstrap_servers))
logger.debug("Group id: {}".format(kafka_group_id))            
logger.debug("Topic: {}".format(kafka_topic))


# Random leia ID parameters
rand_format = string.ascii_lowercase
rand_len = 8

class MyRequest(BaseModel):
    ticket_id: str
    obs: Optional[str]


@app.post('/api-tests')
async def api_tests(req_body: MyRequest, request: Request):
    try:

        logger.debug("Key: {}".format(kafka_key))    
        message = {}

        message['ticket_id'] = req_body.ticket_id
        message['api_pod_uid'] = api_pod_uid
        message['obs'] = req_body.obs
        message['request_ts'] = str(datetime.datetime.now().strftime("%Y_%m_%d_%H_%M_%S_%f"))

        logger.debug("Value: {}".format(message))  

        producer = KafkaProducer(bootstrap_servers=kafka_bootstrap_servers)  
        future = producer.send(kafka_topic, key=kafka_key.encode('utf-8'), value=dumps(message).encode('utf-8'))
        future.get(timeout=60)        

    except Exception as e: 
        raise e      

    return {"Status": "Success"}

class LeiaIdsRequest(BaseModel):
    leia_ids: List[str]

@app.get('/status')
async def status():
    return 'Ok'