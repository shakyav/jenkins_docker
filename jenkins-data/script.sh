#!/bin/bash
NAME=$1
LASTNAME=$2

echo "Hello World"
echo "curent date is $(date)"
echo "Hellow $NAME $LASTNAME, current time and date is $(date)" >> /tmp/info
cat /tmp/info
