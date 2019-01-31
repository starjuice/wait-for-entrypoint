#!/bin/sh -e
#
# https://github.com/starjuice/wait-for-entrypoint
#
# WAIT_FOR_SERVICES      - Space-delimited list of host:port TCP services.
#                          E.g. webserver:443 or 10.0.0.4:80.
# WAIT_FOR_VERBOSE       - If "1", print message to stdout for each service.
# WAIT_FOR_AS_ENTRYPOINT - Unless "0", act as docker entrypoint for command-line
#                          arguments.
#

for service in ${WAIT_FOR_SERVICES}; do
	host=${service%:*}
	port=${service#*:}
	if [ "${WAIT_FOR_VERBOSE}" = "1" ]; then
		echo Waiting for ${host}:${port}...
	fi
	if which nc >/dev/null 2>&1; then
		nc $host $port
	elif [ -x /bin/bash ]; then
		/bin/bash -c "echo > /dev/tcp/${host}/${port}"
	else
		echo $(basename $0): error: neither bash nor nc are available 1>&2
		exit 1
	fi
done

if [ "${WAIT_FOR_AS_ENTRYPOINT}" != "0" ]; then
	exec "$@"
fi
