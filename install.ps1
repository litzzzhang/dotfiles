$Dotfiles = "C:\dev\dotfiles"

New-Item -ItemType SymbolicLink `
  -Force `
  -Path $env:LOCALAPPDATA\nvim `
  -Target $Dotfiles\nvim

# New-Item -ItemType SymbolicLink `
#   -Force `
#   -Path $PROFILE `
#   -Target "$Dotfiles\powershell\Microsoft.PowerShell_profile.ps1"

Write-Host "Dotfiles installed (Windows)"
