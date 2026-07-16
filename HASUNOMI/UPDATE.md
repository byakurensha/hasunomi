# Update payload

Version 1.2.2 makes the small major-Markdown Git checkpoint automatic. Project
completion records the active project immediately. The next Claude Code
session start quietly records any remaining allowed Markdown edits, renames,
deletions, and new project MASTER files. Materials, Output, Archives, and
imported snapshots remain backup-owned even when they contain Markdown. This
release retains the 1.2.1 Markdown allowlist, 1.2.0 flat verified SHAREBOX, and
1.1.0 management-overhead reductions.

Use a fresh installation when moving from any development build. A 1.0.x
installation can be updated by asking Claude Code to update from the 1.2.2 ZIP;
the bundled management tool replaces product files while preserving uppercase
user state and `.claude/settings.local.json`.

When upgrading a 1.0.x workspace, extract the 1.2.2 ZIP to a temporary folder
and run the management tool from that extracted 1.2.2 payload while the current
working directory is the existing General root:

```text
python3 /temporary/1.2.2/system/management-tool/management-tool update \
  /path/to/HASUNOMI-Claude-Code-VSCode-Easy-Startup-Pack-1.2.2.zip
```

Do not run the old 1.0.x updater for this transition. The 1.2.2 updater keeps
Git commits scoped to updated product files and restores script execution
permissions after ZIP extraction.

Read `version.txt` for release details.
