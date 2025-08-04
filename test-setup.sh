#!/bin/bash

echo "🧪 NGINX RTMP Server Setup Test"
echo "================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "⚠️  .env file not found. Creating from template..."
    cp env.example .env
    echo "📝 Please edit .env file with your actual stream keys"
    echo "   nano .env"
else
    echo "✅ .env file exists"
fi

# Check if all required files exist
required_files=("Dockerfile" "docker-compose.yml" "nginx.conf.template" "docker-entrypoint.sh")
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file is missing"
        exit 1
    fi
done

echo ""
echo "🚀 Ready to build and run!"
echo "Run: docker-compose up -d"
echo "Check logs: docker-compose logs -f"
echo ""
echo "📺 OBS Configuration:"
echo "   Stream Type: Custom"
echo "   Server: rtmp://localhost:1935/live"
echo "   Stream Key: obs (or any value)" 