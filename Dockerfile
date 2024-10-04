FROM node:20-alpine

ENV NODE_ENV=production
EXPOSE 8443/tcp

LABEL maintainer="Purplocity"
LABEL summary="Purplocity Frontend"
LABEL description="Example application of Purplocity's frontend which can be deployed in production."

WORKDIR /app

COPY . .
COPY ./config/config.example.js ./config/config.js

RUN sed -i 's/host: \"localhost\"/host: \"0.0.0.0\"/g' ./config/config.js

RUN apk add --upgrade --no-cache python3 make g++
RUN npm install
RUN npm run build

ENTRYPOINT [ "node" ]
CMD ["run-server.js"]