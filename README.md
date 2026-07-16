# HASUNOMI

[日本語](README.ja.md)

HASUNOMI is a small starter workspace for the official Claude Code extension
in Visual Studio Code. It organizes sessions, source material, editable office
documents, project records, reusable memory, and explicit handoff folders
without replacing Claude Code itself.

## Downloads

- [Download the latest HASUNOMI ZIP](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-latest.zip)
- [Download the optional GLM + DeepSeek Gateway ZIP](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-GLM-Gateway-Add-on-latest.zip)
- [Beginner setup guide](https://byakurensha.lotusvillage.online/hasunomi/)

Current source versions:

- HASUNOMI: `1.2.2`
- GLM + DeepSeek Gateway Add-on: `2.0.0`

Release ZIP files are attached to GitHub Releases. The repository source does
not contain API keys, credentials, the BYAKURENSHA internal overlay, or private
runtime configuration.

## Update an existing workspace

1. Download the [latest HASUNOMI ZIP](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-latest.zip). Do not manually extract its contents over your existing `GENERAL` folder.
2. Open your existing `GENERAL` folder as the VS Code root and start a new Claude Code session.
3. Tell Claude Code where the downloaded ZIP is and use this request:

```text
Apply this ZIP as a HASUNOMI update. Preserve my existing projects, Memory, and settings, then verify version.txt and doctor after the update.
```

Claude Code updates only product files. `PROJECTS`, `MEMORY`, local settings,
source material, and deliverables are preserved. Run the update while your
normal backup or cloud sync is active for additional protection.

## Repository layout

```text
HASUNOMI/                         public starter workspace source
add-ons/glm-deepseek-gateway/    optional public gateway source
scripts/validate.sh              public-boundary validation
```

## Security

API keys are entered only on the user's local machine. Do not paste keys into
issues, discussions, source files, or AI conversations. See [SECURITY.md](SECURITY.md).

## License

MIT. See [LICENSE](LICENSE).
