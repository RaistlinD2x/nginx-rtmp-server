# Getting Started - NGINX RTMP Multi-Platform Streaming Server

## Before You Begin

### Step 1: Install Docker Desktop
**This is required and must be done first!**

1. **Download Docker Desktop for Windows:**
   - Go to: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
   - Download and install Docker Desktop
   - **Start Docker Desktop** and wait for it to fully load
   - Look for the Docker whale icon in your system tray - it should be steady (not blinking)

### Step 2: Get Your Stream Keys
**Be sure to get your stream keys from each provider before proceeding!**

You'll need stream keys from the platforms you want to stream to:

- **YouTube Live**: [YouTube Studio](https://studio.youtube.com/) → Go Live → Stream Key
- **Twitch**: [Twitch Dashboard](https://dashboard.twitch.tv/) → Settings → Channel → Stream Key  
- **Facebook Live**: [Facebook Live](https://www.facebook.com/live/) → Create Live Video → Stream Key
- **TikTok Live**: TikTok App → Profile → + → Live → Stream Key

> 📖 **Need help?** See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md) for detailed step-by-step instructions.

## Quick Setup (Recommended)

### Option 1: Use the Setup Wizard

1. **Double-click `run.bat`** or run in Command Prompt:
   ```cmd
   run.bat
   ```

2. **Follow the wizard:**
   - ✅ It will check your system requirements
   - 🔧 Help you configure your stream keys
   - 🐳 Build and start the container
   - 🧪 Test everything is working
   - 📺 Show you how to configure OBS

### Option 2: Manual Setup

1. **Copy environment template:**
   ```cmd
   copy env.example .env
   ```

2. **Edit with your stream keys:**
   ```cmd
   notepad .env
   ```

3. **Build and start:**
   ```cmd
   docker-compose up -d
   ```

## Configure OBS Studio

Once the server is running, configure OBS:

- **Stream Type**: Custom
- **Server**: `rtmp://localhost:1935/live`
- **Stream Key**: `obs` (or any value)

## Verify Everything is Working

1. **Check the server is running:**
   ```cmd
   docker-compose ps
   ```

2. **View server logs:**
   ```cmd
   docker-compose logs -f
   ```

3. **Test health endpoint:**
   - Open browser to: [http://localhost:8080/health](http://localhost:8080/health)
   - Should show: "OK"

## Start Streaming!

1. Start your stream in OBS
2. Check each platform to verify your stream is appearing
3. Monitor logs for any connection issues

## Need Help?

- **System Requirements Issues**: Check [README.md](README.md) troubleshooting section
- **Stream Key Setup**: See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md)
- **Docker Problems**: Make sure Docker Desktop is running first
- **Platform Issues**: Verify your stream keys are correct and accounts meet platform requirements

## Common Issues

### "Docker daemon is not running"
- **Solution**: Start Docker Desktop first
- **Download**: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)

### "Stream not appearing on platforms"
- **Solution**: Double-check your stream keys are correct
- **Tip**: Get fresh keys from each platform to ensure they're valid

### "Container won't start"
- **Solution**: Check logs with `docker-compose logs`
- **Common cause**: Invalid characters in stream keys

That's it! You should now be streaming to multiple platforms simultaneously.