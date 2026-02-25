# Week 1 Checkpoint Note — tex4ht Baseline Feasibility and Accessibility Testing

## Summary

Week 1 focused on establishing a workable and testable LaTeX-to-HTML conversion baseline for accessible mathematics study using Firefox + NVDA.

I initially intended to explore a LaTeXML-based path, but installation difficulties delayed practical testing. To avoid losing momentum, I pivoted to tex4ht/make4ht, which was already available through my TeX Live 2025 installation. This was a pragmatic decision to prioritize immediate feasibility testing over tool preference.

## What was completed

I successfully set up and ran a reproducible make4ht conversion workflow on a smoke-test LaTeX file and tested the generated HTML with NVDA in Firefox.

Three output modes were evaluated:

- default conversion mode
- mathml
- mathml,mathjax

The default mode generated HTML successfully, but math accessibility was not acceptable for screen reader use (for example, superscripts were read incorrectly and some proof equations were treated as graphical objects).

After testing mathml and mathml,mathjax, I selected mathml,mathjax as the Week 1 baseline because it:

- preserves MathML in the source HTML (<math>...</math>)
- improves NVDA + Firefox math reading behavior in testing
- provides a more robust rendering path while retaining inspectable math structure

## Key findings

- make4ht is working reliably on my local setup (Windows 11 + TeX Live 2025).
- The pipeline can produce HTML output with MathML and identifiable theorem/proof containers.
- Math accessibility improves significantly when using mathml,mathjax compared with the default mode.
- Theorem/proof blocks are present in the HTML structure but are not yet exposed as navigable headings for screen-reader shortcut navigation.

## Remaining issue identified in Week 1

The main unresolved issue is structural discoverability of theorem/proof blocks. This appears solvable via an HTML post-processing step (for example, inserting heading landmarks based on div.newtheorem / div.proof containers).

## Outcome of Week 1

Week 1 successfully established a feasible conversion baseline and a testing workflow (conversion + HTML inspection + NVDA evaluation). This de-risks the core technical question of whether parser-aware LaTeX conversion can produce inspectable math structures suitable for accessibility testing.

## Next step (Week 1 completion / transition to Week 2)

The next immediate step is to run the selected baseline command on a more complex real .tex file and document:

- conversion success/failure
- package/macro issues
- MathML presence
- NVDA math reading behavior
- theorem/proof structure discoverability