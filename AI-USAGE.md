# AI Usage

## How AI is used in this project

This project was developed with the assistance of GPT-5.2 and Claude. AI tools are used for:

- Code generation and debugging (build scripts, make4ht configuration, HTML post-processing)
- Explaining unfamiliar tools and code line by line
- Drafting and structuring documentation from my notes

All code has been reviewed and understood by the author. Accessibility testing, NVDA evaluation, and all user experience observations are performed directly by me — a low vision user working with a screen reader.

AI suggestions are treated as proposals. Every change that affects build output or accessibility is verified by rebuilding and testing with NVDA before being accepted.

## What is not AI-generated

- The project concept and motivation
- All NVDA testing observations and accessibility findings
- Decisions about which output mode to use and why
- The choice to remove `unicode-math` and restore the AMS stack (AI helped debug, I tested and confirmed)
- Evaluation of what works and what doesn't for screen reader maths

## Week 1 note

AI usage was not tracked per-task during Week 1. Key AI-assisted areas were: build error interpretation, documentation template drafting, and debugging support during the `unicode-math` removal. From Week 2 onward, AI involvement will be noted in testing logs as work happens.

## Rule

No change without a test. AI-suggested changes to build behaviour or HTML output require: rebuild → NVDA check → log the result → keep or revert.
