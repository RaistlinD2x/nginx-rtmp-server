@echo off
echo.
echo NGINX RTMP Multi-Platform Streaming Server
echo ===============================================
echo Stream to YouTube, Twitch, Facebook and TikTok!
echo.
echo Starting setup wizard...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0run.ps1" %*

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Setup failed. Check the errors above.
    pause
    exit /b 1
)

echo.
echo Setup completed successfully!
pause 