Write-Host "NGINX RTMP Server Setup Test" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green

# Check if Docker is installed
try {
    $dockerVersion = docker --version 2>$null
    if ($dockerVersion) {
        Write-Host "Docker is installed: $dockerVersion" -ForegroundColor Green
    } else {
        throw "Docker not found"
    }
} catch {
    Write-Host "Docker is not installed or not running." -ForegroundColor Red
    Write-Host "   Please install Docker Desktop for Windows from:" -ForegroundColor Yellow
    Write-Host "   https://www.docker.com/products/docker-desktop" -ForegroundColor Cyan
    Write-Host "   Make sure Docker Desktop is running before continuing." -ForegroundColor Yellow
    exit 1
}

# Check if Docker Compose is installed
try {
    $composeVersion = docker-compose --version 2>$null
    if ($composeVersion) {
        Write-Host "Docker Compose is installed: $composeVersion" -ForegroundColor Green
    } else {
        throw "Docker Compose not found"
    }
} catch {
    Write-Host "Docker Compose is not installed." -ForegroundColor Red
    Write-Host "   Docker Compose should be included with Docker Desktop." -ForegroundColor Yellow
    exit 1
}

# Check if Docker is running
try {
    docker info 2>$null | Out-Null
    Write-Host "Docker is running" -ForegroundColor Green
} catch {
    Write-Host "Docker is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-Host ".env file not found. Creating from template..." -ForegroundColor Yellow
    if (Test-Path "env.example") {
        Copy-Item "env.example" ".env"
        Write-Host "Created .env file from template" -ForegroundColor Green
        Write-Host "Please edit .env file with your actual stream keys:" -ForegroundColor Cyan
        Write-Host "   notepad .env" -ForegroundColor Cyan
    } else {
        Write-Host "env.example template not found!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host ".env file exists" -ForegroundColor Green
}

# Check if all required files exist
$requiredFiles = @("Dockerfile", "docker-compose.yml", "nginx.conf.template", "docker-entrypoint.sh")
$missingFiles = @()

foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "$file exists" -ForegroundColor Green
    } else {
        Write-Host "$file is missing" -ForegroundColor Red
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "Missing required files: $($missingFiles -join ', ')" -ForegroundColor Red
    Write-Host "   Please ensure all project files are present." -ForegroundColor Yellow
    exit 1
}

# Check if we're in the right directory (should contain Dockerfile)
if (-not (Test-Path "Dockerfile")) {
    Write-Host "Dockerfile not found in current directory." -ForegroundColor Red
    Write-Host "   Please run this script from the nginx-rtmp-server directory." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "All checks passed! Your environment is ready." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "   1. Edit your .env file with stream keys: notepad .env" -ForegroundColor White
Write-Host "   2. Build and start: docker-compose up -d" -ForegroundColor White
Write-Host "   3. Check logs: docker-compose logs -f" -ForegroundColor White
Write-Host ""
Write-Host "OBS Configuration:" -ForegroundColor Yellow
Write-Host "   Stream Type: Custom" -ForegroundColor White
Write-Host "   Server: rtmp://localhost:1935/live" -ForegroundColor White
Write-Host "   Stream Key: obs (or any value)" -ForegroundColor White
Write-Host ""
Write-Host "Monitoring:" -ForegroundColor Cyan
Write-Host "   Health Check: http://localhost:8080/health" -ForegroundColor White
Write-Host "   Status Page: http://localhost:8080/status" -ForegroundColor White

# Exit successfully
exit 0 