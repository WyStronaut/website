param(
    [string]$SourceDir = "src\tex\",
    [string]$SiteDir = "site",
    [string]$PagesSubDir = "mathmlmj",
    [string]$InputSubDir = "input",          # optional subfolder under SourceDir (directory mode only)
    [switch]$Recurse = $true,
    [switch]$Clean = $true,
    [switch]$BuildInPlace = $false,          # if set, run make4ht in the source file's folder (preserves relative includes/packages)
    [switch]$AllowMake4htErrors = $false     # if set, continue when make4ht exits nonzero but HTML output exists
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "[build] $Message"
}

function Ensure-Dir {
    param([string]$Path)
    if (!(Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Get-RelativePathSafe {
    param(
        [Parameter(Mandatory = $true)][string]$BasePath,
        [Parameter(Mandatory = $true)][string]$TargetPath
    )

    $baseFull = [System.IO.Path]::GetFullPath($BasePath)
    $targetFull = [System.IO.Path]::GetFullPath($TargetPath)

    $sep = [string][System.IO.Path]::DirectorySeparatorChar
    if (-not $baseFull.EndsWith($sep)) {
        $baseFull = $baseFull + $sep
    }

    $baseUri = [System.Uri]::new($baseFull)
    $targetUri = [System.Uri]::new($targetFull)
    $relativeUri = $baseUri.MakeRelativeUri($targetUri)

    [System.Uri]::UnescapeDataString($relativeUri.ToString()) -replace '/', '\'
}

function Get-CommonPathPrefix {
    param(
        [Parameter(Mandatory = $true)][string]$PathA,
        [Parameter(Mandatory = $true)][string]$PathB
    )

    $a = [System.IO.Path]::GetFullPath($PathA)
    $b = [System.IO.Path]::GetFullPath($PathB)

    $sep = [System.IO.Path]::DirectorySeparatorChar
    $partsA = $a.TrimEnd($sep) -split '[\\/]'
    $partsB = $b.TrimEnd($sep) -split '[\\/]'

    $count = [Math]::Min($partsA.Length, $partsB.Length)
    $common = New-Object System.Collections.Generic.List[string]

    for ($i = 0; $i -lt $count; $i++) {
        if ($partsA[$i].ToLowerInvariant() -eq $partsB[$i].ToLowerInvariant()) {
            $common.Add($partsA[$i]) | Out-Null
        } else {
            break
        }
    }

    if ($common.Count -eq 0) { return $null }

    if ($common.Count -eq 1 -and $common[0] -match '^[A-Za-z]:$') {
        return "$($common[0])$sep"
    }

    ($common -join [string]$sep)
}

function Show-Make4htFailureDetails {
    param(
        [Parameter(Mandatory = $true)][string]$WorkDir,
        [Parameter(Mandatory = $true)][string]$BaseName,
        [Parameter(Mandatory = $true)][int]$ExitCode
    )

    Write-Host ""
    Write-Host "[build] make4ht failed for $BaseName.tex (exit code $ExitCode)"
    Write-Host "[build] Working folder: $WorkDir"

    $candidateLogs = @(
        (Join-Path $WorkDir "$BaseName.log"),
        (Join-Path $WorkDir "$BaseName.lg"),
        (Join-Path $WorkDir "$BaseName.tmp")
    )

    foreach ($logPath in $candidateLogs) {
        if (Test-Path -LiteralPath $logPath) {
            Write-Host "[build] --- Showing tail of $logPath ---"
            Get-Content -LiteralPath $logPath -Tail 120 -ErrorAction SilentlyContinue | ForEach-Object { Write-Host $_ }
            Write-Host "[build] --- End log tail ---"
        }
    }
}

function Cleanup-InPlaceBuildArtifacts {
    param(
        [Parameter(Mandatory = $true)][string]$WorkDir,
        [Parameter(Mandatory = $true)][string]$BaseName
    )

    # Remove common LaTeX / TeX4ht artifacts for THIS built file only.
    # Keep the generated .html and .css in source folder for inspection.
    $artifactExtensions = @(
        ".aux", ".dvi", ".idv", ".lg", ".log", ".tmp", ".xref",
        ".4ct", ".4tc", ".bcf", ".blg", ".out", ".toc", ".lof", ".lot",
        ".run.xml", ".fdb_latexmk", ".fls", ".xdv", ".pdf"
    )

    foreach ($ext in $artifactExtensions) {
        $artifactPath = Join-Path $WorkDir ($BaseName + $ext)
        if (Test-Path -LiteralPath $artifactPath -PathType Leaf) {
            Remove-Item -LiteralPath $artifactPath -Force -ErrorAction SilentlyContinue
        }
    }

    # Remove common TeX4ht image artifacts with basename prefix
    $prefixPatterns = @(
        "$BaseName-*.svg",
        "$BaseName*.svg",
        "$BaseName-*.png",
        "$BaseName*.png",
        "$BaseName-*.jpg",
        "$BaseName*.jpg",
        "$BaseName-*.jpeg",
        "$BaseName*.jpeg",
        "$BaseName-*.gif",
        "$BaseName*.gif"
    )

    foreach ($pattern in $prefixPatterns) {
        Get-ChildItem -Path $WorkDir -Filter $pattern -File -ErrorAction SilentlyContinue |
            Remove-Item -Force -ErrorAction SilentlyContinue
    }
}

# ------------------------------------------------------------
# Anchor all paths to the script location
# ------------------------------------------------------------
$ScriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

# ------------------------------------------------------------
# Derived paths (absolute)
# ------------------------------------------------------------
$SiteDirAbs     = if ([System.IO.Path]::IsPathRooted($SiteDir)) { $SiteDir } else { Join-Path $ScriptRoot $SiteDir }
$PagesOutputDir = Join-Path $SiteDirAbs $PagesSubDir
$AssetsDir      = Join-Path $PagesOutputDir "assets"
$BuildTempDir   = Join-Path $PagesOutputDir "build-temp"

# ------------------------------------------------------------
# Resolve source path (supports directory OR single .tex file)
# ------------------------------------------------------------
$SourcePathAbs = if ([System.IO.Path]::IsPathRooted($SourceDir)) {
    $SourceDir
} else {
    Join-Path $ScriptRoot $SourceDir
}

$sourceIsFile = $false
$resolvedSourceFull = $null      # base used for relative output mapping
$singleTexFile = $null

if (Test-Path -LiteralPath $SourcePathAbs -PathType Leaf) {
    if ([System.IO.Path]::GetExtension($SourcePathAbs).ToLowerInvariant() -ne ".tex") {
        Write-Host "Source file is not a .tex file: $SourcePathAbs"
        exit 1
    }

    $sourceIsFile = $true
    $singleTexFile = Get-Item -LiteralPath $SourcePathAbs

    $singleFileDir = $singleTexFile.Directory.FullName
    $commonBase = Get-CommonPathPrefix -PathA $ScriptRoot -PathB $singleFileDir

    if ($null -ne $commonBase -and (Test-Path -LiteralPath $commonBase -PathType Container)) {
        $resolvedSourceFull = (Resolve-Path -LiteralPath $commonBase).Path
    } else {
        $resolvedSourceFull = $singleFileDir
    }
}
elseif (Test-Path -LiteralPath $SourcePathAbs -PathType Container) {
    $resolvedSource = $SourcePathAbs
    $candidateInput = Join-Path $SourcePathAbs $InputSubDir

    if (Test-Path -LiteralPath $candidateInput -PathType Container) {
        $resolvedSource = $candidateInput
    }

    $resolvedSourceFull = (Resolve-Path -LiteralPath $resolvedSource).Path
}
else {
    Write-Host "Source path not found: $SourcePathAbs"
    exit 1
}

$repoRootFull = (Resolve-Path -LiteralPath $ScriptRoot).Path

# ------------------------------------------------------------
# Validate tool
# ------------------------------------------------------------
$make4htCmd = Get-Command make4ht -ErrorAction SilentlyContinue
if (-not $make4htCmd) {
    Write-Host "make4ht not found in PATH. Install TeX4ht/make4ht and try again."
    exit 1
}

# ------------------------------------------------------------
# Ensure output folders exist
# ------------------------------------------------------------
Ensure-Dir $SiteDirAbs
Ensure-Dir $PagesOutputDir
Ensure-Dir $AssetsDir
Ensure-Dir $BuildTempDir

# ------------------------------------------------------------
# Clean generated output (keeps root landing page untouched)
# ------------------------------------------------------------
if ($Clean) {
    Write-Step "Cleaning generated files in $SiteDirAbs"

    Get-ChildItem -Path $PagesOutputDir -Filter "*.html" -File -Recurse -ErrorAction SilentlyContinue |
        Remove-Item -Force -ErrorAction SilentlyContinue

    $generatedSiteIndex = Join-Path $SiteDirAbs "index.html"
    if (Test-Path -LiteralPath $generatedSiteIndex) {
        Remove-Item -LiteralPath $generatedSiteIndex -Force -ErrorAction SilentlyContinue
    }

    Get-ChildItem -Path $BuildTempDir -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

# ------------------------------------------------------------
# Find .tex files (array-normalized)
# ------------------------------------------------------------
if ($sourceIsFile) {
    $texFiles = @($singleTexFile)
}
else {
    if ($Recurse) {
        $texFiles = @(Get-ChildItem -Path $resolvedSourceFull -Filter "*.tex" -File -Recurse)
    } else {
        $texFiles = @(Get-ChildItem -Path $resolvedSourceFull -Filter "*.tex" -File)
    }
}

if ($texFiles.Count -eq 0) {
    if ($sourceIsFile) {
        Write-Host "No .tex file found at '$SourcePathAbs'."
    } else {
        Write-Host "No .tex files found in '$resolvedSourceFull'."
    }
    exit 0
}

if ($sourceIsFile) {
    Write-Step "Building single file: $($singleTexFile.FullName)"
    Write-Step "Single-file output base (preserved path root): $resolvedSourceFull"
} else {
    Write-Step "Found $($texFiles.Count) .tex file(s) in $resolvedSourceFull"
}

if ($BuildInPlace) {
    Write-Step "Build mode: in-place (preserves relative includes/packages)"
} else {
    Write-Step "Build mode: temp copy (isolated)"
}

if ($AllowMake4htErrors) {
    Write-Step "Error policy: relaxed (continue if HTML exists despite nonzero make4ht exit code)"
} else {
    Write-Step "Error policy: strict (nonzero make4ht exit code fails build)"
}

# ------------------------------------------------------------
# Build files with make4ht (mathml,mathjax, LuaLaTeX)
# Preserve source folder structure under site\mathmlmj\
# ------------------------------------------------------------
$navItems = @()

foreach ($file in $texFiles) {
    $name = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

    $relativeTexPath = Get-RelativePathSafe -BasePath $resolvedSourceFull -TargetPath $file.FullName
    if ($relativeTexPath.StartsWith("..\")) {
        $relativeTexPath = $file.Name
    }

    $relativeFolder = Split-Path -Path $relativeTexPath -Parent
    if ($null -eq $relativeFolder -or $relativeFolder -eq ".") {
        $relativeFolder = ""
    }

    $relativeHtmlPath = [System.IO.Path]::ChangeExtension($relativeTexPath, ".html")
    $finalHtml = Join-Path $PagesOutputDir $relativeHtmlPath
    $finalHtmlDir = Split-Path -Path $finalHtml -Parent
    Ensure-Dir $finalHtmlDir

    # temp path (used only when not building in place)
    $tempBuildSubPath = if ([string]::IsNullOrWhiteSpace($relativeFolder)) { $name } else { Join-Path $relativeFolder $name }
    $tempDir = Join-Path $BuildTempDir $tempBuildSubPath

    if ($BuildInPlace) {
        $workDir = $file.DirectoryName
        Write-Step "Building in place: $relativeTexPath"
    } else {
        Ensure-Dir $tempDir
        $workDir = $tempDir
        Write-Step "Building (temp) $relativeTexPath"
    }

    Push-Location $workDir
    try {
        if (-not $BuildInPlace) {
            # Copy .tex source into isolated temp folder
            Copy-Item -LiteralPath $file.FullName -Destination $file.Name -Force

            # Copy same-basename companion files if present in source folder
            $sourceFolder = $file.DirectoryName
            $possibleCompanions = @(
                "$name.sty", "$name.cls", "$name.bib", "$name.cfg", "$name.mk4"
            )

            foreach ($comp in $possibleCompanions) {
                $compPath = Join-Path $sourceFolder $comp
                if (Test-Path -LiteralPath $compPath) {
                    Copy-Item -LiteralPath $compPath -Destination $comp -Force
                }
            }
        }

        # Use LuaLaTeX + UTF-8 via combined short options (-ul)
        & make4ht -ul $file.Name "mathml,mathjax"
        $make4htExit = $LASTEXITCODE

        $builtHtml = Join-Path $workDir "$name.html"

        if ($make4htExit -ne 0) {
            Show-Make4htFailureDetails -WorkDir $workDir -BaseName $name -ExitCode $make4htExit

            if ($AllowMake4htErrors -and (Test-Path -LiteralPath $builtHtml)) {
                Write-Step "WARNING: make4ht returned exit code $make4htExit, but HTML was produced. Continuing because -AllowMake4htErrors is enabled."
            } else {
                throw "make4ht failed for $($file.Name) (exit code $make4htExit)"
            }
        }

        if (!(Test-Path -LiteralPath $builtHtml)) {
            throw "Expected output not found: $builtHtml"
        }

        # Copy generated HTML to final destination
        Copy-Item -LiteralPath $builtHtml -Destination $finalHtml -Force

        # Copy assets from working folder (flat assets folder in site\mathmlmj\assets)
        $generatedAssets = Get-ChildItem -Path $workDir -File -ErrorAction SilentlyContinue |
            Where-Object { $_.Extension -in @(".css", ".js", ".png", ".svg", ".woff", ".woff2", ".ttf") }

        foreach ($asset in $generatedAssets) {
            Copy-Item -LiteralPath $asset.FullName -Destination (Join-Path $AssetsDir $asset.Name) -Force
        }

        # Nav metadata for generated site\index.html
        $relativeSourceDisplay = ".\" + (Get-RelativePathSafe -BasePath $repoRootFull -TargetPath $file.FullName)
        $outputHref = ($PagesSubDir + "/" + ($relativeHtmlPath -replace '\\','/'))

        $navItems += [PSCustomObject]@{
            Name       = $name
            Source     = $relativeSourceDisplay
            OutputHref = $outputHref
            OutputPath = $relativeHtmlPath
        }

        Write-Step "Built $relativeTexPath -> $finalHtml"

        if ($BuildInPlace) {
            Cleanup-InPlaceBuildArtifacts -WorkDir $workDir -BaseName $name
            Write-Step "Cleaned in-place build artifacts in $workDir (kept $name.html and $name.css if present)"
        }
    }
    finally {
        Pop-Location
    }
}

# ------------------------------------------------------------
# Generate site\index.html (index of generated pages)
# ------------------------------------------------------------
Write-Step "Generating $(Join-Path $SiteDirAbs 'index.html')"

$listItems = ($navItems | Sort-Object OutputPath | ForEach-Object {
@"
      <li>
        <a href="$($_.OutputHref)">$($_.Name)</a><br>
        <small>Output: <code>$($_.OutputPath -replace '\\','/')</code></small><br>
        <small>Source: <code>$($_.Source)</code></small>
      </li>
"@
}) -join "`n"

$indexHtml = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Generated Math Content</title>
</head>
<body>
  <main>
    <h1>Generated Math Content</h1>
    <p>Auto-generated by build.ps1 (tex4ht / make4ht workflow).</p>

    <h2>Available Files</h2>
    <ul>
$listItems
    </ul>

    <p><a href="../index.html">Return to Main Homepage</a></p>
  </main>
</body>
</html>
"@

Set-Content -Path (Join-Path $SiteDirAbs "index.html") -Value $indexHtml -Encoding UTF8

Write-Step "Build complete."
Write-Step "Generated index: $(Join-Path $SiteDirAbs 'index.html')"
Write-Step "Generated pages root: $PagesOutputDir"