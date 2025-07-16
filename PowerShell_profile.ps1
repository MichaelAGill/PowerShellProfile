function Open-Profile {
    code $PROFILE
}
Set-Alias profile Open-Profile

function Set-Work {
    param(
        [parameter(Mandatory = $true)]
        [string]$name
    )
    setx WORKSPACE_ROOT $name
    Write-Host "env:WORKSPACE_ROOT set to '$name'."
}
Set-Alias setwork Set-Work

function Get-Work {
    Write-Host $env:WORKSPACE_ROOT
}
Set-Alias getwork Get-Work

function Enter-Work {
    Set-Location C:/workspace
}
Set-Alias work Enter-Work

function FindAndOpenSolution {
    param (
        [parameter(Mandatory = $true)]
        [string]$name
    )

    $rootDir = $env:WORKSPACE_ROOT
    $subDirs = @()
    $foundRepos = @()

    foreach($subDir in $subDirs) {
        Write-Host "Searching in '$subDir'"
        $dirPath = Join-Path $rootDir = -ChildPath $subDir
        if (Test-Path -Path $dirPath) {
            $repos = Get-ChildItem -Path $dirPath -Directory | Where-Object { $_Name -like "*$name*" }
            $foundRepos += $repos
        }
    }

    if ($foundRepos.count -eq 0) {
        Write-Host "No repository found with the name '$name'."
        return    
    }
    elseif ($foundRepos.Count -gt 1) {
        Write-Host "Multiple repositories found with the name '$name'. Please refine your search."
        $foundRepos | ForEach-Object { Write-Host $_.FullName }
        return
    }

    $targetRepo = $foundRepos[0]
    $solutionFile = Get-ChildItem -Path $targetRepo.FullName -Filter '*.sln' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

    if ($solutionFile) {
        Write-Host "opening solution: $($solutionFile.FullName)"
        Start-Process -FilePath $solutionFile.FullName
    }
    else {
        Write-Host "No solution (.sln) file found in repository '$name'."
    }
}
Set-Alias project FindAndOpenSolution

function New-DotNetProject {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProjectName,
        [Parameter(Mandatory = $true)]
        [string]$ProjectType
    )
    $devopsRoot = $env:WORKSPACE_ROOT
    if (-not $devopsRoot) { $devopsRoot = 'C:\workspace' }
    $targetPath = Join-Path $devopsRoot $ProjectName
    dotnet new $ProjectType -n $ProjectName -o $targetPath
}
Set-Alias newproject New-DotNetProject



Write-Host "Profile script updated."