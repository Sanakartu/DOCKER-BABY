# Docker Commands Cheat Sheet 🐳

*Because who has time to memorize all this stuff, am I right?*

## The Basics - Getting Started

### Images (The Templates)

```bash
# Yoink an image from Docker Hub
docker pull <image_name>:<tag>

# See what images you've hoarded
docker images

# Build your own masterpiece
docker build -t <image_name>:<tag> .

# Nuke an image you don't need
docker rmi <image_id>

# Clean up the mess (unused images)
docker image prune

# Nuclear option - delete EVERYTHING
docker image prune -a
```

### Containers (The Actual Workers)

```bash
# Fire up a container
docker run <image_name>

# Run it in the background (so you can do other stuff)
docker run -d <image_name>

# Expose ports (so people can actually reach your app)
docker run -p <host_port>:<container_port> <image_name>

# Mount some folders (share files like it's 1999)
docker run -v <host_path>:<container_path> <image_name>

# Pass some env vars (because hardcoding is for noobs)
docker run -e ENV_VAR=value <image_name>

# See what's running
docker ps

# See EVERYTHING (including the dead ones)
docker ps -a

# Kill a container (gently)
docker stop <container_id>

# Wake up a dead container
docker start <container_id>

# Turn it off and on again
docker restart <container_id>

# Delete a container (permanently)
docker rm <container_id>

# Force delete (when it won't die peacefully)
docker rm -f <container_id>
```

### Getting Inside Containers (Hacking Time)

```bash
# Jump into a container like you own the place
docker run -it <image_name> /bin/bash

# SSH into a running container (kinda)
docker exec -it <container_id> /bin/bash

# Spy on what your container is doing
docker logs <container_id>

# Watch logs in real-time (like Netflix but for nerds)
docker logs -f <container_id>

# Steal files from container
docker cp <container_id>:/path/to/file /host/path

# Send files to container
docker cp /host/path <container_id>:/path/to/file
```

### Docker Compose (For When You Need Multiple Things)

```bash
# Launch the whole squad
docker-compose up

# Launch in stealth mode (background)
docker-compose up -d

# Shut it all down
docker-compose down

# Rebuild everything and launch (when stuff breaks)
docker-compose up --build

# Check if everyone's alive
docker-compose ps

# See what everyone's talking about
docker-compose logs

# Stalk a specific service
docker-compose logs <service_name>

# Clone your services (scaling like a boss)
docker-compose up --scale <service_name>=3

# Break into a service container
docker-compose exec <service_name> /bin/bash
```

### Networks (Making Containers Talk)

```bash
# See all your networks
docker network ls

# Create a private network (exclusive club)
docker network create <network_name>

# Add container to network (join the party)
docker network connect <network_name> <container_id>

# Kick container out of network
docker network disconnect <network_name> <container_id>

# Get the gossip on a network
docker network inspect <network_name>

# Delete a network (burn the bridge)
docker network rm <network_name>
```

### Volumes (Persistent Storage That Actually Works)

```bash
# List your storage empire
docker volume ls

# Create some storage
docker volume create <volume_name>

# Get the details on your volume
docker volume inspect <volume_name>

# Delete storage (bye bye data)
docker volume rm <volume_name>

# Clean up orphaned volumes
docker volume prune
```

### Cleanup Commands (Marie Kondo for Docker)

```bash
# Remove dead containers
docker container prune

# Remove unused images
docker image prune

# Remove abandoned volumes
docker volume prune

# Remove lonely networks
docker network prune

# The big cleanup (everything unused)
docker system prune

# Nuclear cleanup option (BE CAREFUL!)
docker system prune -a --volumes

# Armageddon mode (removes EVERYTHING)
docker system prune -a --volumes --force
```

### Monitoring & Info (Know Your System)

```bash
# Get Docker's life story
docker info

# Check Docker's version (for bragging rights)
docker version

# See who's eating your resources
docker stats

# Check your disk usage (before your SSD dies)
docker system df

# Deep dive into container details
docker inspect <container_id>

# See what processes are running inside
docker top <container_id>

# Check port mappings (where the magic happens)
docker port <container_id>
```

### Registry Stuff (Sharing is Caring)

```bash
# Login to push your masterpiece
docker login

# Logout (when you're done showing off)
docker logout

# Tag your image for upload
docker tag <image_id> <registry_url>/<image_name>:<tag>

# Push to registry (make it public)
docker push <registry_url>/<image_name>:<tag>

# Search for cool stuff
docker search <search_term>
```

### Real World Examples (Copy-Paste Heaven)

```bash
# Spin up Nginx (because Apache is so 2010)
docker run -d -p 80:80 --name my-nginx nginx

# MySQL for your data hoard
docker run -d -p 3306:3306 --name my-mysql -e MYSQL_ROOT_PASSWORD=password mysql

# Node.js app with live reload (dev life)
docker run -d -p 3000:3000 -v ${PWD}:/app -w /app node:16 npm start

# Redis for when you need things FAST
docker run -d -p 6379:6379 --name my-redis redis

# PostgreSQL (because you're sophisticated)
docker run -d -p 5432:5432 --name my-postgres -e POSTGRES_PASSWORD=password postgres

# MongoDB (for when you like chaos)
docker run -d -p 27017:27017 --name my-mongo mongo

# Temporary Ubuntu playground
docker run -it --rm ubuntu:20.04 /bin/bash
```

### Dockerfile Template (Because Writing From Scratch Sucks)

```dockerfile
# Start with something lightweight (Alpine FTW)
FROM node:16-alpine

# Set your workspace
WORKDIR /app

# Copy the important stuff first (Docker layer caching magic)
COPY package*.json ./

# Install dependencies (pray nothing breaks)
RUN npm install --only=production

# Copy the rest of your code
COPY . .

# Don't run as root (security first, kids)
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
RUN chown -R nextjs:nodejs /app
USER nextjs

# Open the door
EXPOSE 3000

# Health check (because monitoring is cool)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Start the show
CMD ["npm", "start"]
```

### Docker Compose Template (Multi-Container Magic)

```yaml
version: '3.8'

services:
  # Your main app
  web:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db
      - redis
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://user:password@db:5432/myapp
    volumes:
      - ./logs:/app/logs
    restart: unless-stopped

  # Database (because data matters)
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

  # Cache layer (gotta go fast)
  redis:
    image: redis:6-alpine
    restart: unless-stopped

  # Reverse proxy (because you're fancy)
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - web
    restart: unless-stopped

volumes:
  postgres_data:
```

### .dockerignore (Don't Include Your Secrets, Dummy)

```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
.tmp
.DS_Store
*.log
.vscode
.idea
```

## Pro Tips (From Someone Who's Made All The Mistakes)

1. **Multi-stage builds** - Keep your images skinny
2. **Alpine everything** - Smaller = better
3. **Never run as root** - Security isn't optional
4. **Health checks save lives** - Monitor your stuff
5. **Use .dockerignore** - Don't ship your entire hard drive
6. **Pin versions** - "latest" is a lie
7. **docker-compose for everything** - Single containers are lonely
8. **Clean up regularly** - Your disk will thank you
9. **Volumes for data** - Containers die, data shouldn't
10. **Set resource limits** - Don't crash your laptop

### Quick Reference (For When You're Lazy)

```bash
# The "I just want it to work" starter pack
docker run -it --rm alpine:latest sh
docker-compose up -d
docker ps
docker logs -f <container_name>
docker exec -it <container_name> /bin/bash

# The "oh crap everything is broken" emergency kit
docker-compose down
docker system prune -f
docker-compose up --build

# The "I need to ship this yesterday" combo
docker build -t myapp .
docker run -d -p 3000:3000 myapp
docker push myregistry/myapp:latest
```

---

*Made with ☕ and a lot of Stack Overflow. Use at your own risk, but it probably works.*

**P.S.** If this saved you some time, star the repo or buy me a coffee ☕