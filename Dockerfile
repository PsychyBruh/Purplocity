# Use the official Node.js image with Alpine
FROM node:20-alpine

# Set environment variable for production
ENV NODE_ENV=production
EXPOSE 8443/tcp

# Labels for the image
LABEL maintainer="Purplocity"
LABEL summary="Purplocity Frontend"
LABEL description="Example application of Purplocity's frontend which can be deployed in production."

# Set the working directory inside the container
WORKDIR /app

# Install necessary packages for building (python3, make, g++, libvips-dev, etc.)
RUN apk add --no-cache --upgrade \
    python3 \
    make \
    g++ \
    libvips-dev \
    bash \
    libc6-compat \
    && rm -rf /var/cache/apk/*

# Copy only package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install dependencies for production build
RUN npm install --production

# Copy the rest of the application files
COPY . .

# Copy and adjust config (if needed)
COPY ./config/config.example.js ./config/config.js

# Modify the config file if necessary
RUN sed -i 's/host: \"localhost\"/host: \"0.0.0.0\"/g' ./config/config.js

# Run the build process (Astro's build command)
RUN npm run build

# Set the entry point for the container
ENTRYPOINT [ "node" ]
CMD ["run-server.js"]
