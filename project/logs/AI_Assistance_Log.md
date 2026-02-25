# AI Assistance Log

## Purpose
This log records AI-assisted work (and non-AI work where relevant for comparison) in the accessibility workflow.

It supports:
- auditability
- reproducibility
- responsible AI use documentation

## Attribution Rule
From Week 2 onward, AI involvement must be recorded at the time of work (not reconstructed retrospectively).

## AI Involvement Labels
- **Yes** = AI used for this task
- **No** = No AI used for this task
- **Mixed** = AI-assisted, but final direction/decision depended on human testing or judgment
- **Unknown (retrospective)** = Week 1 records do not explicitly document AI usage

## Week 1 Provenance Notes
- Week 1 technical logs are strong, but AI attribution was not recorded consistently at the time.

---

## Week 1 Entries

### W1-01 — tex4ht/make4ht local baseline setup (smoke test)
- **Date:** 24/02/2026
- **Stage:** Week 1 Part 1
- **AI used:** Unknown (retrospective)
- **AI role:** Not documented
- **Task:** Establish local LaTeX → HTML conversion baseline with `make4ht`
- **What was done:** Ran initial smoke-test conversions (default/debug) on local Windows + TeX Live setup to confirm pipeline feasibility.
- **Verification:** HTML generated; NVDA + Firefox quick check performed
- **Outcome:** Baseline pipeline confirmed working
- **Decision:** Continue to output-mode comparison testing
- **Evidence:** Week 1 tex4ht / make4ht Prelim Setup Log; Week 1 Checkpoint Note

### W1-02 — output mode comparison for math accessibility
- **Date:** 24/02/2026
- **Stage:** Week 1 Part 1
- **AI used:** Unknown (retrospective)
- **AI role:** Not documented
- **Task:** Compare default, `mathml`, and `mathml,mathjax` modes
- **What was done:** Tested smoke-test outputs and checked NVDA + Firefox math reading behavior.
- **Verification:** Source HTML inspection + NVDA quick checks
- **Outcome:** Default mode not acceptable for screen-reader math; `mathml,mathjax` improved math reading and preserved MathML in source
- **Decision:** Select `mathml,mathjax` as Week 1 baseline mode for further testing
- **Evidence:** Week 1 tex4ht / make4ht Prelim Setup Log; Week 1 Checkpoint Note

### W1-03 — theorem/proof container viability check
- **Date:** 24/02/2026
- **Stage:** Week 1 Part 1
- **AI used:** Unknown (retrospective)
- **AI role:** Not documented
- **Task:** Check whether theorem/proof blocks are structurally identifiable in generated HTML
- **What was done:** Inspected HTML and confirmed containers such as `div.newtheorem` and `div.proof`.
- **Verification:** HTML source inspection
- **Outcome:** Structural hooks for later post-processing confirmed
- **Decision:** Defer heading/landmark enhancement to later stage
- **Evidence:** Week 1 tex4ht / make4ht Prelim Setup Log

### W1-04 — smoke-test artifact cleanup and baseline selection
- **Date:** 24/02/2026
- **Stage:** Week 1 Part 1
- **AI used:** Unknown (retrospective)
- **AI role:** Not documented
- **Task:** Keep selected smoke-test baseline artifacts and remove non-selected outputs
- **What was done:** Kept `mathml,mathjax` smoke-test output; removed unselected `mathml` smoke-test HTML artifact; recorded rationale.
- **Verification:** File review + documented cleanup decision
- **Outcome:** Smoke-test artifacts rationalized around selected baseline mode
- **Decision:** Proceed to complex/real file testing
- **Evidence:** Week 1 tex4ht / make4ht Prelim Setup Log

### W1-05 — stabilize IA NS HTML conversion (unicode-math removal / AMS restore)
- **Date:** 25/02/2026
- **Stage:** Week 1 Part 2
- **AI used:** Mixed
- **AI role:** Debugging support
- **Task:** Stabilize real-document HTML conversion for `cambridge-maths-notes/ia/ns/main.tex`
- **What was done:** Removed `unicode-math` from `util.sty` and restored classical AMS math stack.
- **Verification:** Rebuild + HTML generation + NVDA checks
- **Outcome:** Unicode-math incompatibility resolved in baseline configuration
- **Decision:** Keep classical AMS stack for HTML accessibility workflow baseline
- **Human role (important):** Final testing and judgment
- **Evidence:** NVDA Accessibility Test Log (Fixes Applied); HTML Build Error Log (Regression Check); Week 1 Baseline Summary (Fixes Applied / Build Stability)

### W1-06 — final make4ht mode selection for IA NS baseline
- **Date:** 25/02/2026
- **Stage:** Week 1 Part 2
- **AI used:** No (for decision)
- **AI role:** None recorded for decision
- **Task:** Evaluate and choose final build mode for IA Numbers and Sets baseline
- **What was done:** Compared:
  - pure `mathml` (good MathML structure, exit code 1 due to DOM instability)
  - pure `mathjax` (exit code 0 but some raw TeX fragments)
  - hybrid `mathml,mathjax` (best combined accessibility outcome)
- **Verification:** Build comparisons + NVDA testing
- **Outcome:** Tradeoffs documented
- **Decision:** **User tested and decided** to use `mathml,mathjax` baseline mode
- **Evidence:** NVDA Accessibility Test Log (Fixes Applied and Retesting Notes); Week 1 Baseline Summary

### W1-07 — warning interpretation and blocking/non-blocking classification
- **Date:** 25/02/2026
- **Stage:** Week 1 Part 2
- **AI used:** Yes
- **AI role:** Debug interpretation / warning classification
- **Task:** Classify tex4ht warnings and non-zero exit code
- **What was done:** Documented `Unbalanced Tag (/mtable)` / Lua DOM stack overflow and DOM fallback warning; classified as non-blocking because HTML/MathML output remained usable.
- **Verification:** Build output review + rendered HTML usability check + NVDA testing
- **Outcome:** Exit code 1 explained and tracked as known limitation
- **Decision:** Accept for Week 1 accessibility testing; carry forward as tool limitation
- **Human role (important):** Final acceptance based on observed usability
- **Evidence:** HTML Build Error Log; NVDA Accessibility Test Log; Week 1 Baseline Summary

### W1-08 — structured NVDA accessibility log for IA NS baseline
- **Date:** 25/02/2026
- **Stage:** Week 1 Part 2
- **AI used:** Yes
- **AI role:** Documentation template drafting + proofreading
- **Task:** Produce structured NVDA accessibility test record for generated `main.html`
- **What was done:** AI drafted template; user filled in actual test observations/details; AI proofread wording/structure.
- **Verification:** Full NVDA inspection recorded (headings, reading flow, lists, theorem-like blocks, inline/display math, macros, links)
- **Outcome:** Pass with minor issues
- **Key findings recorded:**
  - strong math accessibility in hybrid mode
  - no MathML/MathJax duplication observed
  - list semantics incorrect (`dl` vs `ol`)
  - theorem-like blocks readable but not structurally navigable
- **Decision:** Accept baseline; prioritize structural semantics fixes in Week 2
- **Evidence:** NVDA Accessibility Test Log; Week 1 Baseline Summary

### W1-09 — Week 1 baseline consolidation and Week 2 priority setting
- **Date:** 25/02/2026
- **Stage:** Week 1 Part 2
- **AI used:** Unknown (retrospective)
- **AI role:** Not documented (possible documentation assistance, unconfirmed)
- **Task:** Consolidate Week 1 build/usability findings into baseline summary
- **What was done:** Summarized build stability, structural HTML observations, NVDA findings, and priority issues for Week 2.
- **Verification:** Cross-reference of build log + NVDA log + baseline behavior
- **Outcome:** Week 1 baseline documented with clear priorities
- **Decision:** Week 2 focus set to:
  1. list semantics
  2. theorem-like block structure
  3. preserve math accessibility while testing structural changes
- **Evidence:** Week 1 Baseline Summary; HTML Build Error Log; NVDA Accessibility Test Log

---

## Week 1 Summary of AI Use (High-Level)
- AI use was **present but not consistently logged at the time**.
- Confirmed AI-assisted areas:
  - warning interpretation/classification (W1-07)
  - NVDA log template drafting + proofreading (W1-08)
  - mixed debugging support during unicode-math removal / AMS restoration (W1-05)
- Confirmed human-led decision:
  - final hybrid mode selection (`mathml,mathjax`) based on direct testing (W1-06)

## Week 2 Logging Requirement (Operational)
For every meaningful task entry, record at minimum:
- **AI used:** Yes / No / Mixed
- **AI role:** debug / refactor / documentation / test planning
- **Human verification:** what test was run
- **Decision:** accepted / modified / rejected / deferred