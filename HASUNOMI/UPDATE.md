# Update payload

Version 1.6.0 adds an editable Japanese one-page A4 Flyer ODG. It includes a
photo, title and date, lead, three fact columns, application/contact block,
and footer. The photo stays unobstructed by text or decoration. Internal slugs,
JSON fields, and command names remain English. The Japanese template uses
Noto Sans CJK JP and continues to accept English text.

This release retains Repair, automatic major-Markdown checkpoints, the strict
Git allowlist, flat verified SHAREBOX, Desktop OUTBOX, session-linked projects,
Memory, document and OCR workflows, and user-owned Materials and Output.

To update an existing workspace, give this ZIP to Claude Code while the current
VS Code root is that existing `GENERAL` folder and say:

```text
Use this ZIP to update the GENERAL workspace currently open in VS Code.
```

The bundled updater preserves `PROJECTS`, `MEMORY`, uppercase user state,
settings, materials, and outputs. After updating, verify:

```text
cat version.txt
python3 system/management-tool/management-tool doctor
python3 system/management-tool/management-tool repair-check
```

When upgrading a 1.0.x workspace manually, extract the 1.6.0 ZIP to a temporary
folder and run the new updater from the extracted payload while the current
working directory is the existing General root:

```text
python3 /temporary/1.6.0/system/management-tool/management-tool update \
  /path/to/HASUNOMI-Claude-Code-VSCode-Easy-Startup-Pack-1.6.0.zip
```

Do not run the old 1.0.x updater for this transition. Read `version.txt` for
release details.
