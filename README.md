# wait-for-entrypoint

Docker entrypoint script that waits for services.

It's a Bourne shell script, intended for use as a Docker ENTRYPOINT.
It waits for a configured list of services to become available before handing over to the Docker CMD.
It requires either nc or bash and operates as follows:

* If `nc` is available, `nc` is used to test service availability.
* If `bash` is available, `bash` is used to test service availability.
* If neither is available, execution is interrupted.

The script is configured with the following environment variables:

* `WAIT_FOR_SERVICES`      - Space-delimited list of host:port TCP services. E.g. webserver:443 or 10.0.0.4:80.
* `WAIT_FOR_VERBOSE`       - If "1", print message to stdout for each service.
* `WAIT_FOR_AS_ENTRYPOINT` - Unless "0", act as docker entrypoint for command-line arguments.

## Example

Example `Dockerfile`:

```
FROM alpine:3.9

ADD https://raw.githubusercontent.com/starjuice/wait-for-entrypoint/master/wait-for-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [ "/bin/echo", "Hello, world!" ]
```

Example `docker-compose.yml`:

```
version: '3'

services:
  web:
    image: httpd:2.4
  client:
    build: .
    environment:
      WAIT_FOR_SERVICES: web:80
      WAIT_FOR_VERBOSE: 1
    links:
      - web
```

