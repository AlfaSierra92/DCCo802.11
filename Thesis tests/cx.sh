#!/bin/bash

# Verifica che siano stati forniti i tre argomenti necessari
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <message_size> <sleep_time>"
    exit 1
fi

message_size=$1
sleep_time=$2
ip_broadcast=192.168.100.255
interface=wlp1s0
random_port=$(( ( RANDOM % 64512 ) + 1024 ))

# Genera un messaggio di dimensione specificata
message=$(head -c $message_size </dev/zero | tr '\0' 'A')

# Inizia lo script
echo "Starting..."
sleep 1

while true; do
    # Invio dei messaggi
    echo -n "$message" | nc -u -b -w1 -q0 $ip_broadcast $random_port &
    sleep $sleep_time
done