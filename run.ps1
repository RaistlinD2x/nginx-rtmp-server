#Requires -Version 5.0

param(
    [switch]$SkipPrompts,
    [switch]$Help
)

if ($Help) {
    Write-Host "NGINX RTMP Server Setup Wizard" -ForegroundColor Green
    Write-Host "Usage: .\run.ps1 [-SkipPrompts] [-Help]" -ForegroundColor Cyan
    exit 0
}

# Display banner
Write-Host ""
Write-Host "NGINX RTMP Multi-Platform Streaming Server" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "   Stream to YouTube, Twitch, Facebook & TikTok!" -ForegroundColor White
Write-Host ""

# Step 1: Run test setup
Write-Host "Step 1: Checking system requirements..." -ForegroundColor Green
& "$PSScriptRoot\test-setup.ps1"
if ($LASTEXITCODE -ne 0) {
    Write-Host "System requirements check failed." -ForegroundColor Red
    exit 1
}

# Step 2: Configure environment
Write-Host ""
Write-Host "Step 2: Environment Configuration" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

if (-not (Test-Path ".env")) {
    Copy-Item "env.example" ".env"
    Write-Host "Created .env file from template" -ForegroundColor Green
}

if (-not $SkipPrompts) {
    $response = Read-Host "Edit environment file now? (Y/N)"
    if ($response -match "^[Yy]") {
        Write-Host "Opening .env file in Notepad..." -ForegroundColor Yellow
        Write-Host "Please edit your stream keys and save the file." -ForegroundColor Yellow
        notepad .env
        Write-Host ""
        Write-Host "Make sure you have:" -ForegroundColor Cyan
        Write-Host "  - Added your YouTube stream key" -ForegroundColor White
        Write-Host "  - Added your Twitch stream key" -ForegroundColor White
        Write-Host "  - Added your Facebook stream key" -ForegroundColor White
        Write-Host "  - Added your TikTok stream key" -ForegroundColor White
        Write-Host "  - Saved the file" -ForegroundColor White
        Write-Host ""
        Read-Host "Press Enter to continue after saving the .env file"
        
        # Validate that .env file has been configured
        Write-Host "Validating .env file..." -ForegroundColor Yellow
        $envContent = Get-Content ".env" -Raw
        $hasKeys = $false
        
        if ($envContent -match "YOUTUBE_STREAM_KEY=\w+" -or 
            $envContent -match "TWITCH_STREAM_KEY=\w+" -or 
            $envContent -match "FACEBOOK_STREAM_KEY=\w+" -or 
            $envContent -match "TIKTOK_STREAM_KEY=\w+") {
            $hasKeys = $true
        }
        
        if (-not $hasKeys) {
            Write-Host "Warning: No stream keys detected in .env file." -ForegroundColor Yellow
            Write-Host "The server will start but won't stream to any platforms." -ForegroundColor Yellow
            $continueAnyway = Read-Host "Continue anyway? (Y/N)"
            if ($continueAnyway -notmatch "^[Yy]") {
                Write-Host "Setup cancelled. Please edit .env file and run again." -ForegroundColor Yellow
                exit 0
            }
        } else {
            Write-Host ".env file appears to be configured" -ForegroundColor Green
        }
    }
}

# Step 3: Build and start
Write-Host ""
Write-Host "Step 3: Building and Starting Container" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

# Double-check Docker is accessible
Write-Host "Verifying Docker is accessible..." -ForegroundColor Yellow
try {
    $dockerInfo = docker info 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Docker is not accessible. Docker Desktop may not be running." -ForegroundColor Red
        Write-Host ""
        Write-Host "To fix this:" -ForegroundColor Yellow
        Write-Host "1. Start Docker Desktop from the Windows Start menu" -ForegroundColor White
        Write-Host "2. Wait for Docker Desktop to fully start (whale icon should be steady)" -ForegroundColor White
        Write-Host "3. Run this script again" -ForegroundColor White
        Write-Host ""
        Write-Host "Technical error details:" -ForegroundColor Gray
        Write-Host $dockerInfo -ForegroundColor Gray
        exit 1
    }
    Write-Host "Docker is accessible" -ForegroundColor Green
} catch {
    Write-Host "Failed to access Docker: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "Building Docker container..." -ForegroundColor Yellow
$buildOutput = docker-compose build 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed." -ForegroundColor Red
    Write-Host "Error output:" -ForegroundColor Red
    Write-Host $buildOutput -ForegroundColor Red
    exit 1
}
Write-Host "Build completed successfully" -ForegroundColor Green

Write-Host "Starting container..." -ForegroundColor Yellow
$startOutput = docker-compose up -d 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to start container." -ForegroundColor Red
    Write-Host "Error output:" -ForegroundColor Red
    Write-Host $startOutput -ForegroundColor Red
    exit 1
}
Write-Host "Container started successfully" -ForegroundColor Green

# Step 4: Test setup
Write-Host ""
Write-Host "Step 4: Testing Setup" -ForegroundColor Green
Write-Host "====================" -ForegroundColor Green

Start-Sleep -Seconds 5

try {
    $healthResponse = Invoke-WebRequest -Uri "http://localhost:8080/health" -TimeoutSec 10
    if ($healthResponse.Content -eq "OK") {
        Write-Host "Health check passed" -ForegroundColor Green
    }
} catch {
    Write-Host "Health check failed" -ForegroundColor Red
}

# Final instructions
Write-Host ""
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "==================" -ForegroundColor Green
Write-Host ""
Write-Host "OBS Configuration:" -ForegroundColor Cyan
Write-Host "   Stream Type: Custom" -ForegroundColor White
Write-Host "   Server: rtmp://localhost:1935/live" -ForegroundColor White
Write-Host "   Stream Key: obs (or any value)" -ForegroundColor White
Write-Host ""
Write-Host "Monitoring:" -ForegroundColor Cyan
Write-Host "   Health Check: http://localhost:8080/health" -ForegroundColor White
Write-Host "   Status Page: http://localhost:8080/status" -ForegroundColor White
Write-Host ""
Write-Host "Commands:" -ForegroundColor Cyan
Write-Host "   View logs: docker-compose logs -f" -ForegroundColor White
Write-Host "   Stop server: docker-compose down" -ForegroundColor White
Write-Host ""
Write-Host "Ready to stream!" -ForegroundColor Green 