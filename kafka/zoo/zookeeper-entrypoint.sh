#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

ZOO_CONFIG_FILE="${BASEDIR}/conf/zoo.cfg"

echo "tickTime=${ZOO_TICK_TIME}" > "${ZOO_CONFIG_FILE}"
echo "dataDir=${ZOO_DATA_DIR}" >> "${ZOO_CONFIG_FILE}"
echo "clientPort=${ZOO_CLIENT_PORT}" >> "${ZOO_CONFIG_FILE}"
echo "initLimit=${ZOO_INIT_LIMIT}" >> "${ZOO_CONFIG_FILE}"
echo "syncLimit=${ZOO_SYNC_LIMIT}" >> "${ZOO_CONFIG_FILE}"
echo "dataLogDir=${ZOO_LOG_DIR}" >> "${ZOO_CONFIG_FILE}"

#ZOO_SERVERS="1@zoo1:2888:3888,2@zoo1:2888:3888"

IFS=',' read -ra SERVERS <<< "${ZOO_SERVERS}"

for SERVER in ${SERVERS[@]}
do
    IFS='@' read -ra SERVER_TUPLE <<< "${SERVER}"
    echo "server.${SERVER_TUPLE[0]}=${SERVER_TUPLE[1]}" >> "${ZOO_CONFIG_FILE}"
done

