FROM alpine:latest

# Install kiwix-serve
WORKDIR /
RUN apk add --no-cache curl bzip2 bash
RUN curl -kL https://download.kiwix.org/release/kiwix-tools/kiwix-tools_linux-x86_64-3.0.1-6.tar.gz | tar -xz && \
    mv kiwix-tools*/* /usr/local/bin && \
    rm -r kiwix-tools*

COPY bootstrap.sh /usr/local/bin/

EXPOSE 80

VOLUME /data
WORKDIR /data

ENV ZIMS="ai.stackexchange.com_en_all.zim,astronomy.stackexchange.com_en_all.zim"

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]

CMD ["/usr/local/bin/kiwix-serve", "--port", "80", "--library", "library-zim.xml"]
