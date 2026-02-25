# HTML Build Error Log

## Document Information
Chapter: IA Numbers and Sets (Chapters 1–7)
Build Target: main.tex
Generated File: main.html
Build Date: 25/02/2026
Build Tool: make4ht main.tex "mathml,mathjax"

---

## 1. Build Outcome
Build completed: Yes  
Fatal errors present: No (HTML generated successfully)  
Warnings present: Yes  

Overall build status:
- Stable with warnings

Notes:
Exit code = 1 due to tex4ht Lua DOM post-processing instability.

---

## 2. Fatal Errors
None.

Notes:
No LaTeX compilation failures.
No undefined control sequence errors in final baseline configuration.

---

## 3. Warnings (Accessibility-Relevant)

Warning message:
Unbalanced Tag (/mtable) → stack overflow (Lua DOM parser)

Source:
tex4ht Lua DOM post-processing stage

Likely impact:
Post-processing stage failure.
Does NOT affect generated HTML or MathML rendering.

Action taken:
Documented as known limitation.
No structural regression observed in rendered HTML.

Resolved:
No (tool limitation)

---

## 4. Warnings (Non-Critical / Cosmetic)

Warning message:
DOM parsing failed → HTML DOM fallback used

Impact:
Non-zero exit code.
No observable impact on output usability.

Action taken:
Classified as non-blocking for Week 1.

---

## 5. HTML Structural Observations (Build-Level)

Observation:
Enumerate environments rendered as <dl>/<dt>/<dd> instead of <ol>/<li>

Likely cause:
tex4ht enumerate conversion behavior.

Action:
To be addressed in Week 2 post-processing.

---

Observation:
Theorem environments rendered as styled <div> containers without structural landmarks.

Likely cause:
amsthm + tcolorbox conversion without heading promotion.

Action:
Structural enhancement planned for Week 2.

---

## 6. Post-Processing Applied
None during baseline.

---

## 7. Regression Check
Previous unicode-math incompatibility resolved.
No new LaTeX-level fatal errors introduced.
DOM post-processing instability persists.

Build stability compared to previous version:
Improved (unicode-math removal stabilized math conversion).

---

## 8. Decision
Acceptable for accessibility testing.

Summary:
HTML generation stable and reproducible.
Known DOM post-processing limitation documented.
No blocking structural corruption detected.