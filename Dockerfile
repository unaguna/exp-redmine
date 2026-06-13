FROM redmine:6.1.2

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-noto-cjk \
    fontconfig && \
    rm -rf /var/lib/apt/lists/* && \
    fc-cache -fv

USER redmine