#!/bin/bash
npm run --prefix /home/coder/endpoints/endpoint1/ start > /dev/null 2> /dev/null & \
    npm run --prefix /home/coder/endpoints/endpoint2/ start > /dev/null 2> /dev/null & \
    npm run --prefix /home/coder/endpoints/endpoint3/ start > /dev/null 2> /dev/null & \
    corrl up & \
    code-server --bind-addr 0.0.0.0:8080 /home/coder/project
