# Use an official base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Update package list and install basic dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy application files (add your files here)
# COPY . .

# Expose port (adjust as needed)
# EXPOSE 8080

# Define the default command
CMD ["echo", "Hello from Docker image!"]