#!/bin/sh
docker-machine create --driver virtualbox \
        --virtualbox-cpu-count "2" \
        --virtualbox-memory "4096" \
        --virtualbox-disk-size "64000" \
        dev
