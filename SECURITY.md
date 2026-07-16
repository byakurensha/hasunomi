# Security policy

## Supported versions

Security fixes are applied to the latest published HASUNOMI and gateway
release. Older release assets remain immutable for verification and rollback.

## Reporting

Do not include API keys, OAuth tokens, private documents, screenshots of
credentials, or other secrets in a public GitHub issue.

For an ordinary reproducible bug, open a GitHub issue containing only:

- operating system and version;
- HASUNOMI or gateway version;
- the command or workflow that failed;
- a redacted error message;
- minimal reproduction steps.

For a vulnerability that could expose credentials or user files, use the
private contact route on the [BYAKURENSHA website](https://byakurensha.lotusvillage.online/)
instead of a public issue.

## Credential boundary

The public repository and Release assets must never contain credentials. The
gateway stores provider keys locally with restricted permissions and does not
require users to send keys to BYAKURENSHA.
