[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('Deploy', 'Undeploy')]
    [string]$Mode = 'Deploy',

    [string]$GameRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path,

    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$campaignId = 'falklands-infrastructure-test'
$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = (Resolve-Path (Join-Path $repositoryRoot "mod\campaigns\$campaignId")).Path
$streamingAssets = (Resolve-Path (Join-Path $GameRoot 'Sea Power_Data\StreamingAssets')).Path
$userCampaigns = Join-Path $streamingAssets 'user\campaigns'
$destination = Join-Path $userCampaigns $campaignId
$originalRoot = (Resolve-Path (Join-Path $streamingAssets 'original')).Path

$sourcePrefix = $source.TrimEnd('\') + '\'
$destinationPrefix = [System.IO.Path]::GetFullPath($destination).TrimEnd('\') + '\'
$userCampaignsPrefix = [System.IO.Path]::GetFullPath($userCampaigns).TrimEnd('\') + '\'
$originalPrefix = $originalRoot.TrimEnd('\') + '\'

if (-not $destinationPrefix.StartsWith($userCampaignsPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing operation: destination is outside the user campaigns folder: $destination"
}

if ($destinationPrefix.StartsWith($originalPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing operation: destination resolves inside StreamingAssets\original: $destination"
}

Write-Host "Mode:        $Mode"
Write-Host "Source:      $source"
Write-Host "Destination: $destination"
Write-Host "Dry run:     $($DryRun.IsPresent)"

if ($Mode -eq 'Undeploy') {
    if (-not (Test-Path -LiteralPath $destination)) {
        Write-Host 'Nothing to undeploy; exact destination does not exist.'
        return
    }

    if ($DryRun) {
        Write-Host "Would remove only: $destination"
        return
    }

    if ($PSCmdlet.ShouldProcess($destination, 'Remove exact disposable campaign deployment')) {
        Remove-Item -LiteralPath $destination -Recurse -Force
        Write-Host "Undeployed: $destination"
    }
    return
}

$sourceFiles = Get-ChildItem -LiteralPath $source -Recurse -File | Sort-Object FullName
if ($sourceFiles.Count -eq 0) {
    throw "No authored campaign files found below: $source"
}

# Task Force Mode preflight: a missing commander definition permits builder use
# but blocks mission launch with an empty Service Record nation selector.
$campaignFile = Join-Path $source 'campaign.ini'
$campaignText = Get-Content -LiteralPath $campaignFile -Raw
$commanderMatch = [regex]::Match($campaignText, '(?m)^CommanderSettingsFile\s*=\s*(?<path>[^;#\r\n]+?)\s*$')
if (-not $commanderMatch.Success) {
    throw 'Task Force Mode preflight failed: campaign.ini has no CommanderSettingsFile.'
}

$commanderRelativePath = $commanderMatch.Groups['path'].Value.Trim()
$commanderFile = Join-Path $source $commanderRelativePath
if (-not (Test-Path -LiteralPath $commanderFile -PathType Leaf)) {
    throw "Task Force Mode preflight failed: commander settings file does not exist: $commanderFile"
}

$commanderText = Get-Content -LiteralPath $commanderFile -Raw
$nationsMatch = [regex]::Match($commanderText, '(?m)^CommanderNations\s*=\s*(?<nations>[^;#\r\n]+?)\s*$')
if (-not $nationsMatch.Success -or [string]::IsNullOrWhiteSpace($nationsMatch.Groups['nations'].Value)) {
    throw 'Task Force Mode preflight failed: CommanderNations is missing or empty.'
}

$commanderNations = $nationsMatch.Groups['nations'].Value.Split('|', [System.StringSplitOptions]::RemoveEmptyEntries)
foreach ($nation in $commanderNations) {
    $escapedNation = [regex]::Escape($nation.Trim())
    if (-not [regex]::IsMatch($commanderText, "(?m)^$escapedNation\s*=.+$")) {
        throw "Task Force Mode preflight failed: [OfficerRanks] has no rank definition for nation '$($nation.Trim())'."
    }
}

Write-Host "Commander preflight: $($commanderNations.Count) nation(s) configured in $commanderRelativePath"

foreach ($file in $sourceFiles) {
    if (-not $file.FullName.StartsWith($sourcePrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing unexpected source file outside campaign tree: $($file.FullName)"
    }
    $relative = $file.FullName.Substring($sourcePrefix.Length)
    Write-Host "  $relative"
}

if ($DryRun) {
    Write-Host "Would copy $($sourceFiles.Count) authored files to the exact destination."
    return
}

if (-not (Test-Path -LiteralPath $userCampaigns)) {
    New-Item -ItemType Directory -Path $userCampaigns | Out-Null
}

if (Test-Path -LiteralPath $destination) {
    if ($PSCmdlet.ShouldProcess($destination, 'Replace exact disposable campaign deployment')) {
        Remove-Item -LiteralPath $destination -Recurse -Force
    }
}

if ($PSCmdlet.ShouldProcess($destination, 'Deploy authored disposable campaign')) {
    New-Item -ItemType Directory -Path $destination | Out-Null
    Copy-Item -Path (Join-Path $source '*') -Destination $destination -Recurse -Force
}

$deployedFiles = Get-ChildItem -LiteralPath $destination -Recurse -File
if ($deployedFiles.Count -ne $sourceFiles.Count) {
    throw "Deployment verification failed: source has $($sourceFiles.Count) files; destination has $($deployedFiles.Count)."
}

Write-Host "Deployed $($deployedFiles.Count) files to: $destination"
