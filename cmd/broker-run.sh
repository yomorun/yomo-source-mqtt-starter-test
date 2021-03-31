#!/usr/bin/env bash

set -e

# broker-flow
nohup ./yomo run ./broker-flow/app.go -p 5252  > broker-flow.out 2>&1 &

ps aux|grep broker-flow

sleep 2s
netstat -an | grep -E '5252'
sleep 2s

# broker-zipper
nohup ./yomo wf run ./broker-zipper/workflow.yaml  > broker-flow.out 2>&1 &

ps aux|grep broker-zipper

sleep 2s
netstat -an | grep -E '8888'
sleep 2s

# broker-source
export YOMO_SOURCE_MQTT_ZIPPER_ADDR=localhost:8888
export YOMO_SOURCE_MQTT_BROKER_ADDR=localhost:2883
nohup go run ./broker-source/main.go  > broker-source.out 2>&1 &

ps aux|grep broker-flow

sleep 2s
netstat -an | grep -E '2883'
sleep 2s

# broker-emit
export YOMO_SOURCE_MQTT_BROKER_ADDR=tcp://localhost:2883
nohup go run ./broker-emit/main.go  > broker-emit.out 2>&1 &

ps aux|grep broker-emit

sleep 4s

netstat -an | grep -E '5252|8888|2883'