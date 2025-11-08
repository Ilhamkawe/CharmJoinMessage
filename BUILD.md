# Build Configuration for CharmJoinMessage Plugin
# This file contains build settings and instructions

## Build Requirements
- .NET Framework 4.8 SDK
- MSBuild (included with Visual Studio or Build Tools)
- Rocket.Unturned dependencies (should be in ../RocketRadiationStorm/Modules/Rocket.Unturned/)

## Build Methods

### Method 1: Using Visual Studio
1. Open CharmJoinMessage.csproj in Visual Studio
2. Select Release configuration
3. Build > Build Solution (Ctrl+Shift+B)

### Method 2: Using Command Line (MSBuild)
```batch
msbuild CharmJoinMessage.csproj /p:Configuration=Release /p:Platform="Any CPU" /t:Restore,Build
```

### Method 3: Using Build Scripts
- Windows Batch: Run `build.bat`
- PowerShell: Run `build.ps1`

### Method 4: Using GitHub Actions
- Push code to GitHub
- Workflow will automatically build on push/PR
- Download artifacts from Actions tab

## Output Location
Built DLL will be in: `bin/Release/CharmJoinMessage.dll`

## Installation
1. Copy `CharmJoinMessage.dll` to your Rocket.Unturned plugins folder
2. Restart server or use `/rocket reload` command
3. Configure plugin in `Plugins/CharmJoinMessage/CharmJoinMessage.configuration.json`

## Troubleshooting

### MSBuild not found
- Install Visual Studio Build Tools: https://visualstudio.microsoft.com/downloads/
- Or add MSBuild to PATH manually

### Missing dependencies
- Ensure Rocket.Unturned DLLs are in ../RocketRadiationStorm/Modules/Rocket.Unturned/
- Ensure Unity DLLs are in ../RocketRadiationStorm/lib/

### Build errors
- Check that all HintPath references in .csproj are correct
- Verify all dependencies exist at specified paths

