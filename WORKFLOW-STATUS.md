# Workflow Status

## Current Active Baseline (Week 1)

- **Conversion pipeline:** tex4ht / make4ht
- **Selected output mode:** mathml,mathjax
- **Primary objective:** accessible LaTeX-to-HTML conversion for mathematics study with Firefox + NVDA
- **Current active experiment folder:** experiments/latexml  
  (temporary folder name retained from initial LaTeXML setup attempt; currently used for tex4ht experiments after pivot)
- **Current active evidence folder:** evidence/week1-latexml

## What Is Currently Displayed on the Website

- The previous Pandoc-rendered website is **not** the active display baseline.
- Root index.html is currently a **placeholder page** during workflow transition.
- The current file system is being retained temporarily so that existing paths and experiments are not disrupted while tex4ht conversion is being stabilized.

## Previous Exploratory Path (Week 0)

- A Pandoc-based conversion workflow was explored first as a rapid prototyping path.
- Pandoc findings are being retained as evidence of tool evaluation and as rationale for the workflow pivot.
- The Pandoc-era materials are currently spread across:
  - docs
  - filters
  - html
  - templates
  - tex

## Why the Pandoc Findings Are Kept

- They document a real scalability issue across heterogeneous source TeX files.
- They justify the pivot from Pandoc to tex4ht.
- They may still be useful later for:
  - simple files
  - quick prototypes
  - comparison in the final report / appeal evidence

## Week 1 tex4ht Findings (Current Direction)

- make4ht is working on the local setup (Windows 11 + TeX Live 2025).
- The pipeline can generate HTML with MathML in source HTML.
- mathml,mathjax was selected as the current baseline after smoke-test comparison.
- Theorem/proof containers are present in generated HTML, but heading-based discoverability is still an open issue (planned post-processing step).

## Foreseeable Structural Changes

- The repository will likely move away from a dual-pipeline comparison structure once tex4ht conversion is stable enough.
- The current file system may be reused, but with clearer separation of:
  - active tex4ht workflow
  - archived Pandoc exploration findings
  - published site output
- experiments/latexml may be renamed later to reflect actual tex4ht usage.

## Where to Look for Current Progress

- **Week 1 setup and test evidence:** evidence/week1-latexml
- **Current conversion experiments:** experiments/latexml
- **Checkpoint summary:** evidence/week1-latexml/week1-checkpoint-note.md

## Status Summary

- **Current baseline:** tex4ht / make4ht (mathml,mathjax)
- **Pandoc status:** retained as historical findings / pivot rationale
- **Website root page:** placeholder during transition
- **Next milestone:** test a more complex real .tex file and document conversion + accessibility results