@echo off
REM Build script for CharmJoinMessage Plugin
REM This script builds the plugin using MSBuild

echo ========================================
echo Building CharmJoinMessage Plugin
echo ========================================
echo.

REM Check if MSBuild is available
where msbuild >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: MSBuild not found in PATH
    echo Please install Visual Studio Build Tools or add MSBuild to PATH
    echo MSBuild is usually located at:
    echo C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe
    echo.
    pause
    exit /b 1
)

REM Set build configuration
set CONFIGURATION=Release
set PLATFORM=Any CPU
set OUTPUT_DIR=bin\%CONFIGURATION%

echo Configuration: %CONFIGURATION%
echo Platform: %PLATFORM%
echo Output Directory: %OUTPUT_DIR%
echo.

REM Clean previous build
echo Cleaning previous build...
if exist "%OUTPUT_DIR%" rmdir /s /q "%OUTPUT_DIR%"
echo.

REM Build the project
echo Building project...
msbuild CharmJoinMessage.csproj /p:Configuration=%CONFIGURATION% /p:Platform="%PLATFORM%" /t:Restore,Build /p:OutputPath=%OUTPUT_DIR%\ /v:minimal

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
    pause
    exit /b 1
)

echo.
echo ========================================
echo BUILD SUCCESSFUL!
echo ========================================
echo.
echo Output files:
if exist "%OUTPUT_DIR%\CharmJoinMessage.dll" (
    echo   - %OUTPUT_DIR%\CharmJoinMessage.dll
    dir "%OUTPUT_DIR%\CharmJoinMessage.dll" | find "CharmJoinMessage.dll"
)
if exist "%OUTPUT_DIR%\CharmJoinMessage.pdb" (
    echo   - %OUTPUT_DIR%\CharmJoinMessage.pdb
)
echo.
echo Plugin DLL is ready to be copied to your Rocket.Unturned plugins folder!
echo.
pause

