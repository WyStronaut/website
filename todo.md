# Todo

## Now

- [ ] Include sample HTML/CSS output so visitors can see what the pipeline produces
- [ ] Write a proper README that tells the project story
- [ ] Publish short writeup on github pages demonstrating results achieved. 
- [ ] Significant amount of current source tex is unlicensed and cannot be included in the repo. 


## Soon

- [ ] Investigate semantic grouping for theorem/definition/proof blocks
- [ ] Log Week 2 testing with AI usage noted inline
- [ ] Fix enumerate list semantics: `dl/dt/dd` → `ol/li` via HTML post-processing or tex4ht config
- [ ] Normalise heading hierarchy (insert h2 level)
- [ ] Add `build.ps1` and make4ht config to repo so the pipeline is visible
- [ ] Include sample HTML/CSS output so visitors can see what the pipeline produces
- [ ] Write a proper README that tells the project story

## Later

- [ ] Test with additional browsers (Chrome, Edge, Safari)
- [ ] Try converting source from other IA courses (Linear Algebra, Probability)
- [ ] Document the workflow as a reproducible guide for other visually impaired users

## Done

- [x] Local make4ht setup on Windows + TeX Live 2025
- [x] Smoke test: default, mathml, mathml+mathjax modes compared
- [x] Selected `mathml,mathjax` as baseline mode
- [x] Removed `unicode-math`, restored AMS stack in util.sty
- [x] Converted IA Numbers and Sets Chapters 1–7 (39 pages)
- [x] NVDA evaluation of full document — maths accessible, lists and theorem blocks need work
- [x] Identified Pandoc limitations → pivoted to tex4ht
- [x] Identified source quality requirement from failed conversion attempt. 
- [x] Identified NVDA incompatibility during PDF navigation. Math reading works, though equations are not navigable. 