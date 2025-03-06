param (
    [string]$path,
    [string]$destination
)

if (-not $path) {
    Write-Host "No arguments provided"
    exit
}

if (-not $destination) {
    $destination = $path
}

if ($args.Count -gt 0) {
    Write-Host "Too many arguments provided"
    exit
}

$zipFiles = Get-ChildItem -Path $path -Filter "*.zip"

foreach ($zip in $zipFiles) {
    $shell = New-Object -ComObject Shell.Application
    $zipFolder = $shell.Namespace($zip.FullName)

    foreach ($item in $zipFolder.Items()) {
        $shell.Namespace($destination).CopyHere($item, 16) 
    }

      while ((Get-ChildItem -Path $destination | Measure-Object).Count -lt ($zipFolder.Items().Count)) {
        Start-Sleep -Milliseconds 500  # Wait in short intervals instead of a fixed 2 seconds
    }

    Remove-Item $zip.FullName -Force
}

Write-Host "Extraction complete. ZIP files deleted."
