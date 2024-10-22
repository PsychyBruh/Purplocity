# Switch to a Debian-based Node.js image (it comes with a wider range of packages)
FROM node:20-slim

# Set environment variable for production
ENV NODE_ENV=production
EXPOSE 8080/tcp

# Labels for the image
LABEL maintainer="Purplocity"
LABEL summary="Purplocity Frontend"
LABEL description="Example application of Purplocity's frontend which can be deployed in production."

# Set the working directory inside the container
WORKDIR /app

# Install necessary build dependencies for sharp and other packages
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    libvips-dev \
    bash \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

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
