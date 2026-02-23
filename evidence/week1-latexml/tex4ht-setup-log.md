# Week 1 tex4ht / make4ht Prelim Setup Log

- Date: 24/02/2026
- OS: Windows 11 Home 24H2 Build 26100
- TeX distribution: TeX Live 2025
- make4ht version: v0.4d
- Test file: experiments/latexml/smoke-test.tex

## Commands run
1. make4ht -u -a debug -d .\output\smoke-test smoke-test.tex

## Result
- Conversion status: Pass
- HTML generated: Yes
- Math present: Yes (not accessible/semantically usable in current output mode)

## NVDA + Firefox quick check
- Heading navigation: Yes, but only for the first level of heading (h1). Theorem/proof blocks are not recognized as headings.
- Inline math reading: It exists, but it is not read correctly. a^2 is read as "a two" instead of "a squared". 
- Display math reading: It exists, but it is not read correctly. a^2 is read as "a two" instead of "a squared"
- Theorem/proof discoverability: It is not apparent if theorem blocks are present, but proof blocks are present from the presence of white squares at the end of proofs. Equation within proof are announced as graphical objects, but not read as math, making the same "a two" reading issue as above.

## Fixes tried
- Specified MathML output as follows:
make4ht -u -a debug -e smoke-test.mk4 -d .\output\smoke-test-mathml smoke-test.tex "mathml"
- And specified MathML, MathJax output as follows:
make4ht -u -a debug -e smoke-test.mk4 -d .\output\smoke-test-mathml-mj smoke-test.tex "mathml,mathjax"
We note that the mathjax behaves similarly to the mathml output, with the mathjax announcing math environments as clickable.

## Updated Result
- Conversion status: Pass
- HTML generated: Yes
- Math present: Yes

## NVDA + Firefox quick check
- Heading navigation: Yes, but only for the first level of heading (h1). Theorem and proof blocks are not recognized as headings. Previously, they were at least in bold font, but now they are not visually distinct at all.
- Inline math reading: It exists, and it is read correctly.
- Display math reading: It exists and is read correctly.
- Theorem/proof discoverability: It is not apparent if theorem blocks are present, but proof blocks are present from the presence of white squares at the end of proofs. Equation within proof identified as math, and read correctly.
## Next step 
- Accepted AI suggestion to specify the math output being MathJax rendering of MathML, which fit better with an inspectable accessibility pipeline, due to it starting with explicit semantic tags
- Let me pass a more complex file through the fixed build process to see if the same results hold, and to see if there are any other issues that arise.
