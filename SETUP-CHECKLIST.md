# Checklist: Yang Harus Disiapkan di Folder CharmJoinMessage

## 📁 Struktur Folder yang Diperlukan

Berdasarkan file `CharmJoinMessage.csproj`, berikut struktur folder dan file yang HARUS ada:

```
CharmJoinMessage/
├── CharmJoinMessage.csproj          ✅ (sudah ada)
├── CharmJoinMessagePlugin.cs       ✅ (sudah ada)
├── CharmJoinMessagePluginConfiguration.cs ✅ (sudah ada)
│
├── RocketModFix.Unturned.Redist.Server.3.25.9.2/  ✅ (sudah ada)
│   └── lib/
│       └── net48/
│           ├── Assembly-CSharp.dll              ✅ (sudah ada)
│           └── com.rlabrecque.steamworks.net.dll ✅ (sudah ada)
│
└── ../RocketRadiationStorm/                    ❌ (PERLU DIBUAT)
    ├── Modules/
    │   └── Rocket.Unturned/
    │       ├── Rocket.API.dll                  ❌ PERLU
    │       ├── Rocket.Core.dll                 ❌ PERLU
    │       └── Rocket.Unturned.dll             ❌ PERLU
    │
    └── lib/
        ├── Assembly-CSharp-firstpass.dll        ❌ PERLU
        ├── UnityEngine.CoreModule.dll          ❌ PERLU
        └── UnityEngine.dll                      ❌ PERLU
```

## ✅ File yang Sudah Ada (Tidak Perlu Disiapkan)

1. ✅ `CharmJoinMessage.csproj`
2. ✅ `CharmJoinMessagePlugin.cs`
3. ✅ `CharmJoinMessagePluginConfiguration.cs`
4. ✅ `RocketModFix.Unturned.Redist.Server.3.25.9.2/lib/net48/Assembly-CSharp.dll`
5. ✅ `RocketModFix.Unturned.Redist.Server.3.25.9.2/lib/net48/com.rlabrecque.steamworks.net.dll`

## ❌ File yang PERLU Disiapkan

### 1. Rocket.Unturned DLLs (3 file)

**Lokasi:** `../RocketRadiationStorm/Modules/Rocket.Unturned/`

File yang diperlukan:
- `Rocket.API.dll`
- `Rocket.Core.dll`
- `Rocket.Unturned.dll`

**Cara mendapatkan:**
- Download dari: https://github.com/RocketMod/Rocket.Unturned/releases
- Atau copy dari instalasi Rocket.Unturned yang sudah ada
- Atau dari folder `RocketRadiationStorm/Modules/Rocket.Unturned/` di project lain

### 2. Unity DLLs (3 file)

**Lokasi:** `../RocketRadiationStorm/lib/`

File yang diperlukan:
- `Assembly-CSharp-firstpass.dll`
- `UnityEngine.CoreModule.dll`
- `UnityEngine.dll`

**Cara mendapatkan:**
- Copy dari instalasi Unturned Server
- Biasanya ada di: `Unturned/Unturned_Data/Managed/`
- Atau dari folder `RocketRadiationStorm/lib/` di project lain

## 🔧 Langkah-Langkah Setup

### Step 1: Buat Struktur Folder

```bash
# Dari folder plugin/
mkdir -p RocketRadiationStorm/Modules/Rocket.Unturned
mkdir -p RocketRadiationStorm/lib
```

Atau di Windows PowerShell:
```powershell
# Dari folder plugin/
New-Item -ItemType Directory -Path "RocketRadiationStorm\Modules\Rocket.Unturned" -Force
New-Item -ItemType Directory -Path "RocketRadiationStorm\lib" -Force
```

### Step 2: Copy Rocket.Unturned DLLs

Copy 3 file berikut ke `RocketRadiationStorm/Modules/Rocket.Unturned/`:
- `Rocket.API.dll`
- `Rocket.Core.dll`
- `Rocket.Unturned.dll`

**Sumber file:**
- Dari instalasi Rocket.Unturned server
- Atau download dari GitHub releases
- Atau copy dari project lain yang sudah punya

### Step 3: Copy Unity DLLs

Copy 3 file berikut ke `RocketRadiationStorm/lib/`:
- `Assembly-CSharp-firstpass.dll`
- `UnityEngine.CoreModule.dll`
- `UnityEngine.dll`

**Sumber file:**
- Dari instalasi Unturned Server: `Unturned/Unturned_Data/Managed/`
- Atau copy dari project lain yang sudah punya

### Step 4: Verifikasi

Setelah semua file disiapkan, struktur harus seperti ini:

```
plugin/
├── CharmJoinMessage/
│   ├── CharmJoinMessage.csproj
│   ├── CharmJoinMessagePlugin.cs
│   ├── CharmJoinMessagePluginConfiguration.cs
│   └── RocketModFix.Unturned.Redist.Server.3.25.9.2/
│       └── lib/net48/
│           ├── Assembly-CSharp.dll
│           └── com.rlabrecque.steamworks.net.dll
│
└── RocketRadiationStorm/                    ← PERLU DIBUAT
    ├── Modules/
    │   └── Rocket.Unturned/
    │       ├── Rocket.API.dll              ← PERLU
    │       ├── Rocket.Core.dll            ← PERLU
    │       └── Rocket.Unturned.dll         ← PERLU
    │
    └── lib/
        ├── Assembly-CSharp-firstpass.dll   ← PERLU
        ├── UnityEngine.CoreModule.dll      ← PERLU
        └── UnityEngine.dll                  ← PERLU
```

## 🧪 Test Build

Setelah semua file disiapkan, test build:

```bash
# Windows
cd CharmJoinMessage
build.bat

# Atau PowerShell
.\build.ps1
```

Jika build berhasil, akan muncul:
```
BUILD SUCCESSFUL!
Output: bin\Release\CharmJoinMessage.dll
```

## 📝 Catatan Penting

1. **Path relatif**: File `.csproj` menggunakan path relatif `../RocketRadiationStorm/`
   - Artinya folder `RocketRadiationStorm` harus ada di **satu level di atas** folder `CharmJoinMessage`
   - Struktur: `plugin/RocketRadiationStorm/` dan `plugin/CharmJoinMessage/`

2. **Versi DLL**: Pastikan versi DLL sesuai dengan versi Rocket.Unturned dan Unturned yang digunakan

3. **Git**: Jika menggunakan Git, pertimbangkan untuk:
   - Menambahkan DLL ke `.gitignore` (karena file besar)
   - Atau menggunakan Git LFS untuk DLL files
   - Atau menyediakan script untuk download dependencies

## 🚀 Quick Setup Script

Jika sudah punya dependencies di tempat lain, gunakan script ini:

```powershell
# setup-dependencies.ps1
# Copy dari lokasi yang sudah ada

$sourceRocket = "C:\Path\To\RocketRadiationStorm\Modules\Rocket.Unturned"
$sourceLib = "C:\Path\To\RocketRadiationStorm\lib"
$targetRocket = "..\RocketRadiationStorm\Modules\Rocket.Unturned"
$targetLib = "..\RocketRadiationStorm\lib"

# Create directories
New-Item -ItemType Directory -Path $targetRocket -Force
New-Item -ItemType Directory -Path $targetLib -Force

# Copy Rocket DLLs
Copy-Item "$sourceRocket\Rocket.API.dll" $targetRocket -Force
Copy-Item "$sourceRocket\Rocket.Core.dll" $targetRocket -Force
Copy-Item "$sourceRocket\Rocket.Unturned.dll" $targetRocket -Force

# Copy Unity DLLs
Copy-Item "$sourceLib\Assembly-CSharp-firstpass.dll" $targetLib -Force
Copy-Item "$sourceLib\UnityEngine.CoreModule.dll" $targetLib -Force
Copy-Item "$sourceLib\UnityEngine.dll" $targetLib -Force

Write-Host "Dependencies setup complete!" -ForegroundColor Green
```

