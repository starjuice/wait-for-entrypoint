FROM alpine:3.9

ADD https://raw.githubusercontent.com/starjuice/wait-for-entrypoint/v0.1.0/wait-for-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [ "/bin/echo", "Hello, world!" ]
