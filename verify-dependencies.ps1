# Script untuk copy Assembly-CSharp-firstpass.dll ke lokasi yang benar
# Jalankan script ini sekali untuk setup file yang kurang

Write-Host "Checking dependencies..." -ForegroundColor Cyan

$sourceFile = "..\RocketRadiationStorm\Rocket.Unturned-master\lib\Assembly-CSharp-firstpass.dll"
$targetDir = "..\RocketRadiationStorm\lib"
$targetFile = Join-Path $targetDir "Assembly-CSharp-firstpass.dll"

# Check if source exists
if (-not (Test-Path $sourceFile)) {
    Write-Host "ERROR: Source file not found: $sourceFile" -ForegroundColor Red
    Write-Host "Please ensure RocketRadiationStorm folder structure is correct." -ForegroundColor Yellow
    exit 1
}

# Create target directory if needed
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Write-Host "Created directory: $targetDir" -ForegroundColor Green
}

# Copy file
if (Test-Path $targetFile) {
    Write-Host "File already exists: $targetFile" -ForegroundColor Yellow
    $overwrite = Read-Host "Overwrite? (y/n)"
    if ($overwrite -ne "y") {
        Write-Host "Skipped." -ForegroundColor Yellow
        exit 0
    }
}

Copy-Item $sourceFile $targetFile -Force
Write-Host "✓ Copied Assembly-CSharp-firstpass.dll" -ForegroundColor Green

# Verify all required files
Write-Host ""
Write-Host "Verifying dependencies..." -ForegroundColor Cyan

$requiredFiles = @(
    @{ Path = "Modules\Rocket.Unturned\Rocket.API.dll"; Name = "Rocket.API.dll" },
    @{ Path = "Modules\Rocket.Unturned\Rocket.Core.dll"; Name = "Rocket.Core.dll" },
    @{ Path = "Modules\Rocket.Unturned\Rocket.Unturned.dll"; Name = "Rocket.Unturned.dll" },
    @{ Path = "RocketModFix.Unturned.Redist.Server.3.25.9.2\lib\net48\Assembly-CSharp.dll"; Name = "Assembly-CSharp.dll" },
    @{ Path = "RocketModFix.Unturned.Redist.Server.3.25.9.2\lib\net48\com.rlabrecque.steamworks.net.dll"; Name = "com.rlabrecque.steamworks.net.dll" },
    @{ Path = "..\RocketRadiationStorm\lib\Assembly-CSharp-firstpass.dll"; Name = "Assembly-CSharp-firstpass.dll" },
    @{ Path = "..\RocketRadiationStorm\lib\UnityEngine.CoreModule.dll"; Name = "UnityEngine.CoreModule.dll" },
    @{ Path = "..\RocketRadiationStorm\lib\UnityEngine.dll"; Name = "UnityEngine.dll" }
)

$allOk = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file.Path) {
        Write-Host "  ✓ $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $($file.Name) - Missing!" -ForegroundColor Red
        Write-Host "    Expected at: $($file.Path)" -ForegroundColor Yellow
        $allOk = $false
    }
}

Write-Host ""
if ($allOk) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "All dependencies are ready!" -ForegroundColor Green
    Write-Host "You can now build the plugin:" -ForegroundColor Cyan
    Write-Host "  .\build.bat" -ForegroundColor White
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Some dependencies are missing!" -ForegroundColor Red
    Write-Host "Please check the paths above." -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Red
    exit 1
}

