#!/bin/sh

# Substitute environment variables in nginx config template
envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Validate nginx configuration
nginx -t

# Start nginx
exec nginx -g "daemon off;" 