# Skills and agents issues log

Running log of problems hit with skills or subagents in real sessions. One entry per incident, newest first. The point is to see patterns: if entries pile up against one agent, that agent's effort or model gets raised; if they pile up against one skill, the skill gets rewritten. Fixes are noted inline when made; an open entry has no **Fix** line.

Format: date, target (skill or agent name), what happened, why it mattered, fix if any.

## 2026-09-04 — `pager` skill

The skill said to start the label poller only after the first outbound email. The user emailed an instruction at 7:38 am, before any hand-back moment, and it sat unread until after the work it was meant to shape had been done. The user's expectation was continuous polling from `/pager on`. **Fix:** skill rewritten the same day (agent-skills commit b22e29f): poller starts at `/pager on` and is restarted after every exit. Also observed: `gws gmail list` with `label:<Label_ID>` returned 0 hits where `label:<name>` found the message; the poller uses the name, so no change needed.
