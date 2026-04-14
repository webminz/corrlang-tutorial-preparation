#!/bin/bash
npm run --prefix /home/coder/endpoints/endpoint1/ > /dev/null 2> /dev/null & \
    npm run --prefix /home/coder/endpoints/endpoint2/ > /dev/null 2> /dev/null & \
    npm run --prefix /home/coder/endpoints/endpoint3/ > /dev/null 2> /dev/null & \
    corrl up & \
    code-server --bind-addr 0.0.0.0:8080 /home/coder/project
