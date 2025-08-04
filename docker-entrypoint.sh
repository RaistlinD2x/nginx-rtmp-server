#!/bin/sh

# Create a working nginx config by replacing entire URLs when keys are not configured
cp /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf

# If no real stream keys are provided, replace with localhost URLs
if [ -z "$YOUTUBE_STREAM_KEY" ] || [ "$YOUTUBE_STREAM_KEY" = "KEY_HERE" ]; then
    sed -i 's|push rtmp://a.rtmp.youtube.com/live2/${YOUTUBE_STREAM_KEY};|# push rtmp://localhost:1936/disabled;|g' /etc/nginx/nginx.conf
else
    sed -i "s|\${YOUTUBE_STREAM_KEY}|$YOUTUBE_STREAM_KEY|g" /etc/nginx/nginx.conf
fi

if [ -z "$TWITCH_STREAM_KEY" ] || [ "$TWITCH_STREAM_KEY" = "KEY_HERE" ]; then
    sed -i 's|push rtmp://live.twitch.tv/app/${TWITCH_STREAM_KEY};|# push rtmp://localhost:1936/disabled;|g' /etc/nginx/nginx.conf
else
    sed -i "s|\${TWITCH_STREAM_KEY}|$TWITCH_STREAM_KEY|g" /etc/nginx/nginx.conf
fi

if [ -z "$FACEBOOK_STREAM_KEY" ] || [ "$FACEBOOK_STREAM_KEY" = "KEY_HERE" ]; then
    sed -i 's|push rtmp://live-api-s.facebook.com/rtmp/${FACEBOOK_STREAM_KEY};|# push rtmp://localhost:1936/disabled;|g' /etc/nginx/nginx.conf
else
    sed -i "s|\${FACEBOOK_STREAM_KEY}|$FACEBOOK_STREAM_KEY|g" /etc/nginx/nginx.conf
fi

if [ -z "$TIKTOK_STREAM_KEY" ] || [ "$TIKTOK_STREAM_KEY" = "KEY_HERE" ]; then
    sed -i 's|push rtmp://live-push.tiktok.com/live/${TIKTOK_STREAM_KEY};|# push rtmp://localhost:1936/disabled;|g' /etc/nginx/nginx.conf
else
    sed -i "s|\${TIKTOK_STREAM_KEY}|$TIKTOK_STREAM_KEY|g" /etc/nginx/nginx.conf
fi

# Start nginx
exec nginx -g "daemon off;" 