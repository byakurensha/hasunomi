# HASUNOMI

[English](README.md)

HASUNOMIは、Visual Studio Codeの公式Claude Code拡張を、整理された作業環境ですぐに使い始めるための小さなスターターパックです。Claude Code自体を置き換えず、セッション、資料、編集可能なOffice文書、案件記録、再利用Memory、受け渡しフォルダを扱いやすくします。

## ダウンロード

- [HASUNOMI最新版をZIPでダウンロード](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-latest.zip)
- [任意のGLM + DeepSeek GatewayをZIPでダウンロード](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-GLM-Gateway-Add-on-latest.zip)
- [初心者向け導入手順](https://byakurensha.lotusvillage.online/hasunomi/)

現在のソースバージョン：

- HASUNOMI：`1.2.1`
- GLM + DeepSeek Gateway Add-on：`2.0.0`

利用者向けZIPはGitHub Releasesへ添付します。このリポジトリにはAPIキー、資格情報、白蓮社内部版、内部ランタイム設定を含めません。

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
