FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y python2 curl bash && \
  rm -rf /var/lib/apt/lists/* 

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
  python2 get-pip.py && \
  pip2 install ansible==2.5.3

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]