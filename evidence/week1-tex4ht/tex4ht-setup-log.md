# Week 1 tex4ht / make4ht Prelim Setup Log

* **Date:** 24/02/2026
* **OS:** Windows 11 Home 24H2 (Build 26100)
* **TeX distribution:** TeX Live 2025
* **make4ht version:** v0.4d
* **Test file:** `experiments/latexml/smoke-test.tex`

---

## Goal

Establish a working tex4ht/make4ht conversion baseline for LaTeX → HTML and test accessibility behavior in **Firefox + NVDA**, with particular focus on:

* heading navigation
* inline/display math reading
* theorem/proof discoverability

---

## Commands Run

### 1) Initial debug run (default output mode)

```powershell
make4ht -u -a debug -d .\output\smoke-test smoke-test.tex
```

### 2) Initial debug run with console output captured

```powershell
make4ht -u -a debug -d .\output\smoke-test smoke-test.tex *>&1 | Tee-Object -FilePath ..\..\evidence\week1-latexml\tex4ht-smoke-test-log.txt
```

### 3) MathML test

```powershell
make4ht -u -a debug -e accessibility-prelim.mk4 -d .\output\smoke-test-mathml smoke-test.tex "mathml" *>&1 | Tee-Object -FilePath ..\..\evidence\week1-latexml\tex4ht-smoke-test-mathml-log.txt
```

### 4) MathML + MathJax test

```powershell
make4ht -u -a debug -e accessibility-prelim.mk4 -d .\output\smoke-test-mathml-mj smoke-test.tex "mathml,mathjax" *>&1 | Tee-Object -FilePath ..\..\evidence\week1-latexml\tex4ht-smoke-test-mathml-mathjax-log.txt
```

---

## Output Locations

### Initial/default run

* **HTML:** `experiments/latexml/output/smoke-test/smoke-test.html`
* **CSS/assets:** `experiments/latexml/output/smoke-test/smoke-test.css`

### MathML run

* **HTML:** `experiments/latexml/output/smoke-test-mathml/smoke-test.html`

### MathML + MathJax run (selected baseline)

* **HTML:** `experiments/latexml/output/smoke-test-mathml-mj/smoke-test.html`

---

## Initial Result (Default Run)

* **Conversion status:** Pass
* **HTML generated:** Yes
* **Math present:** Yes, but **not accessible/semantically usable** in this output mode

### NVDA + Firefox Quick Check (Default Run)

* **Heading navigation:** Yes, but only for the main section heading (first-level heading). Theorem/proof blocks were **not** recognized as headings.
* **Inline math reading:** Math was present, but not read correctly. Example: `a^2` was read as **“a two”** instead of **“a squared”**.
* **Display math reading:** Present, but not read correctly. Same issue: `a^2` read as **“a two”**.
* **Theorem/proof discoverability:** Theorem blocks were not clearly discoverable via navigation. Proof blocks appeared to be present (white square end-of-proof marker observed), but equations inside proofs were announced as **graphical objects** rather than readable math.

### Interpretation (Default Run)

The basic tex4ht pipeline worked, but the default output mode did **not** produce acceptable math accessibility for screen reader use.

---

## Follow-up Tests: MathML and MathML + MathJax

### Purpose

Test whether enabling MathML (and then MathML + MathJax) improves NVDA/Firefox math reading behavior.

### Notes on test design

* The theorem statement intentionally included a squared term (`2a^2`) to test whether superscripts are read correctly **inside theorem environments**, not just in plain inline math.

---

## Findings (MathML / MathML + MathJax)

### Structural inspection (HTML source)

The `mathml,mathjax` output contains:

* MathML elements such as `<math>`, `<mrow>`, `<msup>`, `<mi>`, `<mn>`, `<mo>`
* a MathJax script using `mml-chtml.js` (MathML input → CommonHTML output)

This confirms the selected output mode is **MathML-first with MathJax rendering support**, not TeX-only MathJax.

### Theorem/proof block structure present

The HTML includes identifiable containers such as:

* `div.newtheorem`
* `div.proof`

This is promising for future post-processing to create navigable theorem/proof headings.

---

## Updated Result (MathML + MathJax)

* **Conversion status:** Pass
* **HTML generated:** Yes
* **Math present:** Yes
* **MathML present in source HTML:** Yes
* **Selected baseline:** `mathml,mathjax`

### NVDA + Firefox Quick Check (MathML + MathJax)

* **Inline math reading:** Improved (read correctly in follow-up testing)
* **Display math reading:** Improved (read correctly in follow-up testing)
* **Proof equations:** Recognized as math (improved vs default graphical-object behavior)
* **Theorem/proof heading navigation:** Still not exposed as headings (expected at this stage)

### Comparison note (`mathml` vs `mathml,mathjax`)

For this smoke test, `mathml` and `mathml,mathjax` behaved similarly in basic NVDA reading. `mathml,mathjax` was selected as the baseline for further testing because it preserves MathML in source while providing MathJax-rendered output behavior.

---

## Cleanup / Repository Decisions

* Moved setup log to: `evidence/week1-latexml/tex4ht-setup-log.md`
* Kept: `experiments/latexml/output/smoke-test-mathml-mj/smoke-test.html`
* Deleted: `experiments/latexml/output/smoke-test-mathml/smoke-test.html`
* Rationale: Selected **MathJax-rendered MathML** (`"mathml,mathjax"`) as the Week 1 baseline mode.

---

## Current Status Summary

### Confirmed

* `make4ht` works on local setup (Windows + TeX Live 2025)
* tex4ht can generate HTML from test LaTeX
* MathML can be generated and inspected in source HTML
* `mathml,mathjax` improves math reading behavior in Firefox + NVDA
* theorem/proof blocks are present in HTML and can likely be post-processed for better navigation

### Not yet solved

* theorem/proof blocks are not navigable via heading shortcuts
* need post-processing step to insert accessibility landmarks/headings

---

## Next Step

Test a more complex personal `.tex` file using the selected baseline command:

```powershell
make4ht -u -a debug -e accessibility-prelim.mk4 -d .\output\myfile-mathml-mj -B .\build\myfile-mathml-mj myfile.tex "mathml,mathjax"
```

Then record:

* conversion status (Pass / Partial / Fail)
* MathML presence (`<math>` tags)
* theorem/proof container presence (`div.newtheorem`, `div.proof`, etc.)
* NVDA inline/display math behavior
* theorem/proof discoverability
* package/macro warnings from build output

