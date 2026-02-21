# Ensure required folders exist
$folders = @("html", "html/mathml", "html/mathjax")

foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }
}

# CLEAN OUTPUT FOLDERS (correctness mode)
Get-ChildItem "html/mathml" -Filter "*.html" | Remove-Item -Force
Get-ChildItem "html/mathjax" -Filter "*.html" | Remove-Item -Force

# Get all .tex files
$texFiles = Get-ChildItem -Path "tex" -Filter "*.tex"

# Navigation items
$navItems = @()

foreach ($file in $texFiles) {

    $name = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

    Write-Host "Building $name..."

    # MathML version
    pandoc $file.FullName -s -t html5 --mathml `
        -o "html/mathml/$name-mathml.html"

    # MathJax version
    pandoc $file.FullName -s --mathjax `
        -o "html/mathjax/$name-mathjax.html"

    # Add navigation entry
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

# Generate html/index.html
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

Set-Content -Path "html/index.html" -Value $indexContent

Write-Host "Clean build complete."