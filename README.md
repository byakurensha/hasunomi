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

- HASUNOMI: `1.3.0`
- GLM + DeepSeek Gateway Add-on: `2.0.0`

Release ZIP files are attached to GitHub Releases. The repository source does
not contain API keys, credentials, the BYAKURENSHA internal overlay, or private
runtime configuration.

## Update an existing workspace

1. Download the [latest HASUNOMI ZIP](https://github.com/byakurensha/hasunomi/releases/latest/download/HASUNOMI-latest.zip). Do not manually extract its contents over your existing `GENERAL` folder.
2. Open your existing `GENERAL` folder as the VS Code root and start a new Claude Code session.
3. Tell Claude Code where the downloaded ZIP is and use this request:

```text
Use this ZIP to update the GENERAL workspace currently open in VS Code.
```

Claude Code updates only product files and checks `version.txt`, doctor, and
the structural check. `PROJECTS`, `MEMORY`, local settings, source material,
and deliverables are preserved. Run the update while your normal backup or
cloud sync is active for additional protection.

## Improve and repair

When something feels wrong, describe the problem and desired result, then ask
Claude Code to run the Improvement Process. It reviews evidence before changing
the working method.

If repeated improvements create duplicated guidance, contradictions, retired
routes, or growing always-loaded files, ask for the Repair Process. Repair
reconciles ownership across the role, rules, Skills, manuals, and
implementation. It is not another automatic task and runs only when needed.

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
