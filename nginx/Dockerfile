FROM nginx:1.17.6-alpine AS builder

ENV NGINX_VERSION 1.17.6

WORKDIR /tmp

RUN apk add --no-cache --virtual .build-deps \
  gcc \
  libc-dev \
  make \
  openssl-dev \
  pcre-dev \
  zlib-dev \
  linux-headers \
  curl \
  gnupg \
  libxslt-dev \
  gd-dev \
  geoip-dev \
  git 

RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O nginx.tar.gz && \ 
    git clone git://github.com/vozlt/nginx-module-vts.git 

RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
	tar -zxC /tmp -f nginx.tar.gz && \
  MDLVTSDIR="$(pwd)/nginx-module-vts" && \
  cd $(pwd)/nginx-$NGINX_VERSION && \
  ./configure --with-compat $CONFARGS --add-dynamic-module=$MDLVTSDIR && \
  make && make install

FROM nginx:1.17.6-alpine

COPY --from=builder /usr/local/nginx/modules/ngx_http_vhost_traffic_status_module.so /etc/nginx/modules/

ENV MONITORING "false"

VOLUME /etc/nginx

EXPOSE 80
EXPOSE 9913

COPY config/ /etc/nginx/
COPY html/* /usr/share/nginx/html/
COPY optional/ /router/optional/
COPY start_nginx.sh /router/

RUN apk add --no-cache bash curl

CMD ["/router/start_nginx.sh"]