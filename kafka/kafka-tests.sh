#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

kubectl -n trn-kube exec -it kafka-stset-0 -- /bin/bash
bin/kafka-topics.sh --create --topic kafka-test-topic --bootstrap-server kafka-stset-0.kafka-stset.trn-kube.svc.cluster.local:9092
bin/kafka-topics.sh --describe --topic kafka-test-topic --bootstrap-server kafka-stset-0.kafka-stset.trn-kube.svc.cluster.local:9092
bin/kafka-console-producer.sh --topic kafka-test-topic --bootstrap-server kafka-stset-0.kafka-stset.trn-kube.svc.cluster.local:9092
bin/kafka-console-consumer.sh --topic kafka-test-topic --bootstrap-server kafka-stset-0.kafka-stset.trn-kube.svc.cluster.local:9092 --from-beginning