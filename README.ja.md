# HASUNOMI

[English](README.md)

HASUNOMIは、Visual Studio Codeの公式Claude Code拡張を、整理された作業環境ですぐに使い始めるための小さなスターターパックです。Claude Code自体を置き換えず、セッション、資料、編集可能なOffice文書、案件記録、再利用Memory、受け渡しフォルダを扱いやすくします。

## ダウンロード

- [HASUNOMI最新版をZIPでダウンロード](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-latest.zip)
- [任意のGLM + DeepSeek GatewayをZIPでダウンロード](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-GLM-Gateway-Add-on-latest.zip)
- [初心者向け導入手順](https://byakurensha.lotusvillage.online/hasunomi/)

現在のソースバージョン：

- HASUNOMI：`1.2.2`
- GLM + DeepSeek Gateway Add-on：`2.0.0`

利用者向けZIPはGitHub Releasesへ添付します。このリポジトリにはAPIキー、資格情報、白蓮社内部版、内部ランタイム設定を含めません。

## 最新版へ更新する

1. [HASUNOMI最新版ZIP](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-latest.zip)をダウンロードします。ZIPの中身を既存の`GENERAL`へ手作業で上書きしないでください。
2. 今使っている`GENERAL`をVS Codeのルートとして開き、Claude Codeで新しいセッションを開きます。
3. ダウンロードしたZIPの保存場所を伝え、次のように依頼します。

```text
このZIPをHASUNOMIの更新として適用して。既存の案件、Memory、設定を保持し、更新後にversion.txtとdoctorを確認して。
```

Claude Codeが製品ファイルだけを更新します。`PROJECTS`、`MEMORY`、ローカル設定、素材、成果物は保持されます。普段のバックアップまたはクラウド同期が有効な状態で実行すると、さらに安全です。

## 構成

```text
HASUNOMI/                         公開スターターパックのソース
add-ons/glm-deepseek-gateway/    任意の公開Gatewayソース
scripts/validate.sh              公開境界の検証
```

## セキュリティ

APIキーは利用者自身の端末だけで入力します。Issue、ソース、AIとの会話へ貼り付けないでください。詳しくは[SECURITY.md](SECURITY.md)を確認してください。

## ライセンス

MITライセンスです。[LICENSE](LICENSE)を参照してください。
