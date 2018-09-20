FROM bdcloud/java8-base

MAINTAINER james tang <jamess@126.com>

ENV ZOO_CONF_DIR=/conf \
    ZOO_DATA_DIR=/data \
    ZOO_DATA_LOG_DIR=/datalog \
    ZOO_PORT=2181 \
    ZOO_TICK_TIME=2000 \
    ZOO_INIT_LIMIT=5 \
    ZOO_SYNC_LIMIT=2 \
    ZOO_MAX_CLIENT_CNXNS=60

ENV ZOOKEEPER_VERSION 3.4.13

ADD zookeeper-$ZOOKEEPER_VERSION.tar.gz /opt

RUN mv /opt/zookeeper-$ZOOKEEPER_VERSION /opt/zookeeper

COPY ./zoo.cfg /opt/zookeeper/conf/

RUN mkdir -p "$ZOO_DATA_LOG_DIR" "$ZOO_DATA_DIR" "$ZOO_CONF_DIR"


#RUN mkdir /data

COPY docker-entrypoint.sh /
COPY run.sh /

EXPOSE 2181 2888 3888

ENV PATH=$PATH:/opt/zookeeper/bin \
    ZOOCFGDIR=$ZOO_CONF_DIR

#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["zkServer.sh", "start-foreground"]
CMD ["./run.sh"]
