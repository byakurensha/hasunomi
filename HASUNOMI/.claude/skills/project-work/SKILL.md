---
name: project-work
description: Create or reconnect durable work behind the current Claude Code session. Use before accepting source files, creating deliverables, modifying durable files, or starting work that must continue later.
---

# Project Work

The user manages Claude Code sessions, not internal project folders.

1. Read the SessionStart context. If it names a linked project, read that
   project's `MASTER.md` before acting.
2. If no project is linked and the request is durable work, create one with a
   concise name in the user's active language and a human title. Preserve
   natural Japanese and other non-Latin names; do not translate them into
   English merely to create a folder name:

   ```text
   python3 system/management-tool/management-tool project start \
     --session SESSION_ID --name "project name" --title "Project title"
   ```

3. If the user explicitly wants an existing project from a different session,
   list projects and link the current session through the management tool.
4. Copy each accepted attachment or source file into `Materials/` with project
   `intake` before relying on it. Preserve the original.
5. Work in the linked project. Keep current state and the next action in
   `MASTER.md`; canonical deliverables go in `Output/`.
6. Use project `deliver` to copy human-ready output to Desktop `OUTBOX/`.
   Use the share-delivery skill to copy a file for another environment to
   Desktop `SHAREBOX/`. Use a cloud-delivery skill only when the current
   environment explicitly provides one.
7. At a meaningful durable checkpoint, use project `complete` once to record
   the result. Do not run it for conversational steps or intermediate tool
   calls.

Do not create a project for an ordinary answer with no files, deliverables, or
durable decision. Do not ask the user to choose a project unless the request
explicitly refers to multiple plausible existing projects.
