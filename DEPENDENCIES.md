# Setup Dependencies untuk CharmJoinMessage

## 🎯 Tujuan
Sejak commit ini, project sudah memakai NuGet package `RocketModFix.UnityEngine.Redist` supaya `UnityEngine.dll` dan modul turunannya otomatis tersedia saat restore/build. Kamu tidak perlu lagi menyiapkan folder `../RocketRadiationStorm/lib/` secara manual.

## ✅ Dependencies Wajib

| Komponen | Status | Cara Pemenuhan |
| --- | --- | --- |
| Rocket.API/Core/Unturned | ✅ Sudah dibundle di `Modules/Rocket.Unturned/` | Tidak perlu perubahan |
| Assembly-CSharp.dll & kawan-kawan | ✅ Sudah dibundle di `RocketModFix.Unturned.Redist.Server.3.25.9.2/lib/net48/` | Tidak perlu perubahan |
| UnityEngine.* | ✅ Diambil otomatis lewat `PackageReference` ke `RocketModFix.UnityEngine.Redist` | Cukup jalankan restore/build |

## 🚀 Cara Build

```powershell
# Restore package (opsional, MSBuild akan lakukan ketika /t:Restore dipanggil)
.\nuget.exe restore CharmJoinMessage.csproj

# Build (pastikan MSBuild atau dotnet SDK tersedia)
"C:\Path\To\MSBuild.exe" CharmJoinMessage.csproj /t:Restore,Build /p:Configuration=Release
```

Atau jalankan script yang sudah ada:
```powershell
.\build.ps1
```

## ℹ️ Catatan

- Jika build dijalankan di GitHub Actions atau CI lain, pastikan step restore dijalankan (`msbuild /t:Restore` atau `nuget restore`).
- Package NuGet akan di-cache di folder global NuGet (`%USERPROFILE%\.nuget\packages`). Tidak perlu commit folder `packages/` ke repo.
- Apabila ingin build offline, jalankan `nuget restore` sekali saat masih online, lalu copy cache ke environment offline.

## 🔄 Migrasi dari Setup Lama

Jika sebelumnya kamu menyalin manual `UnityEngine.dll` ke `../RocketRadiationStorm/lib/`, sekarang folder itu tidak lagi dipakai. Kamu bisa menghapusnya atau biarkan saja, tidak akan dipakai oleh project ini.

## 🧪 Testing

Setelah build sukses, file output akan berada di `bin\Release\CharmJoinMessage.dll`. Copy ke folder plugin Rocket.Unturned seperti biasa.

Selamat coding! 🎉

