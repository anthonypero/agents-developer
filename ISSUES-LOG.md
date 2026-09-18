# Skills and agents issues log

Running log of problems hit with skills or subagents in real sessions. One entry per incident, newest first. The point is to see patterns: if entries pile up against one agent, that agent's effort or model gets raised; if they pile up against one skill, the skill gets rewritten. Fixes are noted inline when made; an open entry has no **Fix** line.

Format: date, target (skill or agent name), what happened, why it mattered, fix if any.

## 2026-09-04 — `pager` skill

The skill said to start the label poller only after the first outbound email. The user emailed an instruction at 7:38 am, before any hand-back moment, and it sat unread until after the work it was meant to shape had been done. The user's expectation was continuous polling from `/pager on`. **Fix:** skill rewritten the same day (agent-skills commit b22e29f): poller starts at `/pager on` and is restarted after every exit. Also observed: `gws gmail list` with `label:<Label_ID>` returned 0 hits where `label:<name>` found the message; the poller uses the name, so no change needed.

## 2026-09-08 — `coder` and `checker` agents (harness)

Subagents could not write their reports to the session scratchpad (`/private/tmp/claude-502/.../scratchpad/briefs/report-*.md`): both coders and the checker reported the write blocked, while the same content wrote fine under the project tree (`.agents/subprojects/<name>/notes/drafts/`). Workaround: brief agents to write reports into the project tree, or have the lead transcribe from the message. Also observed: inter-agent messages (idle notifications and `SendMessage` payloads) truncate at roughly 5500 characters with "[result truncated — ask the agent for the rest via SendMessage]", so a long report arrives headless; the checker's first report lost its tail twice. Workaround: reports go to disk, messages carry a sub-2000-character summary. **Fix (briefs):** `coder`/`checker` briefs should name a report path inside the project tree and cap the return message.

## 2026-09-08 — checker: cannot deliver its report file
Brief asked `checker` to write its findings to a `.md` path (the deliverable). The agent refused ("my role is read-only and this session's instructions forbid writing findings documents") and its text reply truncated at ~5500 chars, losing findings 5+; a second request was needed and the lead had to transcribe the report to disk. Either allow the checker to write to a `notes/drafts/` report path, or make the brief template say "text only, keep under 4000 chars, lead records it". Second pile-up on the same agent today (see the message-truncation entry above).

## 2026-09-15 — ring: sound looped, no Dismiss popup

Second `ring.sh --message` call of the session (after pulling `2f92195` "loop the alert until Dismiss is clicked"): the horn looped but no popup appeared, so the user had no way to silence it and had to interrupt. First call earlier the same session (same code) showed the popup and Dismiss worked. Killed with `pkill -f afplay`. Suspect: System Events dialog failed to raise (osascript error swallowed) while the loop kept playing — the loop must exit if the dialog process dies or fails to start.
