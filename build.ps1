# Create html folder if it doesn't exist
if (!(Test-Path "html")) {
    New-Item -ItemType Directory -Path "html"
}

# Get all .tex files inside tex folder
$texFiles = Get-ChildItem -Path "tex" -Filter "*.tex"

foreach ($file in $texFiles) {

    $name = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

    Write-Host "Building $name..."

    # MathML version
    pandoc $file.FullName -s -t html5 --mathml -o "html/$name-mathml.html"

    # MathJax version
    pandoc $file.FullName -s --mathjax -o "html/$name-mathjax.html"
}

Write-Host "Build complete."