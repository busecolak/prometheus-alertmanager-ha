FROM prom/prometheus:v2.14.0 AS builder

FROM alpine:3.9.5
COPY --from=builder /bin/prometheus /bin/prometheus
COPY --from=builder /bin/promtool /bin/promtool
COPY --from=builder /etc/prometheus /etc/prometheus
COPY --from=builder /usr/share/prometheus/console_libraries/ /usr/share/prometheus/console_libraries/
COPY --from=builder /usr/share/prometheus/consoles/ /usr/share/prometheus/consoles/
COPY --from=builder /LICENSE /LICENSE
COPY --from=builder /NOTICE /NOTICE
COPY --from=builder /npm_licenses.tar.bz2 /npm_licenses.tar.bz2

COPY config/prometheus.template /template/
COPY start_prometheus.sh /

EXPOSE 9090

VOLUME [ "/prometheus" ]
WORKDIR /prometheus

RUN apk add --no-cache bash gettext

ENTRYPOINT ["/start_prometheus.sh"]
CMD [ "--config.file=/etc/prometheus/prometheus.yml", \
    "--storage.tsdb.path=/prometheus", \
    "--web.console.libraries=/usr/share/prometheus/console_libraries", \
    "--web.console.templates=/usr/share/prometheus/consoles" ]