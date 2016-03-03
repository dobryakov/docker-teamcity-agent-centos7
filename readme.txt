# build container

docker build --rm -t local/c7-teamcity-agent .

# run once, only for testing purposes:

docker run -v $(which docker):/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -t -i local/c7-teamcity-agent bash -l

# inside container you should see working containers from your host machine:
su - teamcity
sudo docker ps

# in real environment use https://github.com/dobryakov/docker-compose-teamcity

# put Dockerfile inside teamcity-agent work dir:
FROM phusion/passenger-full:0.9.18
ADD . /home/app/webapp
RUN chown -R app:app /home/app/webapp
WORKDIR /home/app/webapp
CMD ["/sbin/my_init"]

# setup teamcity server and agent, add build steps:
sudo docker build --rm -t local/ttt .
sudo docker run -d -t --name teamcity-test -i local/ttt
sudo docker exec -t -u root teamcity-test bundle install
sudo docker exec -t -u app teamcity-test rake test
