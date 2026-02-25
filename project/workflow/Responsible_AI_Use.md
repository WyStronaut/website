# Responsible AI Use

## Purpose
This document explains how AI tools are used in the accessibility workflow for LaTeX-to-HTML mathematics materials.

AI is used to support:
- build/toolchain debugging
- accessibility-focused refactoring experiments
- test planning and checklist design
- documentation drafting and summarization

AI is not used as a substitute for human verification.

## Scope and Repository Boundaries

### Local source repository (content under test)
- `cambridge-maths-notes/` contains course LaTeX sources used for local testing.
- This repository is treated as unlicensed content for my purposes.
- I do not assume redistribution/modification rights for public release from this source.

### Workflow and evidence repository area
- `website/` contains workflow scripts, logs, checklists, experiments, and staged site output.
- This is the primary location for process documentation and accessibility evidence.

This separation is intentional and supports responsible handling of licensing constraints.

## Current Working Mode (Local Manual Extraction)
At the current stage (Week 1 / early Week 2), testing is performed by running `make4ht` directly on:

- `cambridge-maths-notes/ia/ns/main.tex`

Typical retained outputs in that folder:
- `main.html`
- `main.css`

A visual comparison file may also be generated in the same folder:
- `main.pdf` (XeLaTeX, TeX Live 2025)

Temporary build artifacts are manually deleted after extracting the needed HTML/CSS outputs.

Logs and accessibility notes are recorded under:
- `website/project/logs/...`
- `website/evidence/...` (when applicable)

## Planned Working Mode (Structured Website Build Pipeline)
For licensed/redistributable sources (e.g., CC or MIT licensed materials), the intended workflow is:

- `website/build.ps1` accepts a source directory (`sourceDir`)
- builds are executed under the `website/` workflow
- outputs are staged under `website/site/...`
- templates/filters/source support files are managed under `website/src/...`

This mode is intended to support:
- reproducible builds
- navigation/link testing
- GitHub publishing
- cleaner separation between source and generated output

## Core Rule
No change without a test.

Every AI-suggested change that affects build behavior, HTML output, or accessibility must be followed by:
1. Build test
2. NVDA smoke test (or targeted NVDA check)
3. Log entry
4. Keep / modify / revert decision

## Human Responsibility
The human operator is responsible for:
- defining the test goal
- deciding whether to apply AI suggestions
- verifying outputs directly
- rejecting unsafe, irrelevant, or unverified suggestions
- documenting outcomes truthfully

AI suggestions are treated as proposals, not authoritative facts.

## Allowed AI Uses
AI may be used for:
- interpreting build errors and warnings
- proposing minimal testable patches
- suggesting HTML/CSS/LaTeX conversion experiments
- designing or refining test checklists
- drafting concise logs and summaries from verified evidence
- organizing workflow documentation

## Restricted AI Uses
AI must not be used to:
- fabricate test results, logs, or evidence
- claim accessibility improvements without verification
- perform blind large-scale rewrites of source files
- hide unresolved errors or limitations
- introduce unverified mathematical claims into final academic work

## Verification Workflow (Operational)
For each AI-assisted change:
- Record the task in the AI Assistance Log
- State the target behavior (what is being improved or tested)
- Apply one change at a time where practical
- Rebuild using the current command/workflow
- Run NVDA test on the affected area
- Record result:
  - Accepted
  - Modified and accepted
  - Rejected
  - Inconclusive
- Note regressions and rollback actions if needed

## Evidence Locations (Current)
Primary workflow/evidence locations currently include:

- `website/project/checklist/`
  - accessibility checklists and inspection materials
- `website/project/experiments/tex4ht-pipeline/`
  - smoke tests and tex4ht experiment files
- `website/project/logs/week1/part1/`
  - Week 1 Part 1 smoke test logs
- `website/project/logs/week1/part2/`
  - HTML build error log, NVDA test log, Week 1 baseline summary
- `website/project/workflow/`
  - workflow status notes and responsible AI use document
- `website/evidence/tex4ht/week1/`
  - additional week 1 evidence/checkpoint notes (excluding unfilled templates)

## AI Assistance Logging
AI-assisted work should be recorded in a lightweight log.

Minimum fields for each meaningful entry:
- Date
- Task
- AI used (Yes / No / Mixed)
- AI role (debug / refactor / documentation / test planning)
- What was changed or tested
- Human verification performed
- Outcome
- Decision (accepted / modified / rejected / deferred)

This log should remain concise and screen-reader friendly.

## Known Limitations
Known limitations are documented explicitly and not hidden. These may include:
- tex4ht/make4ht build errors with usable HTML output
- partial semantic HTML improvements
- environment-specific behavior differences
- AI suggestions that appear plausible but are toolchain-incompatible
- temporary reliance on manual artifact cleanup in local testing mode

## Prompting Constraints
AI prompts should be:
- specific
- minimal
- focused on one issue at a time
- grounded in observed behavior

Important constraint:
Preserve known-good math reading behavior unless the test is specifically about changing math output.

## Change Control Pattern (Lightweight)
Preferred pattern:
- one hypothesis
- one change
- one build
- one NVDA check
- one log entry

This reduces cognitive load and improves auditability.

## Week 1 Provenance Note
Week 1 technical logs were detailed, but AI involvement was not always recorded at the time.
Week 1 AI attribution in `AI_Assistance_Log.md` includes retrospective attribution where needed.

From Week 2 onward, AI involvement should be recorded during the work session.

## Versioning
Version: v1
Status: Active draft
Updated: 2026-02-25

This document will be revised as the workflow transitions from local manual extraction mode to a structured website build pipeline.