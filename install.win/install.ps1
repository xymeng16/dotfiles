$CONFIG_DIR = "$Home\.config"
$JUNCTION64 = "$PSScriptRoot\junction64.exe"
$DIRS_TO_BE_JOINED = "nvim", "wezterm"
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