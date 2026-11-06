# Installs Diego Logo Live into Wallpaper Engine on this PC and switches to it.
# Any PC:     irm https://raw.githubusercontent.com/diegoarivada/logo-wallpaper/main/install.ps1 | iex
# From clone: powershell -ExecutionPolicy Bypass -File install.ps1
& {
    $ErrorActionPreference = 'Stop'
    $name  = 'diego-logo-live'
    $files = 'index.html', 'project.json', 'preview.jpg', 'fonts/rubik.woff2', 'fonts/OFL-LICENSE.txt'
    $raw   = 'https://raw.githubusercontent.com/diegoarivada/logo-wallpaper/main'

    # Find Wallpaper Engine through every Steam library on this PC.
    $steam = (Get-ItemProperty 'HKCU:\Software\Valve\Steam' -ErrorAction SilentlyContinue).SteamPath
    if (-not $steam) { throw 'Steam was not found on this PC.' }
    $libs = @($steam)
    $vdf = Join-Path $steam 'steamapps\libraryfolders.vdf'
    if (Test-Path $vdf) {
        $libs += (Select-String -Path $vdf -Pattern '"path"\s+"(.+?)"').Matches | ForEach-Object { $_.Groups[1].Value -replace '\\\\', '\' }
    }
    $we = $libs | Select-Object -Unique | ForEach-Object { Join-Path $_ 'steamapps\common\wallpaper_engine' } |
        Where-Object { Test-Path (Join-Path $_ 'wallpaper64.exe') } | Select-Object -First 1
    if (-not $we) { throw 'Wallpaper Engine was not found. Install it from Steam first.' }

    $dest = Join-Path $we "projects\myprojects\$name"
    New-Item -ItemType Directory -Force -Path (Join-Path $dest 'fonts') | Out-Null

    # Use the local copy when run from a clone, otherwise download from GitHub.
    $local = $PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot 'index.html'))
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    foreach ($f in $files) {
        $out = Join-Path $dest $f
        if ($local) { Copy-Item (Join-Path $PSScriptRoot $f) $out -Force }
        else { Invoke-WebRequest -UseBasicParsing -Uri "$raw/$f" -OutFile $out }
    }
    Write-Host "Installed to $dest"

    # Switch to it (this also starts Wallpaper Engine if it isn't running).
    & (Join-Path $we 'wallpaper64.exe') -control openWallpaper -file (Join-Path $dest 'project.json')
    Write-Host 'Diego Logo Live is set. It can take a few seconds to show up.' -ForegroundColor Green
}
