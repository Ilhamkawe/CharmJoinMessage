# Setup Dependencies untuk GitHub Actions

File ini menjelaskan cara setup dependencies untuk build di GitHub Actions.

## Masalah

Workflow GitHub Actions gagal karena dependencies tidak ditemukan:
- Rocket.Unturned DLLs (Rocket.API.dll, Rocket.Core.dll, Rocket.Unturned.dll)
- Unity DLLs (UnityEngine.dll, UnityEngine.CoreModule.dll, Assembly-CSharp-firstpass.dll)

## Solusi

### Opsi 1: Include Dependencies di Repository (Recommended untuk Private Repo)

1. Copy dependencies ke struktur folder yang diharapkan:
   ```
   plugin/
     RocketRadiationStorm/
       Modules/
         Rocket.Unturned/
           Rocket.API.dll
           Rocket.Core.dll
           Rocket.Unturned.dll
       lib/
         Assembly-CSharp-firstpass.dll
         UnityEngine.CoreModule.dll
         UnityEngine.dll
   ```

2. Commit dependencies ke repository

**Catatan**: File DLL besar, pertimbangkan menggunakan Git LFS atau alternatif lain.

### Opsi 2: Download Dependencies di Workflow

Workflow sudah mencoba download dependencies, tapi mungkin perlu disesuaikan dengan:
- URL download yang benar
- Authentication jika diperlukan
- Version yang sesuai

### Opsi 3: Gunakan NuGet Packages (Best Practice)

Ubah `.csproj` untuk menggunakan NuGet packages:

```xml
<ItemGroup>
  <PackageReference Include="Rocket.API" Version="5.5.0" />
  <PackageReference Include="Rocket.Core" Version="5.5.0" />
  <PackageReference Include="Rocket.Unturned" Version="5.5.0" />
</ItemGroup>
```

**Catatan**: Rocket.Unturned mungkin tidak tersedia di NuGet public, perlu source alternatif.

### Opsi 4: Setup Dependencies Cache

Gunakan GitHub Actions cache untuk menyimpan dependencies:

```yaml
- name: Cache dependencies
  uses: actions/cache@v3
  with:
    path: |
      RocketRadiationStorm/Modules/Rocket.Unturned
      RocketRadiationStorm/lib
    key: ${{ runner.os }}-rocket-deps-${{ hashFiles('**/dependencies.lock') }}
```

### Opsi 5: Build Lokal Saja

Jika dependencies sulit di-setup di CI/CD, gunakan build lokal:
- `build.bat` atau `build.ps1` untuk build lokal
- Commit DLL hasil build ke repository (tidak ideal tapi praktis)

## Rekomendasi

Untuk development lokal: Gunakan struktur folder yang ada sekarang.

Untuk CI/CD: 
1. Jika repository private → Include dependencies di repo
2. Jika repository public → Gunakan download di workflow atau build lokal
3. Pertimbangkan menggunakan GitHub Packages atau Artifacts untuk menyimpan dependencies

