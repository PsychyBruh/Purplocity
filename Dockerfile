FROM node:20-alpine

# Set environment variable
ENV NODE_ENV=production
EXPOSE 8443/tcp

# Labels for the image
LABEL maintainer="Purplocity"
LABEL summary="Purplocity Frontend"
LABEL description="Example application of Purplocity's frontend which can be deployed in production."

# Set the working directory inside the container
WORKDIR /app

# Copy application files into the container
COPY . .

# Copy the config file (if needed)
COPY ./config/config.example.js ./config/config.js

# Modify the config file as required
RUN sed -i 's/host: \"localhost\"/host: \"0.0.0.0\"/g' ./config/config.js

# Install necessary packages for building (python3, make, g++, etc.)
RUN apk add --upgrade --no-cache python3 make g++

# Copy the auto-npm.js script into the container
COPY ./auto-npm.js /app/auto-npm.js

# Run the auto-npm.js script to handle npm install and missing dependencies
RUN node /app/auto-npm.js

# Build the application (if needed)
RUN npm run build

# Set the entry point for the container
ENTRYPOINT [ "node" ]
CMD ["run-server.js"]
