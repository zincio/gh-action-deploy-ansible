FROM ubuntu:24.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    ssh python3 python3-pip curl bash \
  && rm -rf /var/lib/apt/lists/*

RUN PIP_BREAK_SYSTEM_PACKAGES=1 pip3 install ansible==9.4

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
