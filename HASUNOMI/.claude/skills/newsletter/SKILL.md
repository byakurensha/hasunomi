---
name: newsletter
description: Create an editable Japanese A4 newsletter from the bundled eight-page community newsletter template.
---

# 会報

制作前にcore rulesのtemplate choice gateに従って確認します。利用者が
同封テンプレートを選んだ場合だけ、A4縦8ページODGを使います。
表紙、挨拶、特集、活動報告、写真、寄稿、事業報告、Q&A・お知らせ、巻末の
読み物を収録しています。案件に不要なページは削除できます。自由制作が
選ばれた場合はこの生成コマンドを使いません。

```text
python3 system/office-tool/office-tool create-newsletter OUTPUT.odg
python3 system/office-tool/office-tool verify OUTPUT.odg \
  --expect-font "Noto Sans CJK JP" --require-bold
```

- 見本文は日本語で、Noto Sans CJK JPを使います。
- 英語で使う場合も、内部名やレイアウトは変えず、見本文だけ置き換えます。
- 見本写真、顔写真枠、団体名、号数、発行情報、本文を案件内容に差し替えます。
- 長文は読み順が分断されないよう、本文欄を細かく分けすぎません。
- 写真の出典と利用条件を確認し、必要なクレジットを残します。
- 編集可能なODGを標準成果物とし、PDFは明示された場合だけ作成します。
- 完成後は全ページをPDF化して目視し、文字切れ、重なり、余白、画像比率、
  フッター位置を確認します。
