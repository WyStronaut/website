# Week 1 — Testing Log

Chronological record of all conversion tests and NVDA evaluations.

---

## Part 1: Smoke Test (24/02/2026)

**Goal:** Confirm make4ht works locally and find the right output mode for screen reader maths.

**Test file:** `smoke-test.tex` — short LaTeX file with headings, a theorem containing `2a^2`, and inline/display maths.

### Default mode

```powershell
make4ht -u -a debug -d .\output\smoke-test smoke-test.tex
```

HTML generated successfully. But maths was not accessible — `a^2` read as "a two" instead of "a squared" by NVDA. Equations inside proofs announced as graphical objects rather than readable maths. Headings navigable but theorem/proof blocks not recognised as headings.

**Verdict:** Pipeline works, but default output mode is unusable for screen reader maths.

### MathML mode

```powershell
make4ht -u -a debug -e accessibility-prelim.mk4 -d .\output\smoke-test-mathml smoke-test.tex "mathml"
```

Maths reading improved. Source HTML contains `<math>`, `<mrow>`, `<msup>` etc.

### MathML + MathJax mode

```powershell
make4ht -u -a debug -e accessibility-prelim.mk4 -d .\output\smoke-test-mathml-mj smoke-test.tex "mathml,mathjax"
```

Similar NVDA behaviour to pure MathML for this small test, but includes MathJax script (`mml-chtml.js`) for rendering. MathML preserved in source HTML.

**Decision:** Selected `mathml,mathjax` as baseline — preserves inspectable MathML while providing MathJax rendering support.

### Other observations from smoke test

- `div.newtheorem` and `div.proof` containers present in HTML — promising for future post-processing.
- Deleted the pure MathML output; kept only `mathml,mathjax` output.

---

## Part 2: Full Document Test — IA Numbers and Sets (25/02/2026)

**Source:** `cambridge-maths-notes/ia/ns/main.tex` (Chapters 1–7, 39 pages)

```powershell
make4ht main.tex "mathml,mathjax"
```

### Build issues and fixes

**`unicode-math` broke everything.** The source uses `unicode-math` in `util.sty`. This caused HTML conversion to fail. Removed it and restored the classical AMS stack (`amsmath`, `amssymb`, `amsthm`). Stable after that.

**Exit code 1 — non-blocking.** tex4ht's Lua DOM post-processing hits `Unbalanced Tag (/mtable)` on large aligned MathML structures, causing a stack overflow. Falls back to HTML DOM. The generated HTML is unaffected — this is a post-processing stage failure only.

Compared all three modes on the real document:
- Pure `mathml`: good MathML structure, exit code 1 from DOM instability
- Pure `mathjax`: exit code 0, but some raw TeX fragments leak through
- Hybrid `mathml,mathjax`: best combined result — clean maths, no TeX leakage, interactive navigation. Exit code 1 inherited from above.

**Decision:** Confirmed `mathml,mathjax` as the baseline mode.

### NVDA evaluation

**Maths — works well:**
- Inline and display maths read correctly.
- `align` environments announce correct line count; arrow keys navigate between lines.
- Fractions read with numerator/denominator separation.
- Intermediate zoom gives operator-level traversal.
- Deep structural exploration without duplication.
- No raw TeX fragments, no skipped operators.
- Custom macros render and read correctly after AMS stack restoration.

**Lists — broken:**
- Enumerated lists render as `<dl class="enumerate-enumitem">` with `<dt>`/`<dd>` pairs.
- NVDA reports wrong item counts. List navigation doesn't work as expected.

**Theorem blocks — readable but not navigable:**
- Definitions, theorems, claims, proofs all read correctly in linear order.
- Proof endings identifiable (white square symbol announced).
- But no structural landmarks — can't jump between theorem blocks with NVDA shortcuts.

**Headings — minor gap:**
- h1 (title), h3 (chapters), h4 (sections). No h2.

**Everything else:**
- Page title correct, CSS loads, internal links work.
- Reading flow is coherent top-to-bottom, no junk text.

---

## Week 1 issues to carry forward

1. **Lists:** `dl/dt/dd` → needs `ol/li` (priority — most disruptive to actual reading)
2. **Theorem blocks:** need structural grouping for navigation
3. **Heading gap:** missing h2 level (low priority)
4. **DOM post-processing:** known tex4ht limitation, non-blocking, no fix available
