---
name: simple-slide
description: Create an editable Japanese 16:9 presentation from the bundled eleven-layout simple slide template.
---

# シンプルスライド

制作前にcore rulesのtemplate choice gateに従って確認します。利用者が
同封テンプレートを選んだ場合だけ、11レイアウトを持つODPを使います。
表紙、メッセージ、本文、目次、2列、写真、数値、比較表、進捗、まとめから、
必要なページだけ残してください。自由制作が選ばれた場合はこの生成コマンドを
使いません。

```text
python3 system/office-tool/office-tool create-simple-slides OUTPUT.odp
python3 system/office-tool/office-tool verify OUTPUT.odp \
  --expect-font "Noto Sans CJK JP" --require-bold
```

- 見本文は日本語で、Noto Sans CJK JPを使います。
- 英語で使う場合も、内部名やレイアウトは変えず、見本文だけ置き換えます。
- 団体名、タイトル、本文、写真枠を案件内容に差し替えます。
- 不要な見本ページは削除し、ページ番号は最終構成に合わせます。
- 編集可能なODPを標準成果物とし、PDFは明示された場合だけ作成します。
- 完成後は全ページをPDF化して目視し、文字切れ、重なり、中央揃え、線と
  文字の位置、画像の比率を確認します。
