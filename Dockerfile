FROM nginx:alpine

# Install RTMP module
RUN apk add --no-cache \
    nginx-mod-rtmp

# Copy configuration template
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 1935 8080
ENTRYPOINT ["/docker-entrypoint.sh"] 