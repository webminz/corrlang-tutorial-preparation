#!/bin/bash
HOSTNAME=$(hostname)
echo "NEXT_PUBLIC_SERVER=${HOSTNAME}:6969" > /home/coder/project/CorrLangUI/.env
echo "DATABASE_URL='file:./prisma/dev.db'" >> /home/coder/project/CorrLangUI/.env

cd /home/coder/project/CorrLangUI/
npx prisma generate
npx prisma db push
npm run build

npm run --prefix /home/coder/endpoints/endpoint1/ start > /dev/null 2> /dev/null & \
    npm run --prefix /home/coder/endpoints/endpoint2/ start > /dev/null 2> /dev/null & \
    npm run --prefix /home/coder/endpoints/endpoint3/ start > /dev/null 2> /dev/null & \
    corrl up

npx tsx /home/coder/project/CorrLangUI/src/lib/prisma-wipe.ts & \
    node /home/coder/project/CorrLangUI/server.js & \
    code-server --bind-addr 0.0.0.0:8080 /home/coder/project
# code-server --bind-addr 0.0.0.0:8080 /home/coder/project