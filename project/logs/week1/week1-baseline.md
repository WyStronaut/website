# Week 1 — Baseline Build and NVDA Inspection

Full HTML build and screen reader test of the Numbers and Sets notes (`main.tex`, 39 pages).
No semantic enhancements applied — this documents what make4ht produces out of the box.

**Date:** 25/02/2026
**Environment:** Windows 11 24H2, TeX Live 2025, make4ht v0.4d, NVDA, Firefox

---

## How I got here

Two earlier attempts shaped the current approach.

**Pandoc worked — until it didn't.** I initially used Pandoc for LaTeX → HTML conversion. It handled Chapter 1 of Numbers and Sets successfully, but broke on later chapters with more complex mathematical structures. The output was incomplete and the failures weren't easy to diagnose or fix. This led me to tex4ht/make4ht, which is purpose-built for TeX conversion and handles the full range of LaTeX environments.

**Source quality matters.** Before settling on the zeramorphic Cambridge notes, I attempted to convert a different LaTeX source that was poorly written — inconsistent macros, errors throughout, non-standard structures. The HTML output was broken in ways that no amount of post-processing could fix. This taught me that the pipeline needs a minimum standard of source quality to produce usable output. The zeramorphic notes are well-structured, consistent, and use standard LaTeX packages, which is why they work well as test material.

---

## Build

```
make4ht main.tex "mathml,mathjax"
```

Exit code 1 — but the HTML output is fine. The error comes from tex4ht's Lua DOM post-processing choking on large aligned MathML structures (`Unbalanced Tag (/mtable)` → stack overflow). This only affects post-processing, not the generated HTML itself.

**Key fix during setup:** `unicode-math` in `util.sty` broke HTML conversion entirely. Replaced it with the classical AMS math stack (`amsmath`, `amssymb`, `amsthm`). Stable after that.

---

## What works well

**Maths is genuinely accessible.** The hybrid MathML + MathJax mode is the right choice:

- Inline and display maths both read correctly in NVDA.
- `align` environments announce the correct number of lines; arrow keys move between them.
- Fractions read with clear numerator/denominator separation.
- Intermediate zoom gives operator-level traversal — you can step through an expression term by term.
- Deep structural exploration works without duplication or skipped operators.
- No raw TeX fragments leak into the speech output.

This is the core result: 39 pages of real maths content, readable with a screen reader.

---

## What needs fixing

### 1. Lists are broken (priority)

Enumerated lists render as `<dl>` with `<dt>`/`<dd>` pairs instead of `<ol>`/`<li>`. NVDA reports wrong item counts and list navigation doesn't work as expected. This is a tex4ht output issue, not a build failure — the content is there, but the HTML semantics are wrong.

### 2. Theorem blocks aren't navigable

Theorem, definition, and proof environments render as styled `<div>` containers with inline heading text. They're readable in linear order, but NVDA can't jump between them — they're not exposed as headings, landmarks, or regions. For a 39-page document, this means you have to read sequentially to find a specific theorem.

### 3. Heading hierarchy has a gap

The output has h1 (title), h3 (chapters), h4 (sections) — but no h2. Not a blocker, but worth normalising.

---

## Fixes applied

1. Removed `unicode-math` from `util.sty`, restored AMS math stack.
2. Validated MathML generation with large aligned structures.
3. Selected `mathml,mathjax` hybrid mode over pure MathML (pure mode triggers the post-processing crash more aggressively and lacks MathJax's interactive navigation).

---

## Next: Week 2

Fix list semantics first — that's the most disruptive issue for actual reading. Then investigate whether theorem blocks can be given semantic structure via tex4ht configuration or HTML post-processing.
