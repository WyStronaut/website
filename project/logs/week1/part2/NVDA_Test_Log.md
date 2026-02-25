# NVDA Accessibility Test Log

## Document Information
Book: IA Numbers and Sets Chapters 1–7

Build Target: C:\Users\Lenovo\OneDrive\Desktop\learning_project\cambridge-maths-notes\ia\ns\main.tex  
Generated File: C:\Users\Lenovo\OneDrive\Desktop\learning_project\cambridge-maths-notes\ia\ns\main.html  
Test Date: 25/02/2026  
Tester: WyStronaut  

---

## 1. Build Status
Build completed: Yes  
Exit code: 1  
Fatal errors: None (HTML generated successfully)  
Warnings: DOM post-processing instability (see notes)

Notes:  
`make4ht main.tex "mathml,mathjax"` generates complete HTML output.  
Exit code 1 arises from tex4ht Lua DOM parsing failure (`Unbalanced Tag (/mtable)` leading to stack overflow).  
This does not affect rendered HTML content or NVDA usability.

---

## 2. File Open Check
HTML opens: Yes  
Page title correct: Yes  
CSS loaded: Yes  

---

## 3. Heading Structure
First heading correct: Yes  
Heading hierarchy logical: Title (h1), Chapters (h3), Sections (h4); h2 missing  
Section names match source: Yes  

Notes:  
Heading structure usable but hierarchy gap (missing h2) may affect navigation consistency.

---

## 4. Reading Flow (NVDA)
Top-to-bottom reading coherent: Yes  
No repeated junk text: Yes  
Paragraph breaks natural: Yes  

List navigation works: Partially  

Notes:  
Enumerated lists rendered as `<dl>` structures instead of `<ol>`.  
NVDA reports incorrect item counts due to structural semantics mismatch.  
Linear reading remains coherent.

---

## 5. Theorem-like Blocks
Definition readable: Yes  
Theorem readable: Yes  
Claim readable: Yes  
Proof readable: Yes  
Note readable: Yes  
Block boundaries clear by speech: No  

Notes:  
Theorem and proof environments are visually styled but not structurally exposed.  
NVDA reads them as regular paragraphs without structural landmarks or headings.  
Proof termination is recognizable due to the announced white square symbol.  
Semantic grouping enhancement recommended.

---

## 6. Inline Math
Symbols read acceptably: Yes  
No missing symbols: Yes  
No garbled math: Yes  

Notes:  
Classical AMS math stack functioning correctly after removal of `unicode-math`.

---

## 7. Display Math
Equations present: Yes  
Multiline equations readable in usable order: Yes  
No broken fragments: Yes  

Additional Observations:

- `align` environments announce correct line count.
- Left/right arrows navigate between aligned lines.
- Up/down arrows allow zoom navigation.
- Fractions are announced with numerator and denominator.
- At deeper zoom levels, numerator and denominator can be traversed separately.
- No duplication or repeated reading between MathML and MathJax layers observed.

Conclusion:  
Mathematical content is structurally accessible and interactively explorable.

---

## 8. Custom Macros
Custom symbols render: Yes  
Custom symbols readable: Yes  

Notes:  
After removal of `unicode-math` and restoration of classical AMS packages, custom macros render correctly in hybrid mode.

---

## 9. Links and Navigation
Internal links work: Yes  
Navigation links sensible: Yes  
No broken stylesheet/script links: Yes  

---

## 10. Visual / Theme Consistency
Appearance consistent: Yes  

---

## 11. Decision
Pass with minor issues: Yes  

Summary of issues:
- Enumerated list semantics incorrect (`dl` instead of `ol`)
- Theorem environments lack structural grouping
- DOM post-processing exit code instability

---

## 12. Fixes Applied and Retesting Notes

1. Removed `unicode-math` from `util.sty` and restored classical AMS math stack.
2. Verified pure `mathml` mode produces structurally correct MathML but exits with code 1 due to DOM parsing instability.
3. Verified pure `mathjax` mode exits with code 0 but leaves some raw TeX fragments.
4. Selected hybrid `mathml,mathjax` mode for enriched navigation and stable math rendering, accepting documented DOM limitation.

---

## Next Steps

1. Correct enumerate HTML semantics (`dl` → `ol`).
2. Investigate structural exposure of theorem-like environments.
3. Evaluate heading hierarchy normalization (h2 insertion).