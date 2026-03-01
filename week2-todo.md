# Week 2 Commit Sequence Plan

## Purpose
This plan keeps Week 2 version control clean while working on structural HTML semantics (lists, theorem blocks, heading normalization) without losing the Week 1 evidence trail.

Use small, testable commits that match the workflow rule:

- one hypothesis
- one change
- one build
- one NVDA check
- one log entry
- one commit

---

## Week 2 Scope (Current)
Primary targets:
1. list semantics (`dl/dt/dd` → `ol/li`)
2. theorem-like block structural identification
3. optional heading hierarchy normalization (`h2` gap), only if low risk
4. preserve known-good math accessibility behavior

Do **not** mix all of these in one commit.

---

## Commit Strategy (Recommended)
Use `website/` as the main Week 2 evidence/workflow repo for commits.

If changes are made in `cambridge-maths-notes/` (local source repo), commit only source-side technical changes separately with `fix:` messages.

---

## Recommended Week 2 Commit Sequence (website repo)

### Commit 1 — Week 2 logging and scaffolding
**Goal:** Start Week 2 with clean records before experiments.

**What to include**
- `project/logs/week2/` folder creation
- `project/logs/week2/Week2_Fix_Log.md` (initial template or first entry)
- optional `project/logs/week2/README.md`
- updates to `project/workflow/WORKFLOW-STATUS.md` (Week 2 started)
- any checklist normalization/renames (if small and relevant)

**Commit type**
- `log:` or `workflow:`

**Suggested message**
- `log: initialize Week 2 logs and fix tracking`
- or `workflow: start Week 2 structural semantics work`

**Commit only if**
- Week 2 logging files clearly state purpose and recording format
- No experimental code mixed in yet

---

### Commit 2 — List semantics experiment prototype (no claim of success yet)
**Goal:** Add the first deterministic post-processing attempt for ordered list semantics.

**What to include**
- post-processing script prototype (e.g. under `website/src/`, `website/project/experiments/`, or scripts area)
- small test notes describing target HTML pattern (`dl/dt/dd` case)
- optional sample before/after snippet in logs (text only)

**Commit type**
- `exp:` (if experimental)
- `fix:` (only if already validated)

**Suggested message**
- `exp: add ordered-list semantics post-processing prototype`

**Commit only if**
- script/prototype is isolated
- target pattern is documented
- no unverified “fixed” claim is made

---

### Commit 3 — List semantics fix verified (build + NVDA)
**Goal:** Record the first verified list semantics improvement.

**What to include**
- updated post-processing script (validated version)
- `Week2_Fix_Log.md` entry with:
  - change made
  - build result
  - NVDA result
  - decision (accepted/modified/rejected)
- updated NVDA/build logs if you split logs by function
- summary note of regression check (especially math unchanged)

**Commit type**
- `fix:` + `log:` (prefer one commit if tightly coupled)
- If split:
  - code commit first (`fix:`)
  - log commit second (`log:`)

**Suggested message (single commit)**
- `fix: normalize ordered list semantics and log Week 2 verification`

**Commit only if**
- build completed
- NVDA list announcement checked
- math accessibility spot-check performed
- result logged clearly (even if partial success)

---

### Commit 4 — Theorem block structure experiment
**Goal:** Test structural identification approach for theorem-like environments without breaking math.

**What to include**
- theorem/proof structural enhancement prototype (wrapper/heading/ARIA experiment)
- Week 2 log entry for experiment setup and expected behavior
- evidence notes on what is being tested (landmark, heading, or grouping)

**Commit type**
- `exp:`

**Suggested message**
- `exp: prototype theorem block structural grouping for NVDA navigation`

**Commit only if**
- experiment scope is narrow
- no broad source rewrite
- target behavior is logged before claiming improvement

---

### Commit 5 — Theorem structure retest + decision
**Goal:** Document whether theorem experiment is accepted, deferred, or revised.

**What to include**
- updated theorem post-processing logic (if successful)
- Week 2 logs with NVDA findings and regression check
- decision recorded:
  - accepted
  - partial / deferred
  - rejected (with reason)

**Commit type**
- `log:` (if documenting result only)
- `fix:` (if accepted code change)
- `exp:` (if still experimental)

**Suggested messages**
- `log: record Week 2 theorem block retest and decision`
- or `fix: add theorem block headings and verify NVDA discoverability`
- or `exp: document partial theorem grouping results and defer final fix`

**Commit only if**
- outcome is explicit
- math behavior regression check recorded
- unresolved limitations are documented honestly

---

## Optional Commit 6 — Week 2 summary checkpoint (recommended)
**Goal:** End Week 2 with a stable summary and next-step direction.

**What to include**
- `project/logs/week2/Week2_Summary.md` (if used)
- updates to `AI_Assistance_Log.md` for Week 2 entries
- updates to `WORKFLOW-STATUS.md`
- any finalized checklist changes

**Commit type**
- `log:` or `workflow:`

**Suggested message**
- `log: add Week 2 summary and update AI assistance records`

**Commit only if**
- Week 2 decisions and remaining issues are clear
- next priorities are listed
- no unresolved experimental code is mixed without labels

---

## If You Also Commit in cambridge-maths-notes (local repo)
Only commit when the source-side change is real and intentional (not just generated artifacts changing).

### Good reasons to commit there in Week 2
- source-side package/config adjustment needed for conversion
- reproducible local baseline patch
- clearly scoped change supporting HTML conversion testing

### Avoid committing there for
- temporary generated outputs only
- repeated re-runs with no source changes
- ambiguous edits not reflected in logs

### Example messages (cambridge repo)
- `fix: adjust ia/ns build config for Week 2 list semantics testing`
- `fix: isolate conversion change for theorem structure experiment`

---

## Commit Message Pattern (Week 2)
Use:

    <type>: <specific action>

Allowed types:
- `log:`
- `workflow:`
- `exp:`
- `fix:`
- `chore:`

Examples:
- `log: initialize Week 2 logs and fix tracking`
- `exp: add ordered-list semantics post-processing prototype`
- `fix: normalize ordered list semantics and verify NVDA list counts`
- `exp: prototype theorem block structural grouping`
- `log: record Week 2 theorem retest and defer final fix`

---

## Do Not Do This (Week 2)
Avoid these history problems:
- one giant commit covering lists + theorem + headings + docs
- code changes without logs
- logs claiming success before NVDA verification
- rewriting Week 1 records instead of adding Week 2 records
- mixing `website` process commits with unrelated `cambridge-maths-notes` source edits

---

## Session-Level Mini Checklist (Before Each Week 2 Commit)
- [ ] One issue only (lists OR theorem OR headings OR logging)
- [ ] Build run completed
- [ ] NVDA check completed (or explicitly not applicable)
- [ ] Result logged
- [ ] Decision recorded
- [ ] No accidental temp/build files staged
- [ ] Commit message matches actual outcome

---

## Suggested Minimal Week 2 Path (if energy is limited)
If you want the smallest clean sequence, do just these 4 commits in `website`:

1. `log: initialize Week 2 logs and fix tracking`
2. `exp: add ordered-list semantics post-processing prototype`
3. `fix: normalize ordered list semantics and log verification`
4. `log: add Week 2 summary and update AI assistance records`

Then move theorem work to Week 3 if needed.