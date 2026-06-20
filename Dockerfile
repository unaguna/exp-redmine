FROM debian:bookworm AS builder

RUN apt-get update && apt-get install -y unzip

COPY plugins/ /tmp/plugins/
COPY themes/ /tmp/themes/

RUN mkdir /plugins && \
    find /tmp/plugins -name '*.zip' \
    -exec unzip -q {} -d /plugins \;

RUN mkdir /themes && \
    find /tmp/themes -name '*.zip' \
    -exec unzip -q {} -d /themes \;


FROM redmine:6.1.2

USER root

RUN chown -R redmine: /usr/local/bundle \
    && chmod -R o-w /usr/local/bundle

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    fonts-noto-cjk \
    fontconfig && \
    rm -rf /var/lib/apt/lists/* && \
    fc-cache -fv

COPY --from=builder /plugins /usr/src/redmine/plugins
COPY --from=builder /themes /usr/src/redmine/themes
RUN chown -R redmine /usr/src/redmine/plugins /usr/src/redmine/themes

RUN mkdir -p /home/redmine/.bundle \
    && chown -R redmine:redmine \
    /home/redmine \
    /usr/local/bundle

USER redmine

RUN bundle install