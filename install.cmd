@echo off
setlocal
cd /d "%~dp0"

call "%~dp0make_venv.cmd"
if errorlevel 1 (
    echo Failed to prepare the local Python virtual environment.
    exit /b %ERRORLEVEL%
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\git_bootstrap.ps1" %*
set "result=%ERRORLEVEL%"
if not "%result%"=="0" echo Installation failed. See the message above; rerun install.cmd to retry.
if "%~1"=="" pause
exit /b %result%
