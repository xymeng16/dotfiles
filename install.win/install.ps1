$CONFIG_DIR = "$Home\.config"
$JUNCTION64 = "$PSScriptRoot\junction64.exe"
$DIRS_TO_BE_JOINED = "wezterm"
$NVIM_CONFIG_DIR = "$Home\AppData\Local"
# create $Home/.config if not exists
if (!(Test-Path -Path "$CONFIG_DIR")) {
    New-Item -ItemType Directory -Path "$CONFIG_DIR"
}

# use juncation64 to check if junctions are already created
# usage: junction64.exe -s DIR
$JUNCTION64 = "$PSScriptRoot/junction64.exe"
$JUNCTIONS = & $JUNCTION64 -s "$CONFIG_DIR"

if (!($JUNCTIONS -match "No matching files were found.")) {
    Write-Host "Junctions already created"
} else {
    foreach ($DIR in $DIRS_TO_BE_JOINED) {
        $SOURCE = "$PSScriptRoot\..\$DIR"
        $DEST = "$CONFIG_DIR\$DIR"
        Write-Host "Creating junction from $SOURCE to $DEST"
        & $JUNCTION64 "$DEST" "$SOURCE"
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Failed to create junction from $SOURCE to $DEST, return code $LASTEXITCODE"
        }
    }
}

# handle nvim config
$NVIM_SOURCE = "$PSScriptRoot\..\nvim"
$NVIM_DEST = "$NVIM_CONFIG_DIR\nvim"
$NVIM_JUNCTIONS = & $JUNCTION64 -s "$NVIM_DEST"
if ($NVIM_JUNCTIONS -match "No matching files were found.") {
    Write-Host "Creating junction from $NVIM_SOURCE to $NVIM_DEST"
    & $JUNCTION64 "$NVIM_DEST" "$NVIM_SOURCE"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to create junction from $NVIM_SOURCE to $NVIM_DEST, return code $LASTEXITCODE"
    }
} else {
    Write-Host "Nvim Junction already created"
}

# use winget to install missing packages
# suppose a fresh windows installation
$WINGET = "winget"
$MISSING_PACKAGES = @("wez.wezterm", "Neovim.Neovim", "BurntSushi.ripgrep.MSVC", "sharkdp.fd", "JesseDuffield.lazygit", "LLVM.LLVM")

foreach ($PACKAGE in $MISSING_PACKAGES) {
    Write-Host "Installing $PACKAGE"
    & $WINGET install -e --id $PACKAGE
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install $PACKAGE, return code $LASTEXITCODE"
    }
}

Write-Host "Please add LLVM to PATH manually!"
Write-Host "Commonly it is located at C:\Program Files\LLVM\bin"