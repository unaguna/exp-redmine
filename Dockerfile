FROM debian:bookworm AS builder

RUN apt-get update && apt-get install -y unzip

COPY plugins/*.zip /work/

RUN mkdir /plugins && \
    for f in /work/*.zip; do \
    unzip -q "$f" -d /plugins; \
    done


FROM redmine:6.1.2

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-noto-cjk \
    fontconfig && \
    rm -rf /var/lib/apt/lists/* && \
    fc-cache -fv

COPY --from=builder /plugins /usr/src/redmine/plugins

RUN bundle install

USER redmine