# Workflow Status

## Current Active Baseline (Week 1)

- **Conversion pipeline:** tex4ht / make4ht
- **Selected output mode:** `mathml,mathjax`
- **Primary objective:** accessible LaTeX-to-HTML conversion for mathematics study with Firefox + NVDA
- **Current active experiment folder:** `experiments/tex4ht/`
- **Current active evidence folder:** `evidence/week1-tex4ht/`

## What Is Currently Displayed on the Website

- The previous Pandoc-rendered website is **not** the active display baseline.
- Root `index.html` is currently a **placeholder page** during workflow transition.
- Existing paths and generated outputs are being reorganized so that active tex4ht work and archived Pandoc findings are clearly separated.

## Current Repository Structure (Canonical Paths)

- `experiments/tex4ht/` — active tex4ht workflow experiments and conversion tests
- `evidence/week1-tex4ht/` — week 1 evidence outputs / validation artifacts
- `archive/pandoc-exploration/` — archived Pandoc-era experiments and related notes
- `html/` — generated site pages / output (candidate future rename: `public/` or `site-output/`)
- `index.html` — root landing / placeholder page during reconstruction
- `WORKFLOW-STATUS.md` — migration notes and current workflow status

## Previous Exploratory Path (Pandoc Era)

- A Pandoc-based conversion workflow was explored first as a rapid prototyping path.
- Pandoc findings are retained as evidence of tool evaluation and as rationale for the workflow pivot.
- Pandoc-era materials are now consolidated under:
  - `archive/pandoc-exploration/`

## Why the Pandoc Findings Are Kept

- They document real conversion/scalability issues across heterogeneous source TeX files.
- They justify the pivot from Pandoc to tex4ht.
- They remain useful for:
  - simple files
  - quick prototypes
  - comparison in the final report / appeal evidence

## Week 1 tex4ht Findings (Current Direction)

- `make4ht` is working on the local setup (Windows + TeX Live).
- The pipeline can generate HTML with MathML in the source HTML.
- `mathml,mathjax` is the current baseline after smoke-test comparison.
- Theorem/proof containers are present in generated HTML, but heading-based discoverability remains an open issue (planned post-processing step).

## Foreseeable Structural Changes

- The repo may later be reorganized further to separate:
  - active tex4ht workflow
  - archived Pandoc exploration findings
  - published site output
- `html/` may be renamed later to better indicate generated/published output.

## Where to Look for Current Progress

- **Current conversion experiments:** `experiments/tex4ht/`
- **Week 1 evidence / outputs:** `evidence/week1-tex4ht/`
- **Archived Pandoc findings:** `archive/pandoc-exploration/`
- **Generated site output:** `html/`
- **Checkpoint / migration notes:** `WORKFLOW-STATUS.md`

## Status Summary

- **Current baseline:** tex4ht / make4ht (`mathml,mathjax`)
- **Pandoc status:** archived as historical findings / pivot rationale
- **Website root page:** placeholder during transition
- **Next milestone:** test a more complex real `.tex` file and document conversion + accessibility results