# Reference Scripts — vanilla-js-github-pages-spa

This directory contains real, working scripts and workflows from the KAP (Kitchen & Pantry) repository as a reference implementation.

> **IMPORTANT**: These files are included as a reference demonstration of the concepts defined in `architecture.md` and `requirements.md`. They are **not** a template to copy verbatim.
>
> When generating scripts for a new or existing project adopting this profile:
> - Do not blindly copy these files or assume repository names, CNAMEs, or directory structures match.
> - Tailor the script parameters, branch names, domain CNAMEs, asset query-string targets, and service worker cache names to the specific project being configured.
> - Note: The manual regex-based cache-busting in `dev-publish.ps1` and `release.ps1` is a legacy approach. Implementations adopting this profile should consider automatic content-hash versioning instead where practical.
> - Ensure all requirements listed in `requirements.md` are guaranteed by the generated implementation.

## Included Reference Files

- `build.ps1` — Validation script verifying that the deployment source directory (`docs/`) exists and is ready for deployment.
- `dev-publish.ps1` — Developer publish script (enforces dev branch, updates asset query strings `?v=<timestamp>` and service worker cache name, commits, and pushes to origin `dev`).
- `release.ps1` — Production release script (enforces `main` branch, updates asset query strings, writes production CNAME, generates release diff in `release/rel-<timestamp>.txt`, builds AI release notes prompt, pauses for human/AI round-trip, commits, tags, and pushes).
- `clean.ps1` — Utility script to clean the `docs/` deployment output directory.
- `RELEASE_NOTES_STYLE.md` — Style guide governing release notes tone, formatting, and section structure.
- `.vscode/launch.json` — Sample VS Code Run & Debug configurations for static SPA scripts.
- `.github/workflows/deploy-dev-pages.yml` — GitHub Actions workflow triggering on `dev` branch push to publish `docs/` to an external dev-lane repository via `peaceiris/actions-gh-pages`.
- `.github/workflows/release.yml` — GitHub Actions workflow triggering on tag push to create a GitHub Release with `RELEASE_NOTES.md` as the body.
- `.github/copilot-instructions.md` — Sample AI direction file anchoring repository rules and pointing to `PM/workflow.md`.
