docker build --rm -t local/c7-teamcity-agent .
docker run -v $(which docker):/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -t -i local/c7-teamcity-agent bash -l

# in container:
su - teamcity
sudo docker ps
