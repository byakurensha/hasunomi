---
name: setup
description: Run first-time language selection, preferences, environment preparation, validation, and orientation. Use when the user asks for setup or initial setup.
---

# Setup

Run in this order.

1. Display this menu in English:

   ```text
   Choose your language / Enter a number:
   1. Japanese
   2. English
   3. Other Languages
   ```

2. Ask these three preference questions one at a time in the selected language.
   Use numbered choices and put the balanced recommendation first:
   - How often should Claude stop for confirmation?
   - How detailed should work records be?
   - When should Claude make a plan before acting?
3. Save language and answers in `SETTINGS.md`. Do not ask about primary use,
   common deliverables, fears, or undesired outcomes.
4. Announce checks and installations before running them. Do not ask the user
   to choose technical packages.
5. Run `python3 system/management-tool/management-tool setup`.
6. Follow the environment skill for the selected language.
7. Run these exact checks; do not inspect tool source to discover commands:

   ```text
   python3 system/management-tool/management-tool doctor
   python3 system/office-tool/office-tool status
   ```

   For Japanese, also run
   `python3 system/office-tool/office-tool font-check --profile japanese`;
   do not report setup complete unless its rendered PDF uses embedded Noto Sans
   CJK JP Regular and Bold.
8. Explain the orientation below in the selected language.

## Orientation

- Keep General open in VS Code. Start or resume work from the official Claude
  Code session list.
- Ordinary questions need no project. When materials, files, deliverables, or
  later continuation are involved, Claude creates and maintains an internal
  dated project automatically. The user does not select it.
- Attached source files are copied to project `Materials/`; project state stays
  in `MASTER.md`; canonical results stay in `Output/`; replaced versions move
  to `Archives/`; human-ready results are copied to Desktop `OUTBOX/`.
- Desktop `SHAREBOX/` is one flat handoff queue. General can copy selected
  project output there or import one explicitly selected item into project
  `Materials/`; it does not monitor or route the queue.
- The supplied A4 and meeting-minutes workflows share one tested ODT template.
  PDF is created only when requested. Free design remains unrestricted.
- The supplied photo-slide workflow creates editable 16:9 ODP decks from phone
  photos using six one- or two-photo layouts. PDF is created only when requested.
- OCR creates Markdown without changing the original. Its backend is
  replaceable and the actual backend/fallback is reported.
- `MEMORY/` stores reusable preferences and lessons. Project state does not go
  there. The formal improvement process runs when explicitly requested or when
  accumulated evidence makes a full review worthwhile; it is not forced by a
  fixed work count.
- Git records only the main Markdown operating files, reusable Memory, and
  project `MASTER.md`. Materials, Output, Archives, and all other files need
  the user's normal cloud sync or backup even when they are text.
- Optional external plugins are managed through Claude Code's built-in
  `/plugin` interface. No third-party marketplace or plugin is installed by
  default.
- Ask naturally for diagnosis to use Lifesaver. Ask naturally to apply an
  update ZIP; no UPDATE project or manual project command is required.

Finish with the selected-language equivalent of: `Setup is complete. You can
start working now.` Do not report completion while `SETTINGS.md` contains `Not
set`, Git is uninitialized, or either bundled tool fails its required check.
