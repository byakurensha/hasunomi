---
name: flyer
description: Create an editable Japanese A4 event flyer from the bundled single-page template.
---

# A4フライヤー

イベント、講座、地域活動などの案内には、同封のA4縦1ページODGを使います。
写真、タイトルと開催日時、短い導入文、会場・内容・参加条件、申込み・連絡先を
一枚で整理する、余白を重視した日本語テンプレートです。

```text
python3 system/office-tool/office-tool create-flyer OUTPUT.odg
python3 system/office-tool/office-tool verify OUTPUT.odg \
  --expect-font "Noto Sans CJK JP" --require-bold
```

- 見本文は日本語で、Noto Sans CJK JPを使います。
- 英語で使う場合も内部名やレイアウトは変えず、見本文だけ置き換えます。
- 写真、団体名、日時、会場、本文、申込み方法、連絡先を案件内容に差し替えます。
- 写真の上へ文字や装飾を重ねず、写真自体が読み取れる状態を保ちます。
- 編集可能なODGを標準成果物とし、PDFは明示された場合だけ作成します。
- 完成後はA4一ページをPDF化して目視し、文字切れ、重なり、余白、画像比率、
  各ブロックの上下中央と水平線の間隔を確認します。
