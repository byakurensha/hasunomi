# HASUNOMI GLM + DeepSeek Gateway Add-on

This optional add-on gives a HASUNOMI workspace a lower-cost Claude Code
runtime and current web search without changing the user's normal VS Code
profile.

## Preferred model slots

- Opus: direct Z.AI `GLM-5.2`
- Sonnet: OpenRouter `deepseek/deepseek-v4-pro`
- Haiku: direct DeepSeek `deepseek-v4-pro`
- Images, screenshots, and PDF inspection: `GLM-4.6V`
- Client: official Claude Code extension for VS Code
- Transport: one Anthropic-compatible endpoint bound to localhost
- Web search: official hosted Exa MCP at `https://mcp.exa.ai/mcp`

The three text keys are optional and independent. If a preferred provider has
no key, that slot falls back to another configured provider. One configured
text provider is enough to run all three Claude Code slots. Run
`glm-gateway status` to see the actual provider and model selected for each
slot. Image and PDF analysis specifically requires the Z.AI key.

## Requirements

- macOS or Linux
- Python 3.9 or newer
- Visual Studio Code
- A HASUNOMI workspace containing `CLAUDE.md` and `.claude/`
- At least one of: Z.AI, OpenRouter, or DeepSeek API key

Visual requests use the general Z.AI API. A Coding Plan alone may not include
the visual route.

## Install

Give this ZIP and `APPLY.md` to the AI that manages your main environment. It
can install every non-secret component. When it reaches the key step, enter the
key yourself in a local terminal:

```bash
~/bin/glm-gateway key zai          # Opus; also image/PDF
~/bin/glm-gateway key openrouter   # Sonnet; OpenRouter
~/bin/glm-gateway key deepseek     # Haiku; direct DeepSeek
```

Enter only the providers you want. Keys are hidden while typing and stored in
separate files under `~/.config/glm-gateway/` with mode `600`.

After installation:

```bash
~/bin/glm-gateway doctor --live
~/bin/glm-gateway launch
```

The installer safely merges Exa into the workspace `.mcp.json`. It does not
need an Exa API key. On first launch, approve the project MCP server if Claude
Code requests trust. Existing MCP servers are preserved, and a conflicting
server already named `exa` is never overwritten.

## Commands

```text
glm-gateway key PROVIDER        Store one of: zai, openrouter, deepseek
glm-gateway key all             Store all three keys
glm-gateway status              Show local runtime state
glm-gateway doctor              Verify installation without an API request
glm-gateway doctor --live       Verify a real GLM-5.2 response
glm-gateway doctor --image FILE Verify image routing too
glm-gateway doctor --pdf FILE   Verify PDF routing too
glm-gateway launch              Open the isolated VS Code environment
glm-gateway stop                Stop the local gateway
glm-gateway uninstall           Remove runtime, isolated VS Code, and key
```

## Files

```text
~/.local/share/glm-gateway/   runtime, logs, isolated VS Code data
~/.config/glm-gateway/       configuration and protected API keys
~/bin/glm-gateway            single command entry
```

No scheduler, background login item, public listener, account proxy, or remote
management service is installed.
