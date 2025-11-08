# CharmJoinMessage Plugin

Plugin untuk Rocket.Unturned yang menampilkan pesan join dan welcome message yang menarik dengan warna-warna yang dapat dikustomisasi.

## Fitur

- ✨ **Join Message Broadcast** - Pesan saat player join (dikirim ke semua player)
- 💖 **Welcome Message** - Pesan welcome personal untuk player yang baru join
- 🎨 **Warna Kustomisasi** - 15+ warna yang dapat dipilih
- 📊 **Player Count** - Tampilkan jumlah player online
- ⚙️ **Konfigurasi Lengkap** - Semua fitur dapat diaktifkan/nonaktifkan melalui config

## Build Workflow

Plugin ini menyediakan beberapa cara untuk build:

### 1. GitHub Actions (Otomatis)

Workflow GitHub Actions akan otomatis build plugin saat:
- Push ke branch `main` atau `master`
- Pull request dibuat
- Manual trigger melalui GitHub Actions tab

**File:** `.github/workflows/build.yml`

**Cara menggunakan:**
1. Push code ke GitHub repository
2. Buka tab "Actions" di GitHub
3. Download artifact dari build yang berhasil

### 2. Build Script Lokal

#### Windows Batch (`build.bat`)
```batch
build.bat
```

#### PowerShell (`build.ps1`)
```powershell
.\build.ps1
```

#### Build and Deploy (`build-and-deploy.ps1`)
```powershell
# Build saja
.\build-and-deploy.ps1

# Build dan deploy ke server
.\build-and-deploy.ps1 -Deploy -ServerPluginsPath "C:\Path\To\Rocket\Plugins"
```

### 3. Manual Build dengan MSBuild

```batch
msbuild CharmJoinMessage.csproj /p:Configuration=Release /p:Platform="Any CPU" /t:Restore,Build
```

### 4. Visual Studio

1. Buka `CharmJoinMessage.csproj` di Visual Studio
2. Pilih configuration "Release"
3. Build > Build Solution (Ctrl+Shift+B)

## Output

Setelah build berhasil, file DLL akan berada di:
```
bin/Release/CharmJoinMessage.dll
```

## Instalasi

1. Copy `CharmJoinMessage.dll` ke folder plugins Rocket.Unturned:
   ```
   Rocket/Plugins/CharmJoinMessage.dll
   ```

2. Restart server atau reload plugin:
   ```
   /rocket reload CharmJoinMessage
   ```

3. Konfigurasi plugin di:
   ```
   Rocket/Plugins/CharmJoinMessage/CharmJoinMessage.configuration.json
   ```

## Requirements

- .NET Framework 4.8 SDK
- MSBuild (termasuk dengan Visual Studio atau Build Tools)
- Rocket.Unturned dependencies (harus ada di `../RocketRadiationStorm/Modules/Rocket.Unturned/`)

## Konfigurasi

Semua pengaturan dapat dikonfigurasi melalui file config:

```json
{
  "BroadcastJoinMessage": true,
  "ShowWelcomeMessage": true,
  "ShowWelcomeTitle": true,
  "JoinMessageColor": "cyan",
  "WelcomeMessageColor": "pink",
  "WelcomeTitleColor": "magenta",
  "AdditionalMessage": "Have fun and enjoy your adventure! ✨",
  "AdditionalMessageColor": "gold",
  "ShowPlayerCount": true,
  "PlayerCountColor": "cyan"
}
```

### Warna yang Tersedia

- `pink`, `magenta`, `cyan`, `yellow`, `green`, `orange`, `purple`
- `red`, `blue`, `white`, `gold`, `coral`, `lavender`
- `rose`, `mint`, `peach`

## Troubleshooting

### MSBuild tidak ditemukan
- Install [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/)
- Atau tambahkan MSBuild ke PATH secara manual

### Dependencies tidak ditemukan
- Pastikan Rocket.Unturned DLLs ada di `../RocketRadiationStorm/Modules/Rocket.Unturned/`
- Pastikan Unity DLLs ada di `../RocketRadiationStorm/lib/`

### Build error
- Periksa semua HintPath di file `.csproj` sudah benar
- Pastikan semua dependencies ada di path yang ditentukan

## License

[Your License Here]

## Credits

Dibuat untuk Rocket.Unturned

