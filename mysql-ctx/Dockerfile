FROM rockylinux:9.1 AS rockylinux

# change root password
RUN echo -n 'root:MySQL.Labs_4ALL' | chpasswd

# update the system and setup systemd support
RUN dnf update -y; \
    dnf clean all; \
    dnf install systemd systemd-libs initscripts -y

WORKDIR /lib/systemd/system/sysinit.target.wants/

RUN ( for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done ); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    rm -f /usr/lib/tmpfiles.d/systemd-nologin.conf

# setup support for ssh, git and other os utilities and developer tools
RUN mv /etc/localtime /etc/localtime.OLD; \
    ln -s /usr/share/zoneinfo/America/New_York /etc/localtime; \
    dnf install openssh-server openssh-clients sshpass git sudo net-tools iproute which lsof unzip wget jq -y
    # update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1; \
    # dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y; \
    # dnf install bat -y

# setup labs user and group
RUN groupadd labs; \
    useradd --create-home -s /bin/bash -g labs labs; \
    echo -n 'labs:MySQL.Labs_4ALL' | chpasswd; \
    echo 'labs ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/labs; \
    chmod 440 /etc/sudoers.d/labs; \
    mkdir -p /home/labs/.ssh; \
    chmod 700 /home/labs/.ssh; \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== labs insecure public key" > /home/labs/.ssh/authorized_keys; \
    chmod 600 /home/labs/.ssh/authorized_keys; \
    sed -i -e 's/Defaults.*requiretty/#&/' /etc/sudoers; \
    sed -i -e 's/^#UsePAM/UsePAM/g' /etc/ssh/sshd_config; \
    chown -R labs:labs /home/labs; \
    rm -Rf /run/nologin

# initialize ssh
RUN systemctl enable sshd.service; \
    touch /etc/sysconfig/network

# change working dir for root
WORKDIR /root

CMD ["/usr/sbin/init"]