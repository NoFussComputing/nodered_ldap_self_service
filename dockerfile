FROM --platform=$TARGETPLATFORM python:3.11-bullseye as CloneRepo


RUN export DEBIAN_FRONTEND=noninteractive \
  && dpkg-reconfigure debconf -f noninteractive

RUN apt update \
  && apt install -yq \
    git

RUN git clone --depth=1 -b genesis https://gitlab.com/nofusscomputing/projects/nodered_ldap_self_service.git /tmp/self_service ; ls -l /tmp/self_service


FROM --platform=$TARGETPLATFORM nodered/node-red:3.0.2-18

LABEL \
  # org.opencontainers.image.authors="{contributor url}" \
  org.opencontainers.image.vendor="No Fuss Computing" \
  # org.opencontainers.image.url="{dockerhub url}" \
  # org.opencontainers.image.documentation="{docs url}" \
  # org.opencontainers.image.source="{repo url}" \
  # org.opencontainers.image.revision="{git commit sha at time of build}" \
  org.opencontainers.image.title="No Fuss Computings LDAP Self Service" \
  org.opencontainers.image.description="A NodeRED App for LDAP Self Service" \
  org.opencontainers.image.vendor="No Fuss Computing"
  # org.opencontainers.image.version="{git tag}"

USER root

COPY --from=CloneRepo /tmp/self_service/* /data/

COPY includes/ /

RUN chown node-red:node-red -R /data; \
  chown node-red:node-red -R /usr/src/node-red;

USER node-red

RUN cd /data; \
  npm install package.json

VOLUME [ "/data", "/usr/src/node-red" ]
