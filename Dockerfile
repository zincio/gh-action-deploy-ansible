FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y python3 python3-pip curl bash && \
  rm -rf /var/lib/apt/lists/* 

RUN pip3 install ansible==5.4

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
