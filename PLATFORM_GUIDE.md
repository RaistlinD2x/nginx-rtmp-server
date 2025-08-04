# Platform Stream Key Guide

This guide explains how to obtain stream keys for each of the 4 supported platforms.

## Important Prerequisites

### 1. Install Docker Desktop First
**Before getting your stream keys, make sure Docker Desktop is installed and running:**
- Download from: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
- Install and start Docker Desktop
- Wait for the Docker whale icon to be steady in your system tray
- **Critical**: Docker Desktop must be running before proceeding with setup

### 2. Platform Requirements
**Be sure to get your stream keys from each provider before starting setup:**
- You'll need active accounts on the platforms you want to stream to
- Some platforms have follower/subscriber requirements for live streaming
- Stream keys are platform-specific and should be kept secure

## YouTube Live

### Getting Your Stream Key:
1. Go to [YouTube Studio](https://studio.youtube.com/)
2. Click on **"Go live"** in the left sidebar
3. Fill in your stream details (title, description, etc.)
4. Click **"Create stream"**
5. Your stream key will be displayed in the **"Stream key"** field
6. Copy the entire stream key (starts with `live_`)

### Example:
```
YOUTUBE_STREAM_KEY=live_123456789_abcdefghijklmnopqrstuvwxyz
```

## Twitch

### Getting Your Stream Key:
1. Go to [Twitch Dashboard](https://dashboard.twitch.tv/)
2. Click on **"Settings"** → **"Channel"**
3. Scroll down to **"Stream Key"** section
4. Click **"Show"** to reveal your stream key
5. Copy the entire stream key (starts with `live_`)

### Example:
```
TWITCH_STREAM_KEY=live_987654321_zyxwvutsrqponmlkjihgfedcba
```

## Facebook Live

### Getting Your Stream Key:
1. Go to [Facebook Live](https://www.facebook.com/live/)
2. Click **"Create Live Video"**
3. Choose your destination (Profile, Page, or Group)
4. Fill in your stream details
5. Click **"Go Live"**
6. In the streaming interface, look for **"Stream Key"**
7. Copy the stream key

### Example:
```
FACEBOOK_STREAM_KEY=live_555666777_facebookkey123456789
```

## TikTok Live

### Getting Your Stream Key:
1. Open the **TikTok app** on your phone
2. Go to your **Profile**
3. Tap the **"+"** button to create content
4. Select **"Live"**
5. Fill in your live stream details
6. Tap **"Go Live"**
7. In the live interface, look for **"Stream Key"** or **"Server URL"**
8. Copy the stream key

### Example:
```
TIKTOK_STREAM_KEY=live_111222333_tiktokkey456789
```

## Important Notes

### Security:
- ⚠️ **Never share your stream keys publicly**
- ⚠️ **Keep your .env file secure and don't commit it to version control**
- ⚠️ **Regenerate keys if they get exposed**

### Platform Requirements:
- **YouTube**: Requires 1000+ subscribers for live streaming
- **Twitch**: Requires account verification
- **Facebook**: Requires account verification
- **TikTok**: Requires 1000+ followers for live streaming

### Stream Key Format:
All stream keys typically follow this pattern:
```
live_[numbers]_[random_string]
```

### Testing Your Keys:
1. Add your keys to the `.env` file
2. Start the NGINX RTMP server
3. Configure OBS to stream to `rtmp://localhost:1935/live`
4. Start streaming and check each platform

### Troubleshooting:
- **Invalid Key**: Double-check the key format and ensure no extra spaces
- **Platform Not Receiving**: Verify the platform's live streaming requirements
- **Connection Issues**: Check your internet connection and firewall settings

## Quick Setup

**Before starting, ensure Docker Desktop is running!**

1. **Start Docker Desktop first** (download from link above if not installed)

2. Copy the environment template:
   ```cmd
   copy env.example .env
   ```

3. Get your stream keys from each platform (instructions above)

4. Run the setup wizard:
   ```cmd
   run.bat
   ```
   
   The wizard will help you configure your stream keys and verify everything is working.

5. Start streaming with OBS!

## Support

If you encounter issues:
- Check the main README.md for troubleshooting
- Verify your stream keys are correct
- Ensure your platform accounts meet the live streaming requirements
- Test with a single platform first before multi-streaming 