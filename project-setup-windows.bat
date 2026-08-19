@echo off

set all_good=1

for /F "delims=" %%E in ('echo prompt $E^| cmd') do set "ESC=%%E"

where node >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "delims=" %%v in ('node --version') do echo %ESC%[32m[v]%ESC%[0m node installation is found:%ESC%[36m %%v%ESC%[0m
) else (
	echo %ESC%[31m[x]%ESC%[0m node is not found
	set all_good=0
)

where npm >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "delims=" %%v in ('npm --version') do echo %ESC%[32m[v]%ESC%[0m npm installation is found:%ESC%[36m %%v%ESC%[0m
) else (
    echo %ESC%[31m[x]%ESC%[0m npm is not found
	set all_good=0
)

if %all_good% EQU 0 (
	echo %ESC%[31mFailure:%ESC%[0m Missing or incomplete node.js setup!%ESC%[0m
	echo Please, make sure that you have properly proceeded with installing %ESC%[36mnode%ESC%[0m and %ESC%[36mnpm%ESC%[0m before running the script:%ESC%[36m https://nodejs.org/en %ESC%[0m
	exit 1
)

cd node-scripts

call npm ci

if errorlevel 1 (
    echo %ESC%[31m[x]%ESC%[0m npm ci failed with exit code %errorlevel%
	cd ..; exit /b %errorlevel%
)

call npm run regen

if errorlevel 1 (
    echo %ESC%[31m[x]%ESC%[0m npm regen process failed with exit code %errorlevel%
	cd ..; exit /b %errorlevel%
)

cd ..