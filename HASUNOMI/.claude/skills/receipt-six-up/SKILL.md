---
name: receipt-six-up
description: Create an exact A4 six-up Japanese receipt sheet as editable ODG. Use when the user wants six equal receipts on one A4 sheet for folding or cutting.
---

# A4 Six-Up Receipt

Follow the template choice gate in the core rules before creating files. Use
the bundled receipt renderer only after the user selects this supplied
template; an exact six-up requirement does not itself count as that choice.

## Fixed geometry

- Output is editable ODG, not a flowing ODT table.
- Page is A4 landscape: exactly `297 x 210 mm`.
- Layout is two columns by three rows.
- Every receipt is exactly `148.5 x 70 mm`.
- Cut lines are fixed at `x=148.5 mm`, `y=70 mm`, and `y=140 mm`.
- Keep all receipt content at least 5 mm inside each cut edge.
- Print at 100 percent. Never use fit-to-page or automatic scaling.

## Content boundary

The supplied simple template contains only:

- issue date
- recipient
- amount received
- description
- `上記正に領収いたしました。`
- issuer name
- optional issuer address and contact details

Do not add a receipt number, tax breakdown, payment method, invoice registration
number, seal/staff box, or revenue-stamp box unless the user explicitly asks for
a different template.

## Create and verify

Prepare a JSON specification using
`system/office-tool/bundled-templates/receipt-six-up/example.json`. The `issuer`
is shared by all six receipts. `receipts` may contain zero to six entries; any
missing entries remain blank for handwriting.

```text
python3 system/office-tool/office-tool create-receipts SPEC.json OUTPUT.odg --profile japanese
python3 system/office-tool/office-tool verify OUTPUT.odg \
  --expect-font "Noto Sans CJK JP" --require-bold
```

ODG is the canonical editable result. Create PDF only when explicitly requested.
If a print check is requested, verify A4 landscape page size and instruct the
user to print at 100 percent.
