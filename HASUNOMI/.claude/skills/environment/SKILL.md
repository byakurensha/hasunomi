---
name: environment
description: Check or prepare dependencies used by the bundled document and OCR workflows. Use during setup or when those capabilities are unavailable.
---

# Environment

Announce checks and installations before making changes. Stop only for
administrator authentication, payment, external login, secrets, or difficult
to reverse work.

- Common: Python 3, Git, VS Code, official Claude Code extension, LibreOffice,
  `odfpy`, Pillow, Tesseract, `pdftotext`, `pdfinfo`, and `pdftoppm`.
- Japanese: static Noto Sans CJK JP faces suitable for LibreOffice and
  Tesseract `jpn+eng`. Run
  `python3 system/office-tool/office-tool font-check --profile japanese`.
  Success requires LibreOffice to render and embed both Noto Sans CJK JP
  Regular and Bold; OS registration or fallback rendering is not proof.
- English: Tesseract `eng`; do not require Noto Sans CJK JP.
- Other languages: use available support and explain the specific missing OCR
  data. Do not install a large all-language collection silently.

Verify resulting capabilities, not only package-manager success. If the font
check fails after installation, restart LibreOffice and rerun it before
reporting setup complete.
