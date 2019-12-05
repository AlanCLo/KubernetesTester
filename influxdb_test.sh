#!/bin/bash


set -x

HOST=192.168.99.100
PORT=31406
DB=tutorialdb


curl -i -XPOST "http://$HOST:$PORT/write?db=$DB" --data-binary 'asdf,key=4 value=4'

curl -G "http://$HOST:$PORT/query?pretty=true" --data-urlencode "db=$DB" --data-urlencode 'q=select * from asdf'

