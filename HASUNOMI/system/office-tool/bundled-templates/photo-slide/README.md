# Bundled Photo Slide Template

This updateable template creates an editable 16:9 ODP for quickly sharing
photos. It is intentionally simple: title, thin horizontal rule, page number,
and one or two uncropped photos.

Supported layouts:

1. `landscape-landscape`
2. `portrait-landscape`
3. `landscape-portrait`
4. `landscape-single`
5. `portrait-portrait`
6. `portrait-single`

The layout is inferred from the normalized orientation. The optional `layout`
field is a validation assertion, not a way to force mismatched photos into a
shape. Source photos are never modified. JPEG, PNG, and other formats readable
by Pillow are supported; HEIC can be converted when the platform provides
ImageMagick or macOS `sips` support.

```sh
python3 system/office-tool/office-tool create-odp spec.json result.odp --profile japanese
python3 system/office-tool/office-tool verify result.odp \
  --expect-font "Noto Sans CJK JP" --require-bold
```

ODP is the default editable result. PDF conversion is optional and only done
when requested.

For Japanese output, the title uses Noto Sans CJK JP Bold and the page number
uses Noto Sans CJK JP Regular. Verification checks the actual LibreOffice PDF
embedding rather than trusting the ODP style declaration.
