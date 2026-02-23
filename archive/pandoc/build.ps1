param(
    [string]$sourceDir = "tex"
)

# ----------------------------
# Validate source directory
# ----------------------------
if (!(Test-Path $sourceDir)) {
    Write-Host "Source directory '$sourceDir' not found."
    exit 1
}

# ----------------------------
# Ensure required output folders exist
# ----------------------------
$folders = @("html", "html/mathml", "html/mathjax")

foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }
}

# ----------------------------
# Clean output folders (deterministic builds)
# ----------------------------
Get-ChildItem "html/mathml" -Filter "*.html" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem "html/mathjax" -Filter "*.html" -ErrorAction SilentlyContinue | Remove-Item -Force

# ----------------------------
# Get all .tex files from source directory
# ----------------------------
$texFiles = Get-ChildItem -Path $sourceDir -Filter "*.tex"

if ($texFiles.Count -eq 0) {
    Write-Host "No .tex files found in '$sourceDir'."
    exit 0
}

# ----------------------------
# Navigation items for generated index
# ----------------------------
$navItems = @()

foreach ($file in $texFiles) {

    $name = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    Write-Host "Building $name..."

    # ----------------------------
    # MathML version
    # ----------------------------
    pandoc $file.FullName -s -t html5 --mathml `
      --template=templates/template.html `
      --lua-filter=filters/theorem_blocks_to_headings.lua `
      -M "title=$name (MathML Version)" `
      -M "basename=$name" `
      -M mathml=true `
      -o "html/mathml/$name-mathml.html"

    # ----------------------------
    # MathJax version
    # ----------------------------
    pandoc $file.FullName -s --mathjax `
      --template=templates/template.html `
      --include-in-header=templates/mathjax-macros.html `
      --lua-filter=filters/theorem_blocks_to_headings.lua `
      -M "title=$name (MathJax Version)" `
      -M "basename=$name" `
      -M mathjax=true `
      -o "html/mathjax/$name-mathjax.html"

    # ----------------------------
    # Add entry to generated index
    # ----------------------------
    $navItems += @"
<li>
  $name
  <ul>
    <li><a href="mathml/$name-mathml.html">MathML Version</a></li>
    <li><a href="mathjax/$name-mathjax.html">MathJax Version</a></li>
  </ul>
</li>
"@
}

# ----------------------------
# Generate html/index.html
# ----------------------------
$indexContent = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Generated Math Content</title>
</head>

<body>

<a href="#main">Skip to main content</a>

<header>
<h1>Generated Math Content</h1>
<p>This page is auto-generated.</p>
</header>

<main id="main">
<h2>Available Files</h2>

<ul>
$($navItems -join "`n")
</ul>

</main>

<footer>
<p><a href="../index.html">Return to Main Homepage</a></p>
</footer>

</body>
</html>
"@

Set-Content -Path "html/index.html" -Value $indexContent -Encoding UTF8

Write-Host "Clean build complete."