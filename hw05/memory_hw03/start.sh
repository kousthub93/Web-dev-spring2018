#!/bin/bash

export PORT=5105

cd ~/www/memory
./bin/memory stop || true
./bin/memory start

