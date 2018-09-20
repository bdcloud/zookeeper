#!/bin/bash
./docker-entrypoint.sh
sleep 20
zkServer.sh start-foreground
