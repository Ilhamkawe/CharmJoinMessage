# Status Dependencies CharmJoinMessage

## ✅ Sudah Siap

- `Modules/Rocket.Unturned/` → berisi `Rocket.API/Core/Unturned.dll`
- `RocketModFix.Unturned.Redist.Server.3.25.9.2/lib/net48/` → berisi `Assembly-CSharp.dll`, `com.rlabrecque.steamworks.net.dll`, dll
- `UnityEngine.*` → otomatis disediakan lewat NuGet package `RocketModFix.UnityEngine.Redist`

## ❌ Tidak Lagi Diperlukan

- Folder `../RocketRadiationStorm/lib/` dengan `UnityEngine.dll`
- File manual `Assembly-CSharp-firstpass.dll` di luar project

## ✅ Langkah Build

```powershell
# Restore (opsional, msbuild /t:Restore juga oke)
.\nuget.exe restore CharmJoinMessage.csproj

# Build (gunakan path MSBuild yang tersedia di environment kamu)
"C:\Path\To\MSBuild.exe" CharmJoinMessage.csproj /t:Restore,Build /p:Configuration=Release
```

Atau jalankan:
```powershell
.\build.ps1
```

## 📦 Output

Setelah sukses, plugin berada di `bin\Release\CharmJoinMessage.dll`.

Semua dependency kritikal sekarang tersentral di NuGet cache sehingga CI/CD maupun build lokal tinggal restore + build saja. 🎉

