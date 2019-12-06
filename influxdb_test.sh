#!/bin/bash


set -x

INFLUXDB_URL=$(minikube service --url influxdb)

HOST=192.168.99.100
PORT=31406
DB=tutorialdb


# Make DB. Its ok to call more than once
curl -i -XPOST "$INFLUXDB_URL/query" --data-urlencode "q=CREATE DATABASE $DB"

curl -i -XPOST "$INFLUXDB_URL/write?db=$DB" --data-binary 'asdf,key=4 value=4'

curl -G "$INFLUXDB_URL/query?pretty=true" --data-urlencode "db=$DB" --data-urlencode 'q=select * from asdf'

