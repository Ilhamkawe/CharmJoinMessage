# Build and Deploy Script for CharmJoinMessage Plugin
# This script builds the plugin and optionally copies it to the server

param(
    [string]$ServerPluginsPath = "",
    [switch]$Deploy,
    [string]$Configuration = "Release"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "CharmJoinMessage Plugin Builder" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Find MSBuild
$msbuildPaths = @(
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
)

$msbuild = $null
foreach ($path in $msbuildPaths) {
    if (Test-Path $path) {
        $msbuild = $path
        break
    }
}

if ($null -eq $msbuild) {
    Write-Host "ERROR: MSBuild not found!" -ForegroundColor Red
    Write-Host "Please install Visual Studio Build Tools" -ForegroundColor Yellow
    exit 1
}

# Build configuration
$platform = "Any CPU"
$outputDir = "bin\$Configuration"
$dllName = "CharmJoinMessage.dll"
$dllPath = Join-Path $outputDir $dllName

Write-Host "Configuration: $Configuration" -ForegroundColor Yellow
Write-Host "Platform: $platform" -ForegroundColor Yellow
Write-Host ""

# Clean
Write-Host "Cleaning..." -ForegroundColor Yellow
if (Test-Path $outputDir) {
    Remove-Item -Path $outputDir -Recurse -Force
}

# Build
Write-Host "Building..." -ForegroundColor Yellow
$buildArgs = @(
    "CharmJoinMessage.csproj",
    "/p:Configuration=$Configuration",
    "/p:Platform=`"$platform`"",
    "/t:Restore,Build",
    "/p:OutputPath=$outputDir\",
    "/v:minimal",
    "/nologo"
)

$process = Start-Process -FilePath $msbuild -ArgumentList $buildArgs -Wait -NoNewWindow -PassThru

if ($process.ExitCode -ne 0) {
    Write-Host "BUILD FAILED!" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $dllPath)) {
    Write-Host "ERROR: DLL not found at $dllPath" -ForegroundColor Red
    exit 1
}

$fileInfo = Get-Item $dllPath
Write-Host ""
Write-Host "BUILD SUCCESSFUL!" -ForegroundColor Green
Write-Host "Output: $dllPath" -ForegroundColor Green
Write-Host "Size: $([math]::Round($fileInfo.Length / 1KB, 2)) KB" -ForegroundColor Gray
Write-Host ""

# Deploy if requested
if ($Deploy) {
    if ([string]::IsNullOrWhiteSpace($ServerPluginsPath)) {
        Write-Host "ERROR: ServerPluginsPath is required when using -Deploy" -ForegroundColor Red
        Write-Host "Usage: .\build-and-deploy.ps1 -Deploy -ServerPluginsPath 'C:\Path\To\Plugins'" -ForegroundColor Yellow
        exit 1
    }

    if (-not (Test-Path $ServerPluginsPath)) {
        Write-Host "ERROR: Server plugins path does not exist: $ServerPluginsPath" -ForegroundColor Red
        exit 1
    }

    $targetPath = Join-Path $ServerPluginsPath $dllName
    Write-Host "Deploying to: $targetPath" -ForegroundColor Yellow
    
    Copy-Item -Path $dllPath -Destination $targetPath -Force
    Write-Host "Deployed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "You may need to reload the plugin:" -ForegroundColor Cyan
    Write-Host "  /rocket reload CharmJoinMessage" -ForegroundColor White
}

Write-Host "Done!" -ForegroundColor Green

