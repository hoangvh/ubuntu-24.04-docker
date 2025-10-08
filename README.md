# Ubuntu 24.04 Docker Setup

This guide explains how to **build and run a Docker container** for Ubuntu 24.04 and mount your local build directory into the container. It also covers running a shell inside the container as root.

---

## 1. Build the Docker Image

Make sure you have a `Dockerfile` in your project directory. Then run:

```bash
docker build -t ubuntu24.04 .
```
## 2. Run the Container
```
docker run -d \
  --name ubuntu24.04 \
  --privileged \
  -v /home/ubuntu-24.04/build:/root/build \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /dev:/dev \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -w /root/build \
  ubuntu24.04 \
  tail -f /dev/null
```

### Explanation:
- --name ubuntu24.04: Name of the container.
- --privileged: Gives extended privileges to the container.
- -v /home/ubuntu-24.04/build:/root/build: Mounts your local build directory.
- -v /var/run/docker.sock:/var/run/docker.sock: Allows Docker-in-Docker operations.
- -v /dev:/dev: Pass through host devices.
- -v /etc/localtime:/etc/localtime:ro and -v /etc/timezone:/etc/timezone:ro: Synchronize timezone.
- -w /root/build: Set working directory inside container.
- tail -f /dev/null: Keeps container running in the background.
  
## 3. Access the Container
```
docker exec -it -u0 ubuntu24.04 bash
```
