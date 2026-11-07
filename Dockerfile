FROM ubuntu:24.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    ssh git python3 python3-pip curl bash \
  && rm -rf /var/lib/apt/lists/*

# Same ansible-core as zincio/infra's uv.lock, on the same Python (3.12).
# Collections are not baked in: the entrypoint installs the versions pinned in
# the checked-out repo's requirements.yml, so they always match that commit.
RUN pip3 install --break-system-packages ansible-core==2.16.19

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
