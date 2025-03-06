param (
    [string]$path,
    [string]$destination
)

function Show-Usage {
    Write-Host "Usage: .\extract.ps1 -path <source-directory> [-destination <output-directory>]"
    Write-Host "Example 1: .\extract.ps1 -path 'C:\dog'"
    Write-Host "Example 2: .\extract.ps1 -path 'C:\dog' -destination 'C:\output'"
    exit 1
}

if (-not $path) {
    Write-Host "Error: No source path provided"
    Show-Usage
}

if (-not $destination) {
    $destination = $path
}

if ($args.Count -gt 0) {
    Write-Host "Error: Too many arguments provided"
    Show-Usage
}

Write-Host "Extracting ZIP files from: $path"
Write-Host "Extracting to: $destination"

$zipFiles = Get-ChildItem -Path $path -Filter "*.zip"

foreach ($zip in $zipFiles) {
    $shell = New-Object -ComObject Shell.Application
    $zipFolder = $shell.Namespace($zip.FullName)

    foreach ($item in $zipFolder.Items()) {
        $shell.Namespace($destination).CopyHere($item, 16) 
    }

      while ((Get-ChildItem -Path $destination | Measure-Object).Count -lt ($zipFolder.Items().Count)) {
        Start-Sleep -Milliseconds 500
    }

    Remove-Item $zip.FullName -Force
}

Write-Host "Extraction complete. ZIP files deleted."
