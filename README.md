# Goal Mode

Portable **/goal** for any coding agent — Cursor, Claude Code, Codex, OpenCode, Gemini CLI, Windsurf, Copilot, Cline, and friends.

GoalBuddy-style autonomous work without requiring a tool-specific `/goal` slash command or dedicated Scout/Judge/Worker agents. One PM thread runs the loop; roles are **hats**, not separate processes.

[![skills.sh](https://skills.sh/b/Supercompress/goal-mode)](https://skills.sh/Supercompress/goal-mode)

## Install

```bash
npx skills add Supercompress/goal-mode
```

Global, all agents:

```bash
npx skills add Supercompress/goal-mode -g -a '*' -y
```

## Use

Say any of:

- `/goal <what you want done>`
- `goal mode: <outcome>`
- `run this as a goal until done: <outcome>`

The agent will create `docs/goals/<slug>/`, run intake → board → one active task → receipt → next task until the full outcome is proven complete.

## What you get

- Durable board: `docs/goals/<slug>/goal.md` + `state.yaml`
- One active task at a time
- Scout / Judge / Worker / PM roles (PM fallback when no subagents)
- Receipts + completion audit
- Works where native `/goal` does not exist

## License

MIT
