# <Goal Title>

## Objective

<Bounded outcome for this goal.>

## Original Request

<Shortest faithful copy of what the user asked.>

## Intake Summary

- Input shape: `vague | specific | existing_plan | recovery | audit`
- Audience: <beneficiary or unknown>
- Authority: `requested | approved | inferred | needs_approval | blocked`
- Proof type: `test | demo | artifact | metric | review | source_backed_answer | decision`
- Completion proof: <observable signal that closes the full outcome>
- Likely misfire: <how goal mode could succeed at the wrong thing>
- Blind spots considered: <list or none>
- Existing plan facts: <user steps/files/constraints to preserve, or none>

## Goal Kind

`specific | open_ended | existing_plan | recovery | audit`

## Current Tranche

<Safe continuous slice plan until the full outcome is complete.>

## Non-Negotiable Constraints

- <constraint>

## Stop Rule

Stop only when a final audit proves the full original outcome is complete.
Do not stop after planning or a single verified slice if more safe work remains.
Blocked slices get a receipt; continue other safe local work.

## Canonical Board

`docs/goals/<slug>/state.yaml` wins over this charter for task status and completion truth.

## Run Command

```text
/goal Follow docs/goals/<slug>/goal.md.
```

## PM Loop

1. Read charter + `state.yaml`
2. Re-check intake and misfire
3. One active task only
4. Wear Scout / Judge / Worker / PM hat
5. Write receipt; update board
6. Activate safe Worker and continue
7. Finish only with `full_outcome_complete: true`
