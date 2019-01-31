# wait-for-entrypoint

Docker entrypoint script that waits for services.

Usage:

```
FROM ruby:2.3

ADD https://github.com/starjuice/wait-for-entrypoint/blob/master/wait-for-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh
CMD /bin/bash -c "Hello, world!"
```

The script is configured with the following environment variables:

* `WAIT_FOR_SERVICES`      - Space-delimited list of host:port TCP services. E.g. webserver:443 or 10.0.0.4:80.
* `WAIT_FOR_AS_ENTRYPOINT` - Unless "0", act as docker entrypoint for command-line arguments.
* `WAIT_FOR_VERBOSE`       - If "1", print message to stdout for each service.
