# Update payload

Version 1.4.0 adds one editable A4 six-up Japanese receipt template. The ODG
page is exactly 297 x 210 mm and contains six fixed 148.5 x 70 mm receipts. It
uses only the requested simple receipt fields and supports optional issuer
address/contact. Print at 100 percent without fit-to-page.

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

When upgrading a 1.0.x workspace manually, extract the 1.4.0 ZIP to a temporary
folder and run the new updater from the extracted payload while the current
working directory is the existing General root:

```text
python3 /temporary/1.4.0/system/management-tool/management-tool update \
  /path/to/HASUNOMI-Claude-Code-VSCode-Easy-Startup-Pack-1.4.0.zip
```

Do not run the old 1.0.x updater for this transition. Read `version.txt` for
release details.
