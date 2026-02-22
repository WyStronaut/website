# WyStronaut Website

> **Disclaimer**
>  
> This project is currently **vibe-coded with ChatGPT-5** and optimized for a personal accessibility workflow.
>  
> It is functional for the current repository and source material, but **use caution when scaling it** to larger note sets, different TeX sources, or more automated deployment workflows.
>  
> Before scaling, it is recommended to review and strengthen:
> - build script assumptions and path handling
> - custom macro coverage (especially upstream `util.sty`-style commands)
> - Pandoc conversion edge cases
> - accessibility testing coverage across browser/screen-reader combinations
> - error handling and reproducibility

A static GitHub Pages-style website for **accessible mathematics content**, with generated HTML pages in two formats:

- **MathJax version** (primary; currently the main tested experience)
- **MathML version** (fallback / alternative rendering path)

The site includes a root homepage (`index.html`) and an auto-generated index of converted pages (`html/index.html`).

---

## Repository Structure

- `index.html` — main homepage (root)
- `build.ps1` — PowerShell build script for generating HTML from `.tex`
- `filters/theorem_blocks_to_headings.lua` — Pandoc Lua filter that converts theorem-like blocks into heading-based structure
- `templates/template.html` — shared Pandoc HTML template used for generated pages
- `templates/mathjax-macros.html` — MathJax macro definitions for upstream custom TeX commands (recommended for MathJax builds)
- `html/` — generated output (includes `mathml/`, `mathjax/`, and auto-generated `html/index.html`)
- `accessible-math-writing-checklist.html` — notes/checklist for accessible math authoring

---

## What This Project Does

This project converts LaTeX (`.tex`) math notes into accessible HTML using **Pandoc**, producing:

- a **MathJax build** (`html/mathjax/...`) — **primary output**
- a **MathML build** (`html/mathml/...`) — **fallback / alternative output**

The build script also regenerates a navigation page at `html/index.html` listing links to both versions for every source file.

---

## Source Notes

The current converted HTML files are generated from TeX notes in:

- `zeramorphic/cambridge-maths-notes`, folder `ia/ns`

These source `.tex` files are external to this repository and are passed to the build script via the `sourceDir` parameter.

---

## Accessibility and Testing Status

This repo is focused on making mathematical content easier to navigate and consume, especially for screen-reader users.

### Current testing status

- ✅ **MathJax HTML is NVDA-tested with Firefox**
- ⚠️ **MathML HTML is generated as a fallback/alternative, but is not yet NVDA-tested to the same extent**

### Accessibility-oriented design choices

1. **Heading-based navigation for theorem-like content** via a Pandoc Lua filter, improving navigation with screen-reader heading shortcuts
2. **Parallel output formats** (MathJax primary, MathML fallback) to support different browser/screen-reader behavior

The included `accessible-math-writing-checklist.html` is intended as a practical guide while preparing source material.

---

## Requirements

- **PowerShell** (Windows PowerShell or PowerShell 7+)
- **Pandoc** installed and available on `PATH`

Optional but recommended:

- **Firefox + NVDA** (the currently tested combination)

---

## Build Usage

By default, the script expects a local `tex` folder in this repository:

```powershell
.\build.ps1
