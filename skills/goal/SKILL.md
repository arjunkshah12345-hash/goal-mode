---
name: goal
description: >
  Portable /goal mode for any coding agent. Use when the user says /goal, goal mode,
  run as a goal, long-running / multi-step / vague / stalled work that needs a durable
  board, one active task, Scout/Judge/Worker hats, receipts, and continuous execution
  until the full outcome is proven complete. Also use for /goal-prep when they only
  want the board compiled first.
---

# Goal Mode (portable)

Bring GoalBuddy-style `/goal` to **any** agent. No native slash command required.
Roles are **hats on the same thread** (PM fallback). Do not launch Task subagents
unless the user explicitly names one.

## Triggers

Treat as goal mode when the user:

- says `/goal`, `goal mode`, `$goal`, or `run this as a goal`
- asks for broad, long-running, multi-slice, vague, recovery, or audit work that needs a board
- says `/goal-prep` or `$goal-prep` (prep-only — see boundary below)

One-change tasks: do **not** create a board. Just do the work.

## Two modes

| Invoke | Behavior |
|--------|----------|
| `/goal-prep …` | Compile intake + board files only. Do **not** implement product work. End with the exact continue line. |
| `/goal …` or `goal mode: …` | Prep if needed, then **execute** until full outcome or hard stop. |

### Prep boundary (strict)

During `/goal-prep` only:

- create/repair `docs/goals/<slug>/goal.md`, `state.yaml`, `notes/`
- ask intake questions when vague
- print exactly: `/goal Follow docs/goals/<slug>/goal.md.`
- ask whether to start `/goal`, refine, or stop

Do **not** edit product code, load other skills for implementation, or “just peek” at files beyond what’s needed to name the slug and constraints. Put real work on the board.

## Control files

```text
docs/goals/<slug>/
  goal.md       # charter (editable)
  state.yaml    # board truth (wins on conflict)
  notes/        # long receipts only
```

Copy templates from this skill’s `templates/` when creating a new goal.
Slug: short kebab from the outcome (`fix-auth-flakes`, `ship-plugin-launch`).

Optional helper:

```bash
bash <this-skill>/scripts/init-goal.sh <slug> "<title>"
```

## Intake (private)

Before the first board write, compile silently:

- original request (shortest faithful wording)
- interpreted outcome (what must become true)
- input shape: `vague | specific | existing_plan | recovery | audit`
- non-goals / hard constraints
- authority: `requested | approved | inferred | needs_approval | blocked`
- proof type: `test | demo | artifact | metric | review | source_backed_answer | decision`
- completion proof (observable)
- likely misfire (how to succeed at the wrong thing)
- blind spots

If vague/open-ended and user didn’t accept defaults: ask **one** guided question at a time (2–3 options + recommended default), then wait. Do not dump the private intake.

## Roles (hats)

| Role | Duty | Writes product code? |
|------|------|----------------------|
| **PM** | Owns `state.yaml`, one active task, loop, escalations | Only via an explicit PM/Worker task |
| **Scout** | Read-only map, candidates, evidence | No |
| **Judge** | Pick next safe Worker slice; final audit | No |
| **Worker** | Implement one slice with `allowed_files`, `verify`, `stop_if` | Yes, inside bounds |

If dedicated agents exist, may delegate; otherwise wear the hat and record `assignee` honestly.

## PM loop (every `/goal` turn)

1. Read `goal.md` + `state.yaml` (`state.yaml` wins for status/active/receipts).
2. Re-check intake: outcome, proof, misfire, constraints.
3. Work **only** the `active_task`.
4. Wear the task’s role hat; produce a compact receipt.
5. Update the board (mark done/blocked, set next `active_task`).
6. If Judge selected a safe Worker (`allowed_files` + `verify` + `stop_if`), activate it and **continue in the same run**.
7. Blocked ≠ stop: receipt the block, queue workaround, continue local safe work.
8. Stop only when a Judge/PM audit receipt sets `full_outcome_complete: true` mapped to the original outcome.

Bias: users want **work done**, not a plan. Planning-only when they explicitly ask.

## Task rules

- Exactly one `active` task.
- Max one writing Worker at a time.
- No implementation without a Worker or explicit PM task.
- No completion without Judge/PM audit.
- Planning is not completion.
- Queued required Worker blocks completion.
- Continuous until full outcome ( successive safe slices ).
- Missing credentials/input: block that slice, continue everything else safe.
- Preserve and validate any user-provided plan facts.

## Receipts

After each task, write a short receipt into `state.yaml` (and `notes/<id>.md` only if long):

```yaml
receipt:
  summary: "<what happened>"
  evidence: ["path or command"]
  verify: "<command or check + result>"
  next: "<recommended next task id or none>"
  full_outcome_complete: false
```

Final audit must map receipts → original outcome and set `full_outcome_complete: true`.

## Seed board (default)

When creating a fresh execution goal:

1. **T001 Scout** — map repo, verify commands, ranked candidates (read-only)
2. **T002 Judge** — pick first safe Worker slice
3. **T003 Worker** — implement slice (fill `allowed_files` / `verify` / `stop_if` after Judge)
4. **T004 Judge** — audit slice; either next Worker or final audit

Adjust for `specific` / `existing_plan` / `recovery` / `audit` kinds — see `references/board-shapes.md`.

## Operator escalation

Ask the human only for: secrets, production access, destructive ops, product choices, or policy. Phrase with tradeoff options. Never invent approval.

## Hard stops

Stop the run (leave board `active`/`blocked`) if:

- authority is `blocked` or `needs_approval` for the only remaining path
- user said plan-only / stop
- repeated verify failure with no safe workaround (escalate)

## Relation to GoalBuddy

Compatible file layout with GoalBuddy v2. Optional: `npx goalbuddy` for visual board / dedicated agents. This skill does **not** require it.

## Continue line

After prep, always print:

```text
/goal Follow docs/goals/<slug>/goal.md.
```
