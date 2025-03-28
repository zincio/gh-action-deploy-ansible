FROM ubuntu:24.04

RUN apt-get update && \
  apt-get install -y python3 python3-pip python3-ansible curl bash && \
  rm -rf /var/lib/apt/lists/* 

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]