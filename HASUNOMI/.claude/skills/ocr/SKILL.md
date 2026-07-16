---
name: ocr
description: Extract text from images or PDFs into Markdown without modifying the source. Use the configured backend and report fallback.
---

# OCR

- Ensure project-work is active and copy the source into `Materials/`.
- Never modify the original. Produce extracted Markdown only.
- Use the backend selected in `SETTINGS.md`; it may be replaced later.
- The public initial adapter is Tesseract with optional adapter-specific image
  preprocessing. Japanese uses `jpn+eng`; English uses `eng`.
- A private installation may provide another primary backend and use the public
  adapter as technical fallback.
- Report the actual engine, preprocessing, page count, and fallback. Mark
  unreadable text `[unclear]`; never guess.
- Keep OCR body text out of logs, Git, and Memory.
