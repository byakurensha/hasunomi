# Security boundary

- The gateway binds to `127.0.0.1` only.
- Provider API keys are optional, stored separately outside the workspace, and
  protected with file mode `600`.
- Request bodies, file contents, prompts, responses, and key values are not
  written to gateway logs.
- Logs contain startup state, request completion metadata, and bounded errors.
- The add-on uses a separate VS Code user-data directory and extension
  directory. It does not edit the normal VS Code profile.
- The installer creates no scheduler, service, login item, or public ingress.
- `uninstall` removes all configured keys by default. Use `--keep-key` only
  when the user explicitly wants to preserve them for a reinstall.
