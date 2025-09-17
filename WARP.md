# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Docker image template project designed for creating containerized applications. The project provides a minimal starting structure with an Ubuntu-based Dockerfile that can be customized for specific applications.

## Common Commands

### Docker Operations
```bash
# Build the Docker image
docker build -t my-docker-image .

# Run the container (basic)
docker run --rm my-docker-image

# Run with port mapping (adjust port as needed)
docker run -p 8080:8080 --rm my-docker-image

# Run interactively with shell access
docker run -it --rm my-docker-image /bin/bash

# Build with custom tag
docker build -t your-app-name:latest .
```

### Development Workflow
```bash
# Check Docker status
docker --version

# List Docker images
docker images

# List running containers
docker ps

# Clean up unused Docker resources
docker system prune
```

## Architecture and Structure

### Project Type
This is a **Docker template project** rather than a fully-implemented application. The structure is intentionally minimal to serve as a starting point for containerized applications.

### Key Components
- **Dockerfile**: Uses Ubuntu 22.04 as base image with basic utilities (curl, wget)
- **Template Nature**: Contains placeholder comments for adding application-specific code
- **Flexible Foundation**: Designed to be customized for various application types

### Dockerfile Architecture
- **Base Image**: Ubuntu 22.04 (can be changed based on application needs)
- **Working Directory**: `/app`
- **Default Behavior**: Prints "Hello from Docker image!" (placeholder command)
- **Commented Sections**: Port exposure and file copying are commented out for customization

## Customization Points

When working with this project, key areas that typically need modification:

1. **Base Image**: Change `FROM ubuntu:22.04` to match your application requirements (e.g., `node:18`, `python:3.11`, etc.)
2. **Dependencies**: Modify the RUN command to install application-specific packages
3. **File Copying**: Uncomment and modify `COPY . .` to include your application files
4. **Port Configuration**: Uncomment and adjust `EXPOSE` directive for your application's port
5. **Startup Command**: Replace the default `CMD` with your application's startup command

## Development Notes

- The project includes a comprehensive `.gitignore` covering Docker, IDE, OS, and common language-specific patterns
- No application code is present - this is purely a template structure
- Port 8080 is referenced in examples but not exposed in the current Dockerfile
- The container removes itself after execution (`--rm` flag) in the provided examples