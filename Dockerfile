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
RUN yum install -y sudo java-1.8.0-openjdk unzip wget java-1.8.0-openjdk-devel which
RUN echo "teamcity ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
VOLUME [ "/sys/fs/cgroup" ]
ADD setup-agent.sh /setup-agent.sh
CMD ["/usr/sbin/init"]
