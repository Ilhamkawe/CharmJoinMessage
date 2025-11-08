# PowerShell Build Script for CharmJoinMessage Plugin
# This script builds the plugin using MSBuild

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Building CharmJoinMessage Plugin" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Find MSBuild
$msbuildPaths = @(
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
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
    Write-Host "Please install Visual Studio Build Tools or Visual Studio" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Using MSBuild: $msbuild" -ForegroundColor Green
Write-Host ""

# Set build configuration
$configuration = "Release"
$platform = "Any CPU"
$outputDir = "bin\$configuration"

Write-Host "Configuration: $configuration" -ForegroundColor Yellow
Write-Host "Platform: $platform" -ForegroundColor Yellow
Write-Host "Output Directory: $outputDir" -ForegroundColor Yellow
Write-Host ""

# Clean previous build
Write-Host "Cleaning previous build..." -ForegroundColor Yellow
if (Test-Path $outputDir) {
    Remove-Item -Path $outputDir -Recurse -Force
}
Write-Host ""

# Build the project
Write-Host "Building project..." -ForegroundColor Yellow
$buildArgs = @(
    "CharmJoinMessage.csproj",
    "/p:Configuration=$configuration",
    "/p:Platform=`"$platform`"",
    "/t:Restore,Build",
    "/p:OutputPath=$outputDir\",
    "/v:minimal",
    "/nologo"
)

$process = Start-Process -FilePath $msbuild -ArgumentList $buildArgs -Wait -NoNewWindow -PassThru

if ($process.ExitCode -ne 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "BUILD FAILED!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "BUILD SUCCESSFUL!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Show output files
Write-Host "Output files:" -ForegroundColor Cyan
$dllPath = Join-Path $outputDir "CharmJoinMessage.dll"
$pdbPath = Join-Path $outputDir "CharmJoinMessage.pdb"

if (Test-Path $dllPath) {
    $fileInfo = Get-Item $dllPath
    Write-Host "  - $dllPath" -ForegroundColor Green
    Write-Host "    Size: $([math]::Round($fileInfo.Length / 1KB, 2)) KB" -ForegroundColor Gray
    Write-Host "    Modified: $($fileInfo.LastWriteTime)" -ForegroundColor Gray
}

if (Test-Path $pdbPath) {
    Write-Host "  - $pdbPath" -ForegroundColor Green
}

Write-Host ""
Write-Host "Plugin DLL is ready to be copied to your Rocket.Unturned plugins folder!" -ForegroundColor Green
Write-Host ""
Read-Host "Press Enter to exit"

