# NGINX RTMP Multi-Platform Streaming Server

A Docker-based NGINX RTMP server that allows you to stream to multiple platforms simultaneously using OBS Studio.

> 🚀 **New to this project?** Start with [GETTING_STARTED.md](GETTING_STARTED.md) for a quick setup guide!

## Features

- 🚀 **Multi-platform streaming** - Stream to YouTube, Twitch, Facebook, and TikTok simultaneously
- 🔧 **Environment-based configuration** - Easy platform key management via `.env` file
- 🐳 **Docker-based** - Simple deployment and portability
- 📊 **Health monitoring** - Built-in health checks and status endpoints
- ⚡ **Lightweight** - Alpine-based NGINX with RTMP module

## Prerequisites

### 1. Install Docker Desktop

**Download and install Docker Desktop for Windows:**
- Download from: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
- Install and start Docker Desktop
- Wait for the Docker whale icon to be steady in your system tray
- **Important**: Docker Desktop must be running before proceeding with setup

### 2. Get Your Stream Keys

**Before starting, obtain stream keys from each platform you want to stream to:**
- **YouTube Live**: [YouTube Studio](https://studio.youtube.com/) → Go Live → Stream Key
- **Twitch**: [Twitch Dashboard](https://dashboard.twitch.tv/) → Settings → Channel → Stream Key
- **Facebook Live**: [Facebook Live](https://www.facebook.com/live/) → Create Live Video → Stream Key
- **TikTok Live**: TikTok App → Profile → + → Live → Stream Key

> 📖 **Need detailed instructions?** See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md) for step-by-step stream key setup.

## Quick Start

### Option 1: Setup Wizard (Recommended)

```cmd
# Run the interactive setup wizard
run.bat
```

The wizard will:
1. ✅ Check system requirements (Docker, files)
2. 🔧 Help you configure stream keys
3. 🐳 Build and start the container
4. 🧪 Test the setup
5. 📺 Show OBS configuration

### Option 2: Manual Setup

```cmd
# Copy the environment template
copy env.example .env

# Edit .env with your actual stream keys
notepad .env

# Build and start the container
docker-compose up -d

# Check logs
docker-compose logs -f
```

### 3. Configure OBS Studio

- **Stream Type**: Custom
- **Server**: `rtmp://localhost:1935/live`
- **Stream Key**: `obs` (or any value - will be ignored)

## Configuration

### Environment Variables

**Important**: Be sure to get your stream keys from each provider before configuring the `.env` file.

Edit the `.env` file with your streaming platform keys:

```cmd
YOUTUBE_STREAM_KEY=live_123456789_abcdefghijklmnop
TWITCH_STREAM_KEY=live_987654321_zyxwvutsrqponmlk
FACEBOOK_STREAM_KEY=live_555666777_facebookkey123
TIKTOK_STREAM_KEY=live_111222333_tiktokkey456
```

> ⚠️ **Security**: Never share your stream keys publicly and keep your `.env` file secure.

### Adding New Platforms

1. Add your stream key to `.env`:
   ```cmd
   NEW_PLATFORM_KEY=your_key_here
   ```

2. Add the push line to `nginx.conf.template`:
   ```nginx
   push rtmp://new-platform.com/live/${NEW_PLATFORM_KEY};
   ```

3. Restart the container:
   ```cmd
   docker-compose restart
   ```

## Monitoring

### Health Check
- **URL**: `http://localhost:8080/health`
- **Response**: `OK` if server is running

### Status Page
- **URL**: `http://localhost:8080/status`
- **Shows**: NGINX connection statistics

### Container Logs
```cmd
# View logs
docker-compose logs -f nginx-rtmp

# View last 50 lines
docker-compose logs --tail=50 nginx-rtmp
```

## Troubleshooting

### Common Issues

1. **Docker not running**
   ```cmd
   # Error: "docker daemon is not running"
   # Solution: Start Docker Desktop first before proceeding
   # Download Docker here: https://www.docker.com/products/docker-desktop
   ```

2. **Container won't start**
   ```cmd
   # Check logs for errors
   docker-compose logs nginx-rtmp
   
   # Validate configuration
   docker-compose exec nginx-rtmp nginx -t
   ```

3. **Stream not reaching platforms**
   - **Verify your stream keys are correct** - Get fresh keys from each provider
   - Check if platforms are accepting connections
   - Ensure Windows Firewall allows outbound RTMP traffic
   - Verify platform requirements (subscriber/follower counts)

4. **OBS connection issues**
   - Verify container is running: `docker-compose ps`
   - Check port 1935 is accessible: `telnet localhost 1935`
   - Restart OBS Studio

### Debug Commands

```cmd
# Check container status
docker-compose ps

# Access container shell
docker-compose exec nginx-rtmp sh

# View NGINX configuration
docker-compose exec nginx-rtmp cat /etc/nginx/nginx.conf

# Test RTMP endpoint (requires ffmpeg installed)
ffmpeg -i test.mp4 -c copy -f flv rtmp://localhost:1935/live/test
```

## File Structure

```
nginx-rtmp-server/
├── Dockerfile                 # Container definition
├── docker-compose.yml         # Orchestration
├── nginx.conf.template        # NGINX configuration template
├── docker-entrypoint.sh       # Startup script
├── env.example               # Environment template
├── .env                      # Your environment variables (create this)
├── run.bat                   # Setup wizard script (CMD) - START HERE!
├── run.ps1                   # Setup wizard script (PowerShell)
├── test-setup.ps1            # Windows PowerShell test script
├── GETTING_STARTED.md        # Quick setup guide
├── PLATFORM_GUIDE.md         # Stream key setup guide
└── README.md                 # This file
```

## Supported Platforms

- **YouTube Live** - Stream to YouTube Live
- **Twitch** - Stream to Twitch.tv
- **Facebook Live** - Stream to Facebook Live
- **TikTok Live** - Stream to TikTok Live

> 📖 **Need help getting your stream keys?** See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md) for detailed instructions on obtaining stream keys from each platform.

## Development

### Building Locally

```cmd
# Build without cache
docker-compose build --no-cache

# Run in development mode
docker-compose up
```

### Modifying Configuration

1. Edit `nginx.conf.template`
2. Rebuild container: `docker-compose build`
3. Restart: `docker-compose up -d`

## Windows-Specific Notes

### Prerequisites

1. **Docker Desktop for Windows**
   - **Download here**: https://www.docker.com/products/docker-desktop
   - Install and start Docker Desktop before proceeding
   - Ensure WSL 2 is enabled
   - **Important**: Docker Desktop must be running (whale icon steady in system tray)

2. **Stream Keys**
   - **Be sure to get your stream keys from each provider** before running setup
   - See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md) for detailed instructions

3. **Command Prompt or PowerShell**
   - Use Command Prompt (cmd) or PowerShell
   - Run as Administrator if you encounter permission issues

### Windows Firewall

If you encounter connection issues:
1. Open Windows Defender Firewall
2. Allow Docker Desktop through the firewall
3. Ensure port 1935 is not blocked

### File Paths

- Use Windows-style paths: `C:\Users\YourName\Desktop\nginx-rtmp-server`
- Avoid spaces in directory names
- Use forward slashes in Docker commands: `/etc/nginx/nginx.conf`

### Testing Your Setup

Run the PowerShell test script:
```cmd
powershell -ExecutionPolicy Bypass -File test-setup.ps1
```

### Quick Setup Wizard

For a guided setup experience, use the wizard script:

**PowerShell (recommended):**
```cmd
# Interactive wizard
powershell -ExecutionPolicy Bypass -File run.ps1

# Non-interactive setup
powershell -ExecutionPolicy Bypass -File run.ps1 -SkipPrompts

# Show help
powershell -ExecutionPolicy Bypass -File run.ps1 -Help
```

**Command Prompt:**
```cmd
# Interactive wizard
run.bat

# Non-interactive setup
run.bat -SkipPrompts

# Show help
run.bat -Help
```

The wizard will:
1. ✅ Check system requirements
2. 🔧 Configure environment variables
3. 🐳 Build and start the container
4. 🧪 Test the setup
5. 📺 Show OBS configuration

## License

This project is open source and available under the MIT License. 