ARG REDIS_VERSION=8.0.3
FROM redis:${REDIS_VERSION}-alpine

COPY start-redis-server.sh /usr/bin/start-redis-server.sh
RUN chmod +x /usr/bin/start-redis-server.sh

CMD ["/usr/bin/start-redis-server.sh"]
