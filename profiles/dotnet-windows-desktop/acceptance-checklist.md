# dotnet-windows-desktop — Acceptance Checklist

Walk through this checklist after generating or refactoring a project implementation to verify that all requirements from `requirements.md` are met.

> **Note**: This checklist is pure prose for human and AI review. Do not embed runnable test commands inside this file.

## 1. Version Source of Truth
- [ ] Confirm exactly one `.csproj` file contains the canonical `<Version>` tag.
- [ ] Verify that all build and publish scripts resolve their version from this single project file.
- [ ] Verify that production release versions use `Major.Minor.Patch.0` (or `Major.Minor.Patch` without a non-zero fourth node).
- [ ] Verify that developer versions use a non-zero fourth node (e.g., `Major.Minor.Patch.Timestamp`).

## 2. Release Lanes & Branch Gating
- [ ] Verify `Publish-live` is blocked when run on any branch other than `main` (or runs strictly in dry-run/test mode).
- [ ] Verify `Publish-dev` is blocked when run on any branch other than `dev`.
- [ ] Confirm both scripts verify a clean working tree before performing irreversible operations.

## 3. Release Notes & AI Gate
- [ ] Verify `Publish-live` clears and requires release notes confirmation before tagging and pushing.
- [ ] Verify `Publish-dev` skips the release notes requirement.
- [ ] Verify release notes generation uses the generated diff as its source evidence.

## 4. Installer & Branding
- [ ] If an installer is generated, verify it uses custom application logo assets for the setup executable icon, wizard artwork, and shortcuts.
- [ ] Verify the published desktop executable carries the custom application icon for Windows taskbar display.

## 5. Update Manifest & Checksums
- [ ] Verify build scripts produce `.sha256` checksum files alongside published zip/exe packages.
- [ ] Verify update check logic handles unreachable or missing manifests gracefully without blocking application startup.

## 6. VS Code & CI Integration
- [ ] Verify `.vscode/launch.json` contains tasks mapping to local execution and publish scripts (`Build`, `Publish-dev`, `Publish-live`).
- [ ] On existing projects, confirm `.vscode/launch.json` merged new tasks without clobbering existing custom debug configurations.
- [ ] Verify `.github/workflows/` contains release packaging and dev publish workflows.

## 7. Project Management Integration
- [ ] Verify `PM/` structure exists with `project-management.md`, `workflow.md`, and all lifecycle folders.
- [ ] Confirm `project-management.md` acts as an index without duplicating status prose.
- [ ] Confirm `AGENTS.md` contains a pointer sentence to `PM/workflow.md`.

## 8. Breadcrumb Header
- [ ] Verify every generated script and workflow file contains the origin breadcrumb comment header defined in `shared/breadcrumb-spec.md`.
