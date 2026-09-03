# agents-developer

Personal Claude Code agent definitions, one Markdown file per agent, flat. Each file's frontmatter pins the agent's model, effort, and tools so a delegated task never inherits the parent session's model. Companion to `skills-developer`, which holds skills the same way.

## Install

```sh
./install.sh
```

Symlinks every `*.md` here (except this README) into `~/.claude/agents/`. Claude Code only discovers agents in `~/.claude/agents/` or a project's `.claude/agents/`, so the symlink is what makes them live. New sessions pick them up; the current one does not.

## Agents

| Agent | Model / effort | Tools | Use for |
| --- | --- | --- | --- |
| `coder` | Opus, high | all | Substantial builds from a written brief: implement, fix, write a document from sources, run a long tool loop |
| `checker` | Opus, high | read-only | Independent verification of a coder's output against its sources or spec; cannot edit, so its findings are not self-serving |

`repo-master` (Sonnet, git and GitHub operations) is not here. Its definition ships inside the `repo-master` skill in `agent-skills` and is symlinked by that skill's install step, because the agent and the skill are one unit.

## Conventions

- Frontmatter keys: `name`, `description`, `model`, `effort`, `tools`, `color`. Effort is the only place it can be set; the Agent tool has no per-spawn effort parameter.
- Effort defaults follow Anthropic's Opus 5 guidance: start at `high`; add an explicit `*-deep` variant at `xhigh` only when a role has shown it needs it.
- Agents start with no conversation context. Write the body as standing rules for a role, not as a task; the task comes in the brief.
