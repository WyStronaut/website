# Week 1 Feasibility Memo  
Responsible AI-Assisted Accessibility Workflow  
Focus: MathML + HTML with Firefox + NVDA  

Author:  
Date:  
Repository Commit Hash:  

---

## 1. Objective

The goal of Week 1 was to evaluate whether MathML + HTML output
is a viable accessible pathway for undergraduate mathematics content
when used with Firefox and NVDA.

This week specifically tested:
- MathML generation from IA source .tex files
- Firefox native MathML rendering
- NVDA reading behavior
- Structural navigation (headings, theorems, proofs)
- Comparison against the existing MathJax fallback

---

## 2. Scope of Testing

### Source Files Tested
1.
2.
3.

Rationale for selection:
- Presence of theorems and proofs
- Dense notation
- Multi-line equations
- Custom macros (if applicable)

---

## 3. Build Feasibility

### Build Status
- MathML output generated: Yes / No
- HTML pages accessible: Yes / No
- Critical conversion errors: Yes / No

Summary of build reliability:

Observed limitations:

---

## 4. Firefox Rendering Assessment

### Rendering Integrity
- Inline math renders correctly: Yes / No
- Display math renders correctly: Yes / No
- Raw LaTeX visible: Yes / No
- Layout integrity maintained: Yes / No

### Structural Verification
- `<math>` elements present in DOM: Yes / No
- Theorem/proof structure preserved: Yes / No

Observations:

---

## 5. NVDA Accessibility Assessment

### Heading Navigation
Result:

### Inline Mathematics
Result:

### Complex Expressions (fractions, integrals, multi-line equations)
Result:

### Theorem + Proof Navigation
Result:

### Comparison vs MathJax Version
Differences in:
- Clarity
- Verbosity
- Stability
- Navigation ease

---

## 6. Identified Issues

### 🔴 Blocking Issues
(Prevent effective independent use)

1.

### 🟠 Degrading Issues
(Reduce clarity but not fatal)

1.

### 🟢 Cosmetic Issues
(Aesthetic or minor)

1.

---

## 7. Risk Assessment

| Risk | Severity | Mitigation |
|------|----------|------------|
|      |          |            |

---

## 8. Feasibility Conclusion

Based on Week 1 testing:

MathML + HTML with Firefox + NVDA is:

[ ] Not viable  
[ ] Conditionally viable with mitigations  
[ ] Viable as a secondary pathway  
[ ] Viable as a primary accessible pathway  

Justification:

---

## 9. Role of AI Assistance

AI tools were used to:
- Draft structured testing protocols
- Help interpret conversion errors
- Assist in documenting findings

All technical outputs were manually verified.

No autonomous changes were made without human review.

---

## 10. Week 1 Outcome

Week 1 successfully established:

- Dual-output architecture (MathJax + MathML)
- Documented build reproducibility
- Empirical accessibility testing results
- Identified limitations and mitigation pathways

This provides a foundation for Week 2 refinement and scaling.

---

## 11. Reproducibility

Steps required to reproduce Week 1 results:

1.
2.
3.
4.