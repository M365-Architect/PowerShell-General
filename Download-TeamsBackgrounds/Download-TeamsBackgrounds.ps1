Clear-Host
$ErrorActionPreference = "SilentlyContinue"
$numberOfBackgrounds = 100
$targetFolder = "C:\tmp\Teams Backgrounds\"
$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/user-submitted-background-"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-Abstract-0"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-office-0"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-home-0"
$FilenameFormat = ".jpg"

Write-Host "Downloading background images " -NoNewline
1..$numberOfBackgrounds | ForEach-Object{$url = $FilenameStart + $_.ToString() + $FilenameFormat; Invoke-WebRequest -Uri $url -OutFile( $targetFolder + $url.Split("/")[$url.Split("/").length - 1] ) -UseBasicParsing -ErrorAction 'SilentlyContinue'; Write-Host "." -NoNewline}

#copy to Teams images folder
$list = Get-ChildItem $targetFolder
foreach($file in $list)
{
    Copy-Item $file.FullName -Destination ($env:APPDATA + "\Microsoft\Teams\backgrounds\Uploads")
}

Write-Host "`n`nNew background images successfully saved. Please restart Teams to use the backgrounds." -ForegroundColor Magenta