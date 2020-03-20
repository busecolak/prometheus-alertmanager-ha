#!/bin/bash -x

if [[ "$MONITORING" == "true" ]]; then
    cp /router/optional/metrics.conf /etc/nginx/conf.d/
fi

nginx -g "daemon off;"