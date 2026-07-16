# HASUNOMI GLM + DeepSeek Gateway Add-on

HASUNOMIのVS Code環境を、Z.AIのGLMで動かすための任意追加パックです。
通常利用しているVS Codeの設定や拡張機能とは別の専用領域を使うため、
メイン環境を変更しません。

公式ホスト型Exa MCPも同時に登録し、追加のExa APIキーなしでWeb検索を
利用できるようにします。初回起動時にClaude Codeから信頼確認が表示された
場合だけ、`exa`を承認してください。既存MCPは保持し、同名設定を上書きしません。

## 標準の役割分担

- Opus枠: Z.AI直結 `GLM-5.2`
- Sonnet枠: OpenRouter経由 `deepseek/deepseek-v4-pro`
- Haiku枠: DeepSeek直結 `deepseek-v4-pro`
- 写真、スクリーンショット、PDFの確認: `GLM-4.6V`
- 操作画面: VS Code公式Claude Code拡張
- 接続: 自分のPC内だけで待ち受けるAnthropic互換ゲートウェイ

3種類のキーを全部入れる必要はありません。設定されていない枠は、利用可能な
別のプロバイダへ自動的に退避します。1種類のキーだけでも3つのテキスト枠を
利用できます。`glm-gateway status`で、各枠が実際にどのプロバイダとモデルを
使うか確認できます。画像・PDFを扱う場合だけZ.AIキーが必要です。

## APIキー

APIキーをAIとの会話へ貼り付けないでください。導入ファイルの配置が
終わった後、利用者自身がローカルのターミナルで次を実行します。

```bash
~/bin/glm-gateway key zai          # Opus枠、画像・PDFにも必要
~/bin/glm-gateway key openrouter   # Sonnet枠、OpenRouter経由
~/bin/glm-gateway key deepseek     # Haiku枠、DeepSeek直結
```

使いたいものだけ入力してください。入力中の文字は表示されません。各キーは
`~/.config/glm-gateway/`内の別ファイルに権限`600`で保存されます。

## 確認と起動

```bash
~/bin/glm-gateway status
~/bin/glm-gateway doctor --live
~/bin/glm-gateway launch
```

画像やPDFも確認する場合:

```bash
~/bin/glm-gateway doctor --image /path/to/photo.jpg
~/bin/glm-gateway doctor --pdf /path/to/document.pdf
```

アンインストールは`~/bin/glm-gateway uninstall`です。APIキーを残す場合
だけ`--keep-key`を付けます。
