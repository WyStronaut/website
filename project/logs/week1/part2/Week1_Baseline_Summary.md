# Week 1 Baseline Summary

## Scope
Full HTML build and NVDA inspection of `main.tex`.
Baseline inspection performed before structural semantic enhancements.

Date: 25/02/2026

Build Tool: make4ht  
Baseline Mode: mathml,mathjax  
Test Environment: Windows 11 Home 24H2 (Build 26100), TeX Live 2025, make4ht v0.4d  
Screen Reader: NVDA  

---

## 1. Build Stability

HTML output generated successfully via:

    make4ht main.tex "mathml,mathjax"

Exit code: 1

Cause:
tex4ht Lua DOM post-processing instability triggered by large aligned MathML structures (`Unbalanced Tag (/mtable)` leading to stack overflow).

Impact:
The non-zero exit code does not affect the generated HTML output.  
Rendered content remains usable for accessibility evaluation.

Unicode-math was removed from `util.sty` and replaced with the classical AMS math stack to restore stable HTML conversion.

Baseline Status:
- TeX compilation stable
- HTML generation stable
- Post-processing instability documented

---

## 2. Structural HTML Observations

### 2.1 Enumerated Lists

Enumerated lists generated as:

    <dl class="enumerate-enumitem">

with alternating `<dt>` and `<dd>` elements.

Impact:
NVDA reports incorrect list item counts.
List navigation inconsistent with expected ordered list semantics.

Classification:
Structural semantics issue (not build failure).

---

### 2.2 Theorem-like Environments

Theorem-like environments rendered as styled `<div>` containers with inline heading text.

Readable but not structurally navigable as regions or headings.

Limitation:
Blocks not exposed as structural landmarks.
Navigation relies on linear reading.

Classification:
Semantic enhancement opportunity.

---

### 2.3 Headings

Title (h1), chapter (h3), and section (h4) headings present.
h2 level missing, creating a gap in hierarchical structure.

Status:
Acceptable but may benefit from hierarchy normalization.

---

## 3. NVDA Usability Findings

### 3.1 Math Accessibility

- Inline math readable.
- Display math readable in logical order.
- `align` environments announced with correct line count.
- Arrow navigation moves between aligned lines correctly.
- Zoom functionality available.

Hybrid MathML + MathJax mode provides enriched navigation:

- Operator-level traversal at intermediate zoom.
- Clear separation of numerator and denominator in fractions.
- Deep structural exploration possible without duplication.

No repetition, skipped operators, or raw TeX fragments observed in hybrid mode.

Conclusion:
Mathematical content is structurally accessible and interactively explorable.

---

### 3.2 Primary Usability Issue

List semantics mismatch affecting item count and navigation.

---

### 3.3 Secondary Usability Limitation

Theorem environments not exposed as distinct structural blocks.

---

## 4. Accessibility Classification (Baseline)

Build Stability: Functionally stable (non-zero exit code due to post-processing stage only)  
Structural Semantics: Partially correct  
Screen Reader Usability: Usable with minor structural issues  

Overall Baseline Decision:
Pass with minor issues.

---

## 5. Fixes Applied During Baseline Testing

- Removed `unicode-math` from `util.sty`.
- Restored classical AMS math stack.
- Validated MathML generation under large aligned structures.
- Selected hybrid `mathml,mathjax` mode for enriched interactive navigation.

---

## 6. Identified Priority Issues

1. Enumerate environments emitted as `dl/dt/dd` instead of `ol/li`.
2. Theorem-like blocks lack semantic grouping for structured navigation.
3. tex4ht DOM post-processing instability under pure MathML mode.

---

## 7. Direction for Week 2

Primary Focus:
Correct list semantics via deterministic HTML post-processing.

Secondary Focus:
Investigate semantic grouping for theorem-like environments (heading level or ARIA region).

Success Criteria:
- NVDA reports correct list item counts.
- Lists navigable via ordered list semantics.
- Theorem blocks structurally identifiable.
- No regression in math accessibility.

---

End of Week 1 Baseline.