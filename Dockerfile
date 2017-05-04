FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN adduser teamcity
RUN yum install -y sudo java-1.8.0-openjdk unzip wget java-1.8.0-openjdk-devel which openssh-clients nano git libtool-ltdl
RUN echo "teamcity ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
VOLUME [ "/sys/fs/cgroup" ]
ADD setup-agent.sh /setup-agent.sh

# prepare id_rsa, id_rsa.pub and known_hosts in the .ssh directory for access to your host/production machine from agent
RUN mkdir -p /home/teamcity/.ssh
ADD .ssh /home/teamcity/.ssh
RUN chmod 700 /home/teamcity/.ssh && chmod 600 /home/teamcity/.ssh/* && chown -R teamcity:teamcity /home/teamcity
# and from inside your teamcity-agent container you will be able to use: ssh -o StrictHostKeyChecking=no user@your-docker-host

# setup docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

CMD ["/usr/sbin/init"]
