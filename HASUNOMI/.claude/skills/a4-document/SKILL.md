---
name: a4-document
description: Create an A4 document. Use the bundled ODT template when selected, or a free design when that better fits the request.
---

# A4 Document

Follow the template choice gate in the core rules before creating files. Use
the path selected by the user for this deliverable.

## Standard template

- Ensure project-work is active.
- Create structured JSON containing only title, headings, paragraphs, lists,
  and tables. Run `system/office-tool/office-tool create-odt`; use `--profile
  japanese` only for Japanese.
- Set heading `level` to `1`, `2`, or `3` so the document preserves section,
  subsection, and item hierarchy. A missing level remains accepted as level 2
  for backward compatibility.
- The renderer owns A4 margins, typography, title rule, visible table borders,
  cell padding, and content-aware table column widths. A4 does not mean one
  page.
- Produce one editable ODT by default. Create PDF only when explicitly asked.
- Verify before saving to project `Output/`. When human pickup is requested,
  deliver through Desktop `OUTBOX/`.

## Free design

Choose the method that fits the request. Do not impose the bundled layout,
Noto Sans, ODT, LibreOffice, one-page output, or one visual-check policy.
