FROM docker:19.03.12 as static-docker-source

FROM google/cloud-sdk:288.0.0-alpine

# Metadata
LABEL maintainer="Juan Miguel <jmiguel.prisma@gmail.com>"

ARG KUBE_LATEST_VERSION="v1.17.8"

ARG HELM_VERSION="v3.2.4"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ARG HELM_URL="https://get.helm.sh/${HELM_ARCHIVE}"

COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
COPY ./configtools.sh /

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$KUBE_LATEST_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L "${HELM_URL}" -o "/tmp/${HELM_ARCHIVE}" \
    && tar -zxvf /tmp/${HELM_ARCHIVE} -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/* \
    && sed -i 's/\r//' /configtools.sh \
    && chmod 744 /configtools.sh

WORKDIR /root

CMD ["/bin/sh"]