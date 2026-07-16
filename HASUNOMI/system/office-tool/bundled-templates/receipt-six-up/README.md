# Bundled A4 Six-Up Receipt Template

This template creates one editable ODG drawing containing six simple Japanese
receipts on one A4 landscape sheet.

- Page: exactly 297 x 210 mm.
- Grid: two columns by three rows.
- Receipt: exactly 148.5 x 70 mm.
- Cut positions: x=148.5 mm, y=70 mm, and y=140 mm.
- Safe content inset: 5 mm.
- Printing: 100 percent scale; no fit-to-page.

The template intentionally contains only issue date, recipient, amount,
description, receipt statement, issuer name, and optional issuer address/contact.
It does not contain receipt numbers, tax fields, payment method, invoice
registration number, seal/staff field, or revenue-stamp field.

The `issuer` object applies to all six receipts. `address` and `contact` are
optional and omitted when empty. The `receipts` array accepts up to six entries;
missing entries are generated as handwriting blanks.

```sh
python3 system/office-tool/office-tool create-receipts example.json receipts.odg --profile japanese
python3 system/office-tool/office-tool verify receipts.odg \
  --expect-font "Noto Sans CJK JP" --require-bold
```

ODG is the default editable result. PDF is optional and created only when the
user explicitly requests it.
