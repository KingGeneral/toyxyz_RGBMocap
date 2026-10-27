@echo off
setlocal

set "PYTHON_VERSION=3.10"

where py >nul 2>nul
if not errorlevel 1 (
    py -%PYTHON_VERSION% --version >nul 2>nul
    if not errorlevel 1 (
        echo Python %PYTHON_VERSION% is already installed.
        exit /b 0
    )
)

where winget >nul 2>nul
if errorlevel 1 (
    echo Python %PYTHON_VERSION% is required.
    echo winget was not found. Please install Python 3.10 manually:
    echo https://www.python.org/downloads/windows/
    exit /b 1
)

echo Installing Python %PYTHON_VERSION% via winget...
winget install --id Python.Python.3.10 -e --accept-source-agreements --accept-package-agreements
if errorlevel 1 (
    echo Failed to install Python %PYTHON_VERSION% with winget.
    echo Please install Python 3.10 manually:
    echo https://www.python.org/downloads/windows/
    exit /b 1
)

echo Python %PYTHON_VERSION% installation has started.
echo Please reopen this terminal or start a new CMD window before running the venv setup again.
exit /b 0
