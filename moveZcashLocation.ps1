# Move ZCash Wallet Location Script
# Ⓒ 2018 @Krakenfuego
# MIT License

# Elevate Admin Permissions
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs}

# Ask user where they want to store blockchain
    $newBlockchainLocation = Read-Host -Prompt 'Input new location'

# Try to Create the directory if it doesnt exist
    New-Item $newBlockchainLocation -ItemType Directory
    New-Item $newBlockchainLocation/Zcash -ItemType Directory
    New-Item $newBlockchainLocation/ZcashParams -ItemType Directory    

# Check If ZCash/ZCashParams Exit
    $blockchainExists = 0;
    $Zcash = "$env:AppData/Zcash"

    If (Test-Path $Zcash) {
        $blockchainExists = 1;
        Write-Output "Zcash Installed"
    }
    Else {
        Write-Output "No ZCash Install"
    }

# If Exists Move to New Location
    If ($blockchainExists -eq 1) {
        Move-Item -Path "$env:AppData/Zcash" -Destination $newBlockchainLocation
        New-Item -Path "$env:AppData/Zcash" -ItemType SymbolicLink -Value $newBlockchainLocation/Zcash
        Move-Item -Path "$env:AppData/ZcashParams" -Destination $newBlockchainLocation
        New-Item -Path "$env:AppData/ZcashParams" -ItemType SymbolicLink -Value $newBlockchainLocation/ZCashParams
    }
    Else {
        New-Item -Path "$env:AppData/Zcash" -ItemType SymbolicLink -Value $newBlockchainLocation/Zcash
        New-Item -Path "$env:AppData/ZcashParams" -ItemType SymbolicLink -Value $newBlockchainLocation/ZCashParams
    }

