param(
    [Parameter(Mandatory=$false)][System.Boolean]$DownloadAllImages = $true
)

Clear-Host
$ErrorActionPreference = "SilentlyContinue"
$numberOfBackgrounds = 200
$targetFolder = "C:\tmp\Teams Backgrounds\"
#new URLS February 2022
$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/MS-viva_Outdoor"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/MS-viva_Office"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/HeritageMonth"   #png!!
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/Hispanic-heritage-month-"
##### new URLs end
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/user-submitted-background-"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-Abstract-0"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-office-0"
#$FilenameStart = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-home-0"

$FilenameFormat = ".jpg"
#$FilenameFormat = ".png"

#static file names:
$StaticFilenames = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/nostalgia-clippy.jpg", "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/nostalgia-solitaire.jpg", "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/nostalgia-paint.jpg", "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/nostalgia-landscape.jpg"
#URL sources list:
$URLSources = "https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/MS-viva_Outdoor","https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/MS-viva_Office","https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/HeritageMonth","https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/Hispanic-heritage-month-","https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/user-submitted-background-","https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-Abstract-0","https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-office-0","https://adoption.azureedge.net/wp-content/custom-backgrounds-gallery/VIVA-background-home-0"
#FileFormat list:
$FileFormatsList = ".jpg", ".png"


if(-not $DownloadAllImages)
{
    Write-Host "Downloading selective background images " -NoNewline
    if(!(Test-Path $targetFolder)){New-Item -Path $targetFolder -ItemType Directory -Force}
    1..$numberOfBackgrounds | ForEach-Object{$url = $FilenameStart + $_.ToString() + $FilenameFormat; Invoke-WebRequest -Uri $url -OutFile( $targetFolder + $url.Split("/")[$url.Split("/").length - 1] ) -UseBasicParsing -ErrorAction 'SilentlyContinue'; Write-Host "." -NoNewline}
    $StaticFilenames | ForEach-Object {$url = $_; Invoke-WebRequest -Uri $url -OutFile( $targetFolder + $url.Split("/")[$url.Split("/").length - 1] ) -UseBasicParsing -ErrorAction 'SilentlyContinue'; Write-Host "." -NoNewline}
}
else 
{
    Write-Host "Downloading all background images " -NoNewline
    if(!(Test-Path $targetFolder)){New-Item -Path $targetFolder -ItemType Directory -Force}
    foreach($FilenameStart in $URLSources)
    {
        foreach($FilenameFormat in $FileFormatsList)
        {
            Write-Host "Searching for $($FilenameFormat) background images"
            1..$numberOfBackgrounds | ForEach-Object{$url = $FilenameStart + $_.ToString() + $FilenameFormat; Invoke-WebRequest -Uri $url -OutFile( $targetFolder + $url.Split("/")[$url.Split("/").length - 1] ) -UseBasicParsing -ErrorAction 'SilentlyContinue'; Write-Host "." -NoNewline}
        }
    }
    $StaticFilenames | ForEach-Object {$url = $_; Invoke-WebRequest -Uri $url -OutFile( $targetFolder + $url.Split("/")[$url.Split("/").length - 1] ) -UseBasicParsing -ErrorAction 'SilentlyContinue'; Write-Host "." -NoNewline}
}
#copy to Teams images folder
$list = Get-ChildItem $targetFolder
foreach($file in $list)
{
    Copy-Item $file.FullName -Destination ($env:APPDATA + "\Microsoft\Teams\backgrounds\Uploads")
}

Write-Host "`n`nNew background images successfully saved. Please restart Teams to use the backgrounds." -ForegroundColor Magenta