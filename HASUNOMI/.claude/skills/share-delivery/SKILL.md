---
name: share-delivery
description: Send a project Output file through Desktop SHAREBOX or receive a selected SHAREBOX item into the linked project's Materials. Use for cross-environment or cross-session handoff.
---

# SHAREBOX Handoff

Desktop `SHAREBOX/` is one flat, temporary handoff queue. It has no directional
subfolders, router, watcher, scheduler, or automatic consumer.

## Send

1. Require a linked durable project and a direct file inside its `Output/`.
2. Run the fixed management command:

   ```text
   python3 system/management-tool/management-tool project share \
     --session SESSION_ID --file FILE_NAME
   ```

3. The command creates Desktop `SHAREBOX/` when needed, refuses same-name
   collisions, copies through a temporary file, verifies byte size and SHA-256,
   atomically publishes the copy, and records the handoff in `MASTER.md`.
4. Report the copied file path. If the command fails, keep the project source
   and any existing destination unchanged.

## Receive

1. Require a linked durable project. If the requested item is ambiguous, list
   the visible items in Desktop `SHAREBOX/` and ask which one to receive.
2. Run:

   ```text
   python3 system/management-tool/management-tool project receive \
     --session SESSION_ID --item ITEM_NAME
   ```

3. The command refuses same-name collisions, copies the selected file or folder
   into project `Materials/`, verifies type, file count, byte size, and SHA-256,
   and removes the queue source only after success.
4. Read or use the imported item only after success. Failure, interruption, or
   collision leaves the SHAREBOX source unchanged.

When sender, recipient, purpose, or next action matters, put those facts in an
accompanying Markdown handoff. This skill does not encode them in directory
names and does not use an organization-specific route.
