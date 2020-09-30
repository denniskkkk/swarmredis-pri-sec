FROM redis:6.0.6
USER root
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
#RUN groupadd -r redis && useradd -r -g redis redis
# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -yqq \
      redis \
      net-tools locales procps\
      gettext-base wget vim curl && \
    apt-get clean -yqq

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
COPY ./data/config.sh /config.sh
RUN mkdir /redis-conf; \
    chown redis.redis -Rv /redis-conf ; \
    mkdir /redis-data; \
    chown redis.redis -Rv /redis-data; \
    /config.sh
     

COPY ./data/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh
VOLUME /redis-data

EXPOSE 6379
EXPOSE 6380
EXPOSE 16379
EXPOSE 16380
#USER redis:redis
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["redis-cluster"]
