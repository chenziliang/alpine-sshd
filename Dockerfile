FROM anapsix/alpine-java:8_jdk

RUN apk update && apk upgrade && apk add git && apk add openssh && apk add curl && rm -rf /var/cache/apk/*
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
ADD sshd_config /etc/ssh/sshd_config
RUN mkdir -p /root/.ssh && echo -e 'Host *\n    StrictHostKeyChecking no\n    UserKnownHostsFile=/dev/null' > /root/.ssh/config && chmod 400 /root/.ssh/config

RUN mkdir -p /var/run/sshd

CMD ["/usr/sbin/sshd", "-D"]
