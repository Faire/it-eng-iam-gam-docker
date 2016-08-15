FROM alpine:3.2

ENV GAM_VERSION=3.65

ADD gam-runner.sh /usr/bin/gam.sh

RUN apk update && \
    apk add bash python py-crypto py-openssl py-pip wget && \
    pip install -U pip && \
    pip install -U six && \
    mkdir /gam && \
    cd /tmp && \
    wget --no-check-certificate https://github.com/jay0lee/GAM/archive/v$GAM_VERSION.tar.gz && \
    tar -C /gam -zxf /tmp/v$GAM_VERSION.tar.gz && \
    cd /gam && mv GAM-${GAM_VERSION}/* . && \
    touch /gam/src/nobrowser.txt /gam/src/noupdatecheck.txt && \
    rm -rf /gam/GAM-${GAM_VERSION} && \
    chmod 0755 /usr/bin/gam.sh && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

WORKDIR /gam

ENTRYPOINT [ "/usr/bin/gam.sh" ]

CMD [ "--help" ]

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/broadinstitute/docker-gam"
