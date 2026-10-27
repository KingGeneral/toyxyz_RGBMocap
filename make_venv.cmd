@echo off
cd /d "%~dp0"

if exist .venv_ready (
    echo Virtual environment already installed and ready.
    if exist venv\Scripts\activate.bat (
        call "%~dp0venv\Scripts\activate.bat"
    )
    exit /b 0
)

where py >nul 2>nul
if errorlevel 1 (
    echo Python launcher "py" was not found.
    exit /b 1
)

py -3.10 --version >nul 2>nul
if errorlevel 1 (
    echo Python 3.10 is required.
    exit /b 1
)

if not exist venv\Scripts\python.exe (
    echo Creating venv with Python 3.10...
    py -3.10 -m venv venv
)

if not exist venv\Scripts\activate.bat (
    echo Virtual environment activation script not found.
    exit /b 1
)

call "%~dp0venv\Scripts\activate.bat"
echo Checking venv...
python --version
python -m pip --version
if errorlevel 1 (
    echo venv is not working.
    exit /b 1
)

echo venv is working. Installing packages...
python -m pip install --upgrade pip
python -m pip install -r requirements-windows.txt

type NUL > .venv_ready
echo Virtual environment installed successfully.
exit /b %ERRORLEVEL%
