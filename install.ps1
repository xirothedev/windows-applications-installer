<#
.SYNOPSIS
    Script install appication for Windows
.DESCRIPTION
    Hiển thị menu cho phép người dùng chọn ứng dụng để tải xuống
.NOTES
    File Name      : install.ps1
    Author         : Xiro The Dev
    Prerequisite   : PowerShell 5.1 trở lên
#>

# Download folder
$downloadFolder = "$HOME\Downloads"
if (-not (Test-Path -Path $downloadFolder)) {
    New-Item -ItemType Directory -Path $downloadFolder -Force | Out-Null
}

# Function to download files
function Get-File {
    param (
        [string]$url,
        [string]$output
    )
    
    try {
        Write-Host "`nInstalling: $output" -ForegroundColor Cyan
        $progressPreference = 'silentlyContinue'
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
        Write-Host "Finished: $output" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "Error when downloading $url : $_" -ForegroundColor Red
        return $false
    }
}

# List of applications to download
$apps = @(
    @{
        Name = "Discord";
        URL = "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86";
        FileName = "DiscordSetup.exe"
    },
    @{
        Name = "Visual Studio Code";
        URL = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64";
        FileName = "VSCodeSetup-x64.exe"
    },
    @{
        Name = "UltraViewer";
        URL = "https://www.ultraviewer.net/vi/UltraViewer_setup_6.6_vi.exe";
        FileName = "UltraViewerSetup.exe"
    },
    @{
        Name = "Google Chrome";
        URL = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B806F36C0-CB54-4A84-A3F3-0CF8A86575E0%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe";
        FileName = "ChromeSetup.exe"
    },
    @{
        Name = "7-Zip";
        URL = "https://7-zip.org/a/7z2405-x64.exe";
        FileName = "7z-x64.exe"
    },
    @{
        Name = "Zoom";
        URL = "https://zoom.us/client/latest/ZoomInstaller.exe";
        FileName = "ZoomInstaller.exe"
    },
    @{
        Name = "TeamViewer";
        URL = "https://download.teamviewer.com/download/TeamViewer_Setup.exe";
        FileName = "TeamViewerSetup.exe"
    },
    @{
        Name = "HW Monitor";
        URL = "https://download.cpuid.com/hwmonitor/hwmonitor_1.57.exe";
        FileName = "HWMonitorSetup.exe"
    },
    @{
        Name = "Cpu-Z";
        URL = "https://www.cpuid.com/downloads/cpu-z/cpu-z_2.15-en.exe";
        FileName = "CpuZSetup.exe"
    }
    @{
        Name = "CrystalDiskInfo";
        URL = "https://sourceforge.net/projects/crystaldiskinfo/files/latest/download"
        FileName = "CrystalDiskInfoSetup.exe"
    },
    @{
        Name = "WinRAR";
        URL = "https://www.rarlab.com/rar/winrar-x64-711.exe";
        FileName = "WinRARSetup.exe"
    },
    @{
        Name = "Zalo PC";
        URL = "https://zalo.me/download/zalo-pc?utm=90000";
        FileName = "ZaloSetup.exe"
    },
    @{
        Name = "Postman";
        URL = "https://dl.pstmn.io/download/latest/win64";
        FileName = "PostmanSetup.exe"
    }
    @{
        Name = "Unikey";
        URL = "https://github.com/xirothedev/windows-applications-installer/blob/main/Unikey/UniKeyNT.exe";
        FileName = "UniKeySetup.exe"
    }
)

# Display menu function
function Show-Menu {
    param (
        [string]$Title = 'Choose Applications to Download'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    
    for ($i = 0; $i -lt $apps.Count; $i++) {
        Write-Host "$($i+1).`t$($apps[$i].Name)"
    }
    
    Write-Host ""
    Write-Host "A.`tDownload All Applications"
    Write-Host "Q.`tExit"
    Write-Host ""
    Write-Host "========================================"
}

# Main script
do {
    Show-Menu
    $selection = Read-Host "`nEnter the numbers of the applications to download (separated by commas, or 'A' to select all, 'Q' to quit)"
    
    if ($selection -eq 'Q') {
        exit
    }
    
    $selectedApps = @()
    
    if ($selection -eq 'A') {
        $selectedApps = $apps
    }
    else {
        $choices = $selection -split ',' | ForEach-Object { $_.Trim() }
        
        foreach ($choice in $choices) {
            if ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le $apps.Count) {
                $selectedApps += $apps[[int]$choice-1]
            }
            else {
                Write-Host "Invalid choice: $choice" -ForegroundColor Red
            }
        }
    }
    
    if ($selectedApps.Count -gt 0) {
        Write-Host "`nYou have selected to download the following applications:" -ForegroundColor Yellow
        $selectedApps | ForEach-Object { Write-Host "- $($_.Name)" }
        
        $confirm = Read-Host "`nConfirm download? (Y/N)"
        if ($confirm -eq 'Y' -or $confirm -eq 'y') {
            $successCount = 0
            
            foreach ($app in $selectedApps) {
                $outputPath = Join-Path -Path $downloadFolder -ChildPath $app.FileName
                $result = Get-File -url $app.URL -output $outputPath
                if ($result) { $successCount++ }
            }
            
            Write-Host "`nCompleted downloading $successCount/$($selectedApps.Count) applications to folder: $downloadFolder" -ForegroundColor Yellow
            $openFolder = Read-Host "`nOpen the folder containing the downloaded files? (Y/N)"
            if ($openFolder -eq 'Y' -or $openFolder -eq 'y') {
                Invoke-Item $downloadFolder
            }
        }
        else {
            Write-Host "Download canceled." -ForegroundColor Magenta
        }
    }
    
    if ($selection -ne 'Q') {
        pause
    }
} while ($selection -ne 'Q')