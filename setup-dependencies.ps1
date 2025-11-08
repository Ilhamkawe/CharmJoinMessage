# PowerShell script untuk setup dependencies
# Edit path source sesuai lokasi dependencies Anda

param(
    [string]$SourceRocketPath = "",
    [string]$SourceLibPath = ""
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Dependencies untuk CharmJoinMessage" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Jika path tidak diberikan, coba cari otomatis
if ([string]::IsNullOrWhiteSpace($SourceRocketPath)) {
    # Coba cari di folder parent
    $possiblePaths = @(
        "..\RocketRadiationStorm\Modules\Rocket.Unturned",
        "..\..\RocketRadiationStorm\Modules\Rocket.Unturned",
        "C:\Rocket\Modules\Rocket.Unturned"
    )
    
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            $SourceRocketPath = $path
            Write-Host "Found Rocket.Unturned at: $path" -ForegroundColor Green
            break
        }
    }
}

if ([string]::IsNullOrWhiteSpace($SourceLibPath)) {
    $possiblePaths = @(
        "..\RocketRadiationStorm\lib",
        "..\..\RocketRadiationStorm\lib",
        "C:\Rocket\lib"
    )
    
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            $SourceLibPath = $path
            Write-Host "Found lib at: $path" -ForegroundColor Green
            break
        }
    }
}

# Validasi
if ([string]::IsNullOrWhiteSpace($SourceRocketPath) -or -not (Test-Path $SourceRocketPath)) {
    Write-Host "ERROR: Rocket.Unturned path not found!" -ForegroundColor Red
    Write-Host "Please provide source path:" -ForegroundColor Yellow
    Write-Host "  .\setup-dependencies.ps1 -SourceRocketPath 'C:\Path\To\Rocket.Unturned' -SourceLibPath 'C:\Path\To\lib'" -ForegroundColor Yellow
    exit 1
}

if ([string]::IsNullOrWhiteSpace($SourceLibPath) -or -not (Test-Path $SourceLibPath)) {
    Write-Host "ERROR: lib path not found!" -ForegroundColor Red
    Write-Host "Please provide source path:" -ForegroundColor Yellow
    Write-Host "  .\setup-dependencies.ps1 -SourceRocketPath 'C:\Path\To\Rocket.Unturned' -SourceLibPath 'C:\Path\To\lib'" -ForegroundColor Yellow
    exit 1
}

# Target paths
$targetRocket = "..\RocketRadiationStorm\Modules\Rocket.Unturned"
$targetLib = "..\RocketRadiationStorm\lib"

Write-Host "Source Rocket.Unturned: $SourceRocketPath" -ForegroundColor Yellow
Write-Host "Source lib: $SourceLibPath" -ForegroundColor Yellow
Write-Host "Target Rocket.Unturned: $targetRocket" -ForegroundColor Yellow
Write-Host "Target lib: $targetLib" -ForegroundColor Yellow
Write-Host ""

# Create directories
Write-Host "Creating directories..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $targetRocket -Force | Out-Null
New-Item -ItemType Directory -Path $targetLib -Force | Out-Null
Write-Host "✓ Directories created" -ForegroundColor Green
Write-Host ""

# Copy Rocket DLLs
Write-Host "Copying Rocket.Unturned DLLs..." -ForegroundColor Cyan
$rocketDlls = @("Rocket.API.dll", "Rocket.Core.dll", "Rocket.Unturned.dll")
$rocketCopied = 0
foreach ($dll in $rocketDlls) {
    $sourceFile = Join-Path $SourceRocketPath $dll
    if (Test-Path $sourceFile) {
        Copy-Item $sourceFile $targetRocket -Force
        Write-Host "  ✓ $dll" -ForegroundColor Green
        $rocketCopied++
    } else {
        Write-Host "  ✗ $dll (not found)" -ForegroundColor Red
    }
}

if ($rocketCopied -eq 0) {
    Write-Host "ERROR: No Rocket DLLs found!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Copy Unity DLLs
Write-Host "Copying Unity DLLs..." -ForegroundColor Cyan
$unityDlls = @("Assembly-CSharp-firstpass.dll", "UnityEngine.CoreModule.dll", "UnityEngine.dll")
$unityCopied = 0
foreach ($dll in $unityDlls) {
    $sourceFile = Join-Path $SourceLibPath $dll
    if (Test-Path $sourceFile) {
        Copy-Item $sourceFile $targetLib -Force
        Write-Host "  ✓ $dll" -ForegroundColor Green
        $unityCopied++
    } else {
        Write-Host "  ✗ $dll (not found)" -ForegroundColor Red
    }
}

if ($unityCopied -eq 0) {
    Write-Host "ERROR: No Unity DLLs found!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Verify
Write-Host "Verifying setup..." -ForegroundColor Cyan
$allOk = $true
foreach ($dll in $rocketDlls) {
    $targetFile = Join-Path $targetRocket $dll
    if (Test-Path $targetFile) {
        Write-Host "  ✓ $dll" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $dll (missing)" -ForegroundColor Red
        $allOk = $false
    }
}

foreach ($dll in $unityDlls) {
    $targetFile = Join-Path $targetLib $dll
    if (Test-Path $targetFile) {
        Write-Host "  ✓ $dll" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $dll (missing)" -ForegroundColor Red
        $allOk = $false
    }
}

Write-Host ""
if ($allOk) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Setup Complete! Dependencies ready." -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "You can now build the plugin:" -ForegroundColor Cyan
    Write-Host "  .\build.bat" -ForegroundColor White
    Write-Host "  or" -ForegroundColor White
    Write-Host "  .\build.ps1" -ForegroundColor White
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Setup Incomplete! Some files missing." -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    exit 1
}

