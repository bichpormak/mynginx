FROM alpine:latest

RUN apk add --no-cache nginx && \
    addgroup -S nginx && \
    adduser -S -G nginx nginx || true && \
    mkdir -p /usr/share/nginx/html /var/cache/nginx /var/run && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /usr/share/nginx /var/cache/nginx /var/run/nginx.pid && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

USER nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]