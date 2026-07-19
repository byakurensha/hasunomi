# General Core Rules

## Session model

- The VS Code Claude Code session is the user's unit of work. Never require the
  user to select an internal project, change folders, or maintain a pointer.
- General questions that create no files, deliverables, or durable decisions do
  not need a project.
- Before work creates or modifies durable files, accepts source material,
  produces a deliverable, or must continue later, use the project-work skill.
- A resumed session reconnects to its project through the SessionStart hook and
  the session ID recorded in `MASTER.md`.

## Durable work

- Internal projects use `PROJECTS/YYYY-MM/YYYY-MM-DD_name/`. The name follows
  the user's active language; do not translate Japanese names into English for
  filesystem convenience. Projects contain only
  `MASTER.md`, `Materials/`, `Output/`, and `Archives/`.
- `MASTER.md` is the sole current-state record. Do not add project-local
  `CLAUDE.md`, current-project pointers, or duplicate task systems.
- Copy accepted attachments and source files into `Materials/` before relying
  on them. Preserve the original source.
- Save canonical deliverables in project `Output/`. Copy human-ready results
  to Desktop `OUTBOX/`. Archive replaced project versions instead of deleting
  them.
- Do not create or use a General-local `INBOX/` or `OUTBOX/`.

## Delivery routes

- Human pickup: Desktop `OUTBOX/`.
- Cross-environment or cross-session handoff: use the share-delivery skill to
  place a selected project `Output/` file in Desktop `SHAREBOX/`, or to import
  one explicitly selected queue item into the linked project's `Materials/`.
- SHAREBOX is one flat queue. Do not create direction folders or infer a route
  from a folder name. When direction or purpose matters, include it in a small
  handoff Markdown file beside the payload.
- Cloud delivery is optional and environment-owned. Use it only when an
  explicitly installed delivery skill defines the route. The public pack does
  not invent or configure a cloud transport.
- Desktop `SHAREBOX/` is a temporary handoff surface, not an archive. Never
  overwrite a same-name item. Remove a queue source only after verified intake.

## Documents and OCR

- Template choice gate: when a requested deliverable matches any supplied
  template, ask before creating files whether to use that template or make a
  free design. Apply this to A4 documents, meeting minutes, photo slides,
  six-up receipts, simple slides, newsletters, flyers, and future supplied
  templates. Skip the question only when the user has already chosen the
  supplied template or free design for this deliverable in the current
  request. Do not infer consent from the document type, prior template use, a
  request for a test or sample, or the saved settings.
- When the user chooses the supplied template, follow its Skill and replace or
  remove sample content as the project requires. When the user chooses free
  design, do not run the supplied template's creation command or impose its
  layout.
- Supplied A4 and meeting-minutes workflows share one bundled A4 template and
  create editable ODT by default. Meeting-minute and meeting-resume section
  lists are reference structures, not mandatory forms: select, omit, reorder,
  or add shared A4 components to fit the meeting purpose. Create PDF only when
  explicitly requested.
- The supplied photo-slide workflow creates an editable 16:9 ODP with one of
  six photo-first layouts. Create PDF only when explicitly requested.
- The supplied six-up receipt workflow creates an editable A4 landscape ODG
  with six exact `148.5 x 70 mm` Japanese receipts. Print at 100 percent and
  create PDF only when explicitly requested.
- Free design work is not constrained by the bundled template, Noto Sans, ODT,
  LibreOffice, or one production method.
- OCR creates extracted Markdown and never modifies the source. Report the
  backend actually used and any fallback.

## External plugins

- External Claude Code plugins are optional extensions, not HASUNOMI product
  files. Manage them with Claude Code's built-in `/plugin` interface.
- Do not copy an installed plugin into `.claude/skills/` or make General depend
  on it unless the user explicitly adopts that dependency.
- Add only trusted marketplaces. Plugin updates may change behavior outside a
  HASUNOMI release, so report the installed plugin and marketplace when it
  materially affects work.

## Memory, improvement, and safety

- Current work belongs in project `MASTER.md`; reusable preferences and lessons
  belong in `MEMORY/`.
- Run the formal seven-stage improvement process when requested or when
  accumulated evidence shows that its expected benefit justifies the time and
  maintenance cost. Completed work entries are evidence, not an automatic
  trigger.
- Improvement owns evidence-backed method changes. Its final gate runs a small
  structural check. Use the separate repair skill only when that gate or the
  user identifies cross-file inconsistency, duplicated ownership, retired
  routes, or growth in always-loaded guidance.
- Repair consolidates and verifies the system; it is not a fixed periodic task.
  Prefer replacing or removing stale guidance over adding another rule, and do
  not remove a working capability merely to reduce file size.
- Keep credentials and private data out of Git, logs, Memory, and records.
- Treat Git as an automatic, small major-Markdown checkpoint. Project
  completion records its own project immediately; the next session start
  quietly records any remaining allowed Markdown changes. Never force-add
  project `Materials/`, `Output/`, or `Archives/`; normal backup owns those
  files. The user does not need to operate VS Code Source Control.
- Announce environment changes before making them. Stop only for credentials,
  payment, administrator authentication, destructive actions, or decisions
  that materially change the user's workflow.
- Follow `SETTINGS.md` for confirmation, record detail, planning, language, and
  OCR preferences.
