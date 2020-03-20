#!/bin/sh -e

if [[ -n "$REPLICA_ID" ]]; then
    envsubst '$REPLICA_ID' < /template/prometheus.template > /etc/prometheus/prometheus.yml
fi

set -- /bin/prometheus "$@"

exec "$@"