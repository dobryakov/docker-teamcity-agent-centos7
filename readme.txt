docker build --rm -t local/c7-teamcity-agent .
docker run -v $(which docker):/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -t -i local/c7-teamcity-agent bash -l

# in container:
su - teamcity
sudo docker ps

# inside teamcity-agent work dir:
# Dockerfile
FROM phusion/passenger-full:0.9.18
ADD . /home/app/webapp
RUN chown -R app:app /home/app/webapp
WORKDIR /home/app/webapp
CMD ["/sbin/my_init"]
