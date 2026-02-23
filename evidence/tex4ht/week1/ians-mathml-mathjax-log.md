# Complex File tex4ht / make4ht Test Log (`mathml,mathjax` baseline)

- **Date:** YYYY-MM-DD
- **Tester:** Yexuan
- **OS:** Windows 11 Home 24H2 (Build 26100)
- **TeX distribution:** TeX Live 2025
- **make4ht version:** v0.4d
- **Build file:** `experiments/latexml/accessibility-prelim.mk4`
- **Input file:** `PATH/TO/YOURFILE.tex`
- **Run location (working directory):** `experiments/latexml`
- **Baseline mode:** `mathml,mathjax`

---

## Goal of this Test

Test a more complex `.tex` file using the selected Week 1 baseline (`mathml,mathjax`) and evaluate:

- conversion feasibility
- MathML presence in source HTML
- NVDA + Firefox math reading behavior
- theorem/proof discoverability
- package/macro compatibility issues

---

## Command Used

```powershell
make4ht -u -a debug -e accessibility-prelim.mk4 -d .\output\<yourfile>-mathml-mj -B .\build\<yourfile>-mathml-mj <yourfile>.tex "mathml,mathjax"
```

## Input File Notes

- **Source origin:** (e.g., personal notes / external repo / adapted file)
- **Document type:** (article / chapter / lecture notes / fragment)
- **Known packages used:** (if known)
- **Known custom macros/environments:** (if known)
- **Wrapper file used:** Yes / No
  - If yes: PATH/TO/WRAPPER.tex

---

## Output Locations

- **Output directory:** experiments/latexml/output/<yourfile>-mathml-mj/
- **Build directory:** experiments/latexml/build/<yourfile>-mathml-mj/
- **Main HTML file:** experiments/latexml/output/<yourfile>-mathml-mj/<yourfile>.html
- **CSS/assets:** experiments/latexml/output/<yourfile>-mathml-mj/

---

## Conversion Result

- **Status:** Pass / Partial / Fail
- **HTML generated:** Yes / No
- **CSS generated:** Yes / No
- **Math present in rendered page (<math> tags):** Yes / No / Partial
- **MathML present in source HTML (<math> tags):** Yes / No / Partial

### Build summary (short)

- (Write 2–5 lines summarizing what happened.)

---

## Build Log Review (Key Warnings / Errors)

### Package / macro warnings

- (List warnings here)
- (Example: unsupported package behavior)
- (Example: undefined control sequence)

### Conversion errors (if any)

- (List errors here)

### Notes on recoverability

- **Did conversion continue despite warnings?** Yes / No
- **Are issues likely fixable by wrapper/preamble changes?** Yes / No / Unsure

---

## HTML Structural Inspection

### Math

- **<math> elements present:** Yes / No
- **Example MathML tags observed:**
  - <mrow>: Yes / No
  - <msup>: Yes / No
  - <mfrac>: Yes / No
  - other: (list)

### Theorem / proof structure

- **div.newtheorem present:** Yes / No
- **div.proof present:** Yes / No
- **Other theorem-like containers observed:**
  - (e.g., lemma/proposition/corollary classes if any)

### Headings

- **Section headings present (h1/h2/h3...):** Yes / No
- **Heading hierarchy looks reasonable:** Yes / No / Partial

### Notes / snippet examples

- (Paste short snippets if useful)

---

## NVDA + Firefox Accessibility Check

### Heading navigation

- **Main section headings navigable with H:** Yes / No / Partial
- **Theorem/proof blocks navigable as headings:** Yes / No
- **Notes:**

### Inline math reading

- **Result:** Good / Mixed / Poor
- **Example tested:**
- **NVDA behavior observed:**

### Display math reading

- **Result:** Good / Mixed / Poor
- **Example tested:**
- **NVDA behavior observed:**

### Proof-contained equations

- **Result:** Good / Mixed / Poor
- **Behavior (math vs graphic objects):**

### General reading order

- **Result:** Good / Mixed / Poor
- **Notes:**

---

## Comparison Against Smoke Test Baseline

- **Better than smoke test:** (what improved)
- **Same as smoke test:** (what remained similar)
- **Worse than smoke test:** (regressions)
- **Likely reason(s):** (package complexity / macros / structure / file type)

---

## Preliminary Assessment

- **Feasible for accessibility pipeline?** Yes / No / Partially
- **Usable as a demonstration file with minor fixes?** Yes / No / Unsure
- **Main blockers identified:**
  -
  -
  -

---

## Next Actions

- [ ] Keep this file as a test case
- [ ] Try wrapper file
- [ ] Try source cleanup / minimal macro shim
- [ ] Inspect theorem/proof HTML for heading post-processing
- [ ] Prototype theorem/proof heading insertion
- [ ] Test another file
- [ ] Other:

---

## Decision (for Week 1 checkpoint)

- **Outcome of this test:** Pass / Partial / Fail
- **What this changes (if anything) about the chosen baseline:**
  - (e.g., no change / confirms baseline / requires wrapper strategy / requires file triage)

---

## Related Evidence Files

- **Week 1 setup log:** evidence/week1-latexml/tex4ht-setup-log.md
- **Checkpoint note:** evidence/week1-latexml/week1-checkpoint-note.md
- **Console output (optional):** evidence/week1-latexml/<yourfile>-mathml-mathjax-console.txt