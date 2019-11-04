ARG BASE="alpine:latest"
FROM ${BASE}

ARG ARCH="x86_64"
ARG VERSION="3.0.1-6"

ENV ZIMS="ai.stackexchange.com_en_all.zim,astronomy.stackexchange.com_en_all.zim"
ENV BOOTSTRAP=1

# Install kiwix-serve
WORKDIR /
RUN apk add --no-cache curl bzip2 bash
RUN curl -kL https://download.kiwix.org/release/kiwix-tools/kiwix-tools_linux-${ARCH}-${VERSION}.tar.gz | tar -xz && \
    mv kiwix-tools*/* /usr/local/bin && \
    rm -r kiwix-tools*

COPY bootstrap.sh /usr/local/bin/

EXPOSE 80

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]

CMD ["/usr/local/bin/kiwix-serve", "--port", "80", "--library", "library-zim.xml"]
