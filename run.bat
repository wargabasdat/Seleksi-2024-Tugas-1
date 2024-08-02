@echo off

REM Open Docker Desktop
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

REM Wait for Docker to start completely
echo Waiting for Docker Desktop to start...
:waitLoop
timeout /t 5 >nul
docker info >nul 2>&1
if errorlevel 1 (
    echo Docker is not running yet...
    goto waitLoop
)

echo Docker is running.

REM Navigate to your docker-compose directory
cd /d D:\Github\basdat_temp

REM Run docker-compose up
docker-compose up -d

REM Wait a few seconds to ensure services are up
timeout /t 25

REM Run your first Go application
cd /d D:\Github\basdat_temp\Data Scraping\src\main
go run scraper.go

REM Run your second Go application
cd /d D:\Github\basdat_temp\Data Storing\export
go run dbms.go
