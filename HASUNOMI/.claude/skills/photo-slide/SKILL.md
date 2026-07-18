---
name: photo-slide
description: Create a quick editable ODP photo deck from project photos using the bundled six-layout photo template. Use when the user asks for a photo slide, photo deck, or a simple slideshow of imported phone photos.
---

# Photo Slide

Follow the template choice gate in the core rules before creating files. Use
this workflow only after the user selects the supplied photo template. Free
presentation design remains unrestricted.

## Default contract

- Read photos from the linked project's `Materials/` and preserve the sources.
- Create one editable 16:9 ODP in project `Output/` by default.
- Create PDF only when explicitly requested.
- Do not create a cover slide unless requested.
- Keep photos uncropped by default. Normalize smartphone orientation in the
  embedded copy without changing the source.
- Omit only obvious duplicates unless the user gives a narrower selection.
- Use the photo order requested by the user; otherwise use a stable filename or
  folder order and report that choice.

## Six layouts

Choose from the photo count and the normalized orientation. An explicit user
layout overrides automatic selection only when it matches the supplied photos.

1. landscape + landscape
2. portrait + landscape
3. landscape + portrait
4. one landscape
5. portrait + portrait
6. one portrait

Each slide has a title at upper left, a thin full-content-width rule below the
header, and a two-digit page number at upper right. Keep the photos as large as
possible inside the remaining area.

## Build

Create a JSON specification based on the example in
`system/office-tool/bundled-templates/photo-slide/example.json`. Paths may be
absolute or relative to the JSON file.

```sh
python3 system/office-tool/office-tool create-odp SPEC.json OUTPUT.odp --profile japanese
python3 system/office-tool/office-tool verify OUTPUT.odp \
  --expect-font "Noto Sans CJK JP" --require-bold
```

Use `--profile japanese` only for Japanese output. Other languages use the
default available sans-serif. This font choice belongs to the supplied photo
template and does not constrain other templates or free designs.

## Review

- Render the ODP through LibreOffice once after generation.
- For Japanese output, confirm that the rendered PDF actually embeds Noto Sans
  CJK JP Regular and Bold. A style declaration or fallback is not sufficient.
- Inspect a contact sheet for every slide.
- Check orientation, cropping, overlap, title and rule alignment, page number,
  and excessively small photos.
- During a correction, regenerate and inspect the affected slide first when
  practical; run one final whole-deck verification before delivery.
- If a source has stale or contradictory orientation metadata, inspect the
  pixels and create a corrected working copy rather than changing the source.
