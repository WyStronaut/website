# Logs Folder README

## Purpose
This folder contains test logs, build logs, summaries, and AI assistance records for the accessibility workflow.

These logs are part of the project evidence trail.

## Evidence-of-Record (Logs)
The files in this folder are the primary log records for:
- build outcomes
- NVDA accessibility testing
- baseline summaries
- AI assistance provenance

Generated HTML/CSS/PDF files in source folders are inspection artifacts unless explicitly copied and documented here or in `website/evidence/`.

## Folder Structure

- `AI_Assistance_Log.md`
  - Cross-week record of AI-assisted (and non-AI) tasks, with verification and decisions.

- `week1/`
  - Week 1 logs
  - `part1/` = smoke test / prelim pipeline setup
  - `part2/` = IA Numbers and Sets baseline build + NVDA validation

- `week2/`
  - Week 2 logs (structural semantics fixes, retesting, regressions, summaries)

## Canonical Week 1 Files

### Week 1 Part 1 (smoke test / prelim)
- `week1/part1/smoke-test-log.md`
- `week1/part1/week1-checkpoint-note.md` 

### Week 1 Part 2 (IA NS baseline)
- `week1/part2/HTML_Build_Error_Log.md`
- `week1/part2/NVDA_Test_Log.md`
- `week1/part2/Week1_Baseline_Summary.md`

## Non-Canonical / Excluded Items (Week 1)
These should not be used as primary factual sources unless explicitly completed and marked active.

If kept, mark clearly as:
- `DUPLICATE_*`
- `TEMPLATE_*`
- or note status at top of file

## Naming Convention (Logs Folder)
Use **Title_Case** for formal logs and summaries:
- `HTML_Build_Error_Log.md`
- `NVDA_Test_Log.md`
- `Week1_Baseline_Summary.md`

Use **kebab-case** for operational checklists/templates/scripts stored elsewhere.

## Logging Rules (Operational)
For each meaningful test/change cycle, record:
- Date
- Task
- What changed or was tested
- Build result
- NVDA verification (if applicable)
- Outcome
- Decision (accepted / modified / rejected / deferred)

If AI is used, also record:
- AI used (Yes / No / Mixed)
- AI role (debug / refactor / documentation / test planning)

## Week 2 Requirement
AI involvement must be recorded at the time of work (not reconstructed retrospectively).

## Maintenance Notes
- Prefer adding new logs over rewriting old ones.
- If a file is superseded, keep the old file and mark it as superseded.
- Avoid duplicate filenames in multiple locations unless one is clearly marked as archival/template.