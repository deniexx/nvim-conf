$ErrorActionPreference = "Stop"

$packages = @(
    "Git.Git",
    "Neovim.Neovim",
    "BurntSushi.ripgrep.MSVC",
    "Kitware.CMake",
    "LLVM.LLVM",
    "Microsoft.DotNet.SDK.8"
)

foreach ($pkg in $packages) {
    try {
        winget install --id $pkg --accept-source-agreements --accept-package-agreements --silent
    } catch {
    }
}

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$dotnetToolsPath = "$HOME\.dotnet\tools"
if ($env:Path -notlike "*$dotnetToolsPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$([Environment]::GetEnvironmentVariable('Path', 'User'));$dotnetToolsPath", 'User')
    $env:Path += ";$dotnetToolsPath"
}

try {
    dotnet tool install --global csharp-ls --version 0.20.0
} catch {
    try {
        dotnet tool update --global csharp-ls --version 0.20.0
    } catch {
    }
}