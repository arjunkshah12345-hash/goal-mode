---
name: goal
description: >
  Independent /goal mode for any coding agent. Use when the user says /goal, goal mode,
  run as a goal, or needs long-running / multi-step / vague / stalled work with a durable
  board, one active task, Scout/Judge/Worker hats, receipts, and continuous execution
  until the full outcome is proven complete. Also use for /goal-prep when they only want
  the board compiled first. This skill is standalone — not GoalBuddy or any other product.
---

# Goal Mode

Standalone `/goal` for **any** agent. No native slash command required.
Roles are **hats on the same thread**. Do not launch Task subagents unless the user
explicitly names one.

## Triggers

- `/goal`, `goal mode`, `$goal`, or `run this as a goal`
- broad / long-running / multi-slice / vague / recovery / audit work that needs a board
- `/goal-prep` or `$goal-prep` (prep-only)

One-change tasks: do **not** create a board. Just do the work.

## Two modes

| Invoke | Behavior |
|--------|----------|
| `/goal-prep …` | Compile intake + board only. No product work. End with the continue line. |
| `/goal …` or `goal mode: …` | Prep if needed, then execute until full outcome or hard stop. |

### Prep boundary

During `/goal-prep` only:

- create/repair `docs/goals/<slug>/goal.md`, `state.yaml`, `notes/`
- ask intake questions when vague
- print exactly: `/goal Follow docs/goals/<slug>/goal.md.`
- ask whether to start `/goal`, refine, or stop

Do not edit product code or load other skills for implementation. Put real work on the board.

## Control files

```text
docs/goals/<slug>/
  goal.md       # charter (editable)
  state.yaml    # board truth (wins on conflict)
  notes/        # long receipts only
```

Copy from this skill’s `templates/`. Slug: short kebab (`fix-auth-flakes`).

```bash
bash <this-skill>/scripts/init-goal.sh <slug> "<title>"
```

## Intake (private)

Before the first board write, compile silently:

- original request · interpreted outcome
- input shape: `vague | specific | existing_plan | recovery | audit`
- non-goals / hard constraints
- authority: `requested | approved | inferred | needs_approval | blocked`
- proof type: `test | demo | artifact | metric | review | source_backed_answer | decision`
- completion proof · likely misfire · blind spots

If vague and defaults not accepted: one guided question at a time (2–3 options + recommended default), then wait.

## Roles (hats)

| Role | Duty | Writes product code? |
|------|------|----------------------|
| **PM** | Owns `state.yaml`, one active task, loop | Only via explicit PM/Worker task |
| **Scout** | Read-only map, candidates, evidence | No |
| **Judge** | Pick next safe Worker slice; final audit | No |
| **Worker** | One slice with `allowed_files`, `verify`, `stop_if` | Yes, inside bounds |

## PM loop (every `/goal` turn)

1. Read `goal.md` + `state.yaml` (`state.yaml` wins for status/active/receipts).
2. Re-check intake: outcome, proof, misfire, constraints.
3. Work **only** the `active_task`.
4. Wear the task’s role hat; write a compact receipt.
5. Update the board; set next `active_task`.
6. If Judge selected a safe Worker (`allowed_files` + `verify` + `stop_if`), activate and **continue in the same run**.
7. Blocked ≠ stop: receipt the block, queue workaround, continue safe local work.
8. Stop only when a Judge/PM audit sets `full_outcome_complete: true` for the original outcome.

Bias: users want **work done**, not a plan — unless they ask for planning-only.

## Task rules

- Exactly one `active` task · max one writing Worker
- No implementation without Worker or explicit PM task
- No completion without Judge/PM audit · planning ≠ completion
- Continuous until full outcome · missing credentials block that slice only
- Preserve and validate user-provided plan facts

## Receipts

```yaml
receipt:
  summary: "<what happened>"
  evidence: ["path or command"]
  verify: "<command + result>"
  next: "<task id or none>"
  full_outcome_complete: false
```

Long receipts go in `notes/<id>.md`. Final audit must map receipts → original outcome.

## Seed board

1. **T001 Scout** — map repo, verify commands, ranked candidates  
2. **T002 Judge** — first safe Worker slice  
3. **T003 Worker** — implement (`allowed_files` / `verify` / `stop_if` from Judge)  
4. **T004 Judge** — audit; next Worker or complete  

See `references/board-shapes.md` for other kinds.

## Escalation / hard stops

Ask the human only for secrets, production access, destructive ops, product choices, or policy.
Stop the run if authority is blocked for the only path, user said stop/plan-only, or verify keeps failing with no safe workaround.

## Continue line

```text
/goal Follow docs/goals/<slug>/goal.md.
```
