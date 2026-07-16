# Apply HASUNOMI GLM Gateway Add-on

This file is for the AI that manages the recipient's main environment.

## Objective

Install this add-on into an existing HASUNOMI workspace while preserving the
user's normal VS Code profile, existing projects, memory, outputs, and secrets.

## Procedure

1. Read `README.md`, `SECURITY.md`, and `version.txt`.
2. Confirm the target workspace contains `CLAUDE.md` and `.claude/`.
3. Confirm Python 3.9+ and Visual Studio Code are available.
4. Tell the user which workspace and paths will be changed.
5. Run the installer from the extracted add-on directory:

   ```bash
   ./install.sh --workspace /absolute/path/to/HASUNOMI-workspace
   ```

   The installer merges the official Exa MCP into the workspace `.mcp.json`.
   It preserves existing servers and stops rather than overwriting a conflicting
   server named `exa`.

6. Do not ask for, receive, echo, log, or paste the API keys. Explain that the
   keys are independent and only one text provider is required. Ask the user to
   run the command or commands for the providers they want:

   ```bash
   ~/bin/glm-gateway key zai          # Opus; also image/PDF
   ~/bin/glm-gateway key openrouter   # Sonnet; OpenRouter
   ~/bin/glm-gateway key deepseek     # Haiku; direct DeepSeek
   ```

   Do not imply that all three are required.

7. After the user says at least one key was entered, run:

   ```bash
   ~/bin/glm-gateway status
   ~/bin/glm-gateway doctor --live
   ```

   Report the actual provider shown for Opus, Sonnet, and Haiku. If image or
   PDF support is requested, confirm that the Z.AI key is configured.

8. When suitable user-owned image and PDF test files are available, run the
   optional checks without copying their contents into chat or logs:

   ```bash
   ~/bin/glm-gateway doctor --image /absolute/path/to/image
   ~/bin/glm-gateway doctor --pdf /absolute/path/to/pdf
   ```

9. Report the installed version, workspace, doctor results, and launch command.
10. On first launch, approve the project MCP server named `exa` if Claude Code
    shows its normal trust prompt. No Exa API key is required.

## Boundaries

- Do not modify the user's normal VS Code user settings.
- Do not install a scheduler, daemon, login item, public listener, or proxy
  outside this package.
- Do not put the key in the workspace, Git, Markdown, shell history, logs, or
  AI conversation.
- Do not alter HASUNOMI document, OCR, font, template, project, or memory rules.
- Stop if the target path is not clearly a HASUNOMI workspace.
