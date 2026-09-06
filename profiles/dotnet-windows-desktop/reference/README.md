# Reference Scripts — dotnet-windows-desktop

This directory contains real, working scripts from the LAN Portal repository as a reference implementation.

> **IMPORTANT**: These files are included as a reference demonstration of the concepts defined in `architecture.md` and `requirements.md`. They are **not** a template to copy verbatim.
>
> When generating scripts for a new or existing project adopting this profile:
> - Do not blindly copy these files or assume file paths, project names, or repository structures match.
> - Tailor the script parameter defaults, path resolution logic, build commands, and publish artifacts to the specific project being configured.
> - Ensure all requirements listed in `requirements.md` are guaranteed by the generated implementation.

## Included Reference Files

- `publish-live.ps1` — Production release publishing script (branch gating, version validation, diff generation, release notes prompt/confirmation, tagging, and pushing).
- `publish-dev.ps1` — Developer publish script (fast dev-branch publishing, non-zero fourth version node suggestion, optional release notes).
- `release-common.ps1` — Common helper functions (git command wrapper, semver parsing, path resolution, changed paths calculation).
- `validate-publish-parity.ps1` — Parity and safeguard validation script (verifies gates, functions, and contract invariants).
- `build-dev-installer.ps1` — Developer installer build script (packages published Host/API/Web outputs, generates Inno Setup installer and SHA256 checksums).
- `.vscode/launch.json` — Sample VS Code Run & Debug configurations mapping to local execution and publish scripts.
- `.github/workflows/` — Sample GitHub Actions workflows for dev publish and release artifact packaging.
- `.github/copilot-instructions.md` — Sample AI direction file anchoring repository rules and pointing to `PM/workflow.md`.
