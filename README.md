# Goal Mode

Independent **/goal** skill for any coding agent — Cursor, Claude Code, Codex, OpenCode, Gemini CLI, Windsurf, Copilot, Cline, and more.

Not a plugin for any other product. Just a skill: durable board, one active task, Scout / Judge / Worker hats on the same thread, receipts, run until the outcome is proven.

[![skills.sh](https://skills.sh/b/arjunkshah12345-hash/goal-mode)](https://skills.sh/arjunkshah12345-hash/goal-mode)

## Install

```bash
npx skills add arjunkshah12345-hash/goal-mode
```

Global, all agents:

```bash
npx skills add arjunkshah12345-hash/goal-mode -g -a '*' -y
```

## Use

- `/goal <what you want done>`
- `goal mode: <outcome>`
- `/goal-prep <outcome>` — board only, no product work yet

Creates `docs/goals/<slug>/goal.md` + `state.yaml`, then executes slice-by-slice until `full_outcome_complete: true`.

## License

MIT
