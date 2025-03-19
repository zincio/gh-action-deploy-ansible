FROM ubuntu:24.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    ssh python3 python3-pip curl bash \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages ansible==11.3.0 ansible-core==2.18.3

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
