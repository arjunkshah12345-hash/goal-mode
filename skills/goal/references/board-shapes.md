# Board shapes by goal kind

## `specific`

Skip broad Scout if the path is already clear. Seed:

1. Judge — confirm slice + verify
2. Worker — implement
3. Judge — audit / complete

## `open_ended`

Default seed in `templates/state.yaml` (Scout → Judge → Worker → Judge).

## `existing_plan`

Preserve user steps in `existing_plan_facts`. First Scout validates the plan against the repo; Judge may reorder but must not silently drop user facts.

## `recovery`

Scout focuses on failure evidence, last good state, and blast radius. First Worker is the smallest safe restore/fix with explicit `stop_if`.

## `audit`

Scout + Judge only unless the user asked for fixes. Completion proof is a written audit artifact, not a code change.
