#!/usr/bin/env bash

set -e

# native-flow
nohup ./yomo run ./native-flow/app.go -p 6262  > native-flow.out 2>&1 &

ps aux|grep native-flow

sleep 2s
netstat -an | grep -E '6262'
sleep 2s

# native-zipper
nohup ./yomo wf run ./native-zipper/workflow.yaml  > native-flow.out 2>&1 &

ps aux|grep native-zipper

sleep 2s
netstat -an | grep -E '7777'
sleep 2s

# native-source
export YOMO_SOURCE_MQTT_ZIPPER_ADDR=localhost:7777
export YOMO_SOURCE_MQTT_SERVER_ADDR=localhost:3883
nohup go run ./native-source/main.go  > native-source.out 2>&1 &

ps aux|grep native-source

sleep 2s
netstat -an | grep -E '3883'
sleep 2s

# native-emit
export YOMO_SOURCE_MQTT_BROKER_ADDR=tcp://localhost:3883
nohup go run ./native-emit/main.go  > native-emit.out 2>&1 &

ps aux|grep native-emit

sleep 4s

netstat -an | grep -E '6262|7777|3883'