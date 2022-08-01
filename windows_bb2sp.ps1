$BYTEBASE="Bytebase"
$STASHPAD="Stashpad"

$username = $env:USERNAME

$BB_FOLDER="C:\Users\$username\AppData\Roaming\Bytebase"
$SP_FOLDER="C:\Users\$username\AppData\Roaming\Stashpad"

$REALM="data.realm"
$CONFIG="config.json"

if ( ! (Test-Path -Path $SP_FOLDER) )
{
    Write-Host "Please install Stashpad before running this script." -ForegroundColor Red
    exit 1
}

Write-Host
Read-Host -Prompt "If you are currently editing or writing to a byte inside $BYTEBASE submit it and then hit enter to continue..." -OutVariable ACCEPT

Get-Process -Name $BYTEBASE -OutVariable bytebaseRunning -ea Ignore | Out-Null

if ( $bytebaseRunning.Count -gt 0 )
{
    Write-Host "Stopping $BYTEBASE..."
    Stop-Process -Name $BYTEBASE -ea Ignore
}

Get-Process -Name $STASHPAD -OutVariable stashpadRunning -ea Ignore | Out-Null

if ( $stashpadRunning.Count -gt 0 )
{
    Write-Host "Stopping $STASHPAD"
    Stop-Process -Name $STASHPAD -ea Ignore
}

Join-Path -Path $BB_FOLDER -ChildPath $REALM -OutVariable REALM_FILE | Out-Null

if ( Test-Path -Path $REALM_FILE )
{
    Write-Host "Copying realm data file..."
    Copy-Item $REALM_FILE -Destination $SP_FOLDER
}

Join-Path -Path $BB_FOLDER -ChildPath $CONFIG -OutVariable CONFIG_FILE | Out-Null

if ( Test-Path -Path $CONFIG_FILE )
{
    Write-Host "Copying config file..."
    Copy-Item $CONFIG_FILE -Destination $SP_FOLDER
}

Write-Host
Write-Host "Complete. You may now open Stashpad"
