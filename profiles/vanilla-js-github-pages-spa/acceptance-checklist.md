# vanilla-js-github-pages-spa — Acceptance Checklist

Walk through this checklist after generating or refactoring a project implementation to verify that all requirements from `requirements.md` are met.

> **Note**: This checklist is pure prose for human and AI review. Do not embed runnable test commands inside this file.

## 1. Version Identity & Cache Invalidation
- [ ] Verify UTC timestamp format (`yyyy-MM-dd-HH-mm`) is generated consistently across script runs.
- [ ] Verify `dev-publish.ps1` and `release.ps1` update asset query strings (`?v=<timestamp>`) in `index.html`.
- [ ] Verify `docs/service-worker.js` cache name (`CACHE_NAME`) is updated with the version stamp.

## 2. Dual-Lane Isolation & CNAME Safety
- [ ] Verify production `docs/CNAME` contains the live production domain.
- [ ] Verify `deploy-dev-pages.yml` sets the dev subdomain CNAME in the dev deployment output.
- [ ] Verify dev and production CNAMEs point to distinct subdomains.

## 3. Branch Gating & Release Safeguards
- [ ] Verify `dev-publish.ps1` is blocked when run on any branch other than `dev`.
- [ ] Verify `release.ps1` is blocked from committing, tagging, or pushing when run on any branch other than `main` (runs test mode only).
- [ ] Verify `release.ps1` checks for a clean working tree before initiating a release.

## 4. Diff Auditing & Release Notes
- [ ] Verify `release.ps1` generates a diff file in `release/rel-<timestamp>.txt`.
- [ ] Verify `release.ps1` requires AI/human release notes creation and user confirmation before tagging.
- [ ] Verify `release.yml` GitHub Actions workflow attaches `RELEASE_NOTES.md` to the GitHub Release on tag push.

## 5. Developer Preview Banner
- [ ] Verify `docs/dev-site-banner.js` is included in `docs/index.html`.
- [ ] Verify banner renders on dev domain and does not render on localhost or production domain.

## 6. VS Code Integration
- [ ] Verify `.vscode/launch.json` contains tasks mapping to local execution and publish scripts (`Build`, `Publish-dev`, `Publish-live`).
- [ ] On existing projects, confirm `.vscode/launch.json` merged new tasks without clobbering existing custom debug configurations.

## 7. Project Management Integration
- [ ] Verify `PM/` structure exists with `project-management.md`, `workflow.md`, and all lifecycle folders.
- [ ] Confirm `project-management.md` acts as an index without duplicating status prose.
- [ ] Confirm `AGENTS.md` contains a pointer sentence to `PM/workflow.md`.

## 8. Breadcrumb Header
- [ ] Verify every generated script, workflow, and markdown file contains the origin breadcrumb comment header defined in `shared/breadcrumb-spec.md`.
