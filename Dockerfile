FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    nginx \
    nginx-mod-rtmp \
    gettext

# Load RTMP module
RUN echo "load_module /usr/lib/nginx/modules/ngx_rtmp_module.so;" > /etc/nginx/modules/rtmp.conf

# Copy configuration template
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Create necessary directories (nginx user already exists)
RUN mkdir -p /var/log/nginx /var/cache/nginx /run/nginx && \
    chown -R nginx:nginx /var/log/nginx /var/cache/nginx /run/nginx

EXPOSE 1935 8080
ENTRYPOINT ["/docker-entrypoint.sh"] 