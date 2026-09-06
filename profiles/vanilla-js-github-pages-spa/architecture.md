# vanilla-js-github-pages-spa — Architecture

Informed by KAP (Kitchen & Pantry): a static Vanilla JavaScript Single Page Application hosted on GitHub Pages with PWA capabilities and a dual-repo two-lane deployment model.

## Components

- **Static App Source (`docs/`)**: Static web assets (`index.html`, `styles.css`, `main.js`, modular JS features/ui components, data files, assets) stored in a deployment source directory served directly by GitHub Pages.
- **PWA Capabilities**: Web App Manifest (`manifest.webmanifest`) and Service Worker (`service-worker.js`) providing offline capability and client-side cache management.
- **Environment Banner (`dev-site-banner.js`)**: Optional client-side script that detects non-production hostnames and displays a prominent visual banner (e.g. "DEVELOPER PREVIEW").

## Process & Version Model

- **Version Identity**: Bare UTC timestamp format (`yyyy-MM-dd-HH-mm`) used as the version stamp, cache-busting parameter (`?v=2026-09-06-12-00`), service worker cache name (`var CACHE_NAME = 'app-v2026-09-06-12-00';`), release diff filename (`release/rel-2026-09-06-12-00.txt`), and annotated Git tag name.
- **No Build Step Requirement**: Pure Vanilla JS requires no compilation step, though a `build.ps1` script validates that the deployment source directory (`docs/`) is intact.

## Dual-Repo / Dual-Lane Deployment Model

To ensure strict environment separation and prevent pre-production code or dev CNAMEs from leaking into production:

- **Production Lane (`main` branch)**:
  - Source repo `main` branch serves the live production site directly via native GitHub Pages branch/folder configuration.
  - Production CNAME (e.g. `kap.ignyos.com`) stored in `docs/CNAME` on `main`.
  - On release tag push, GitHub Actions workflow (`release.yml`) creates a GitHub Release with `RELEASE_NOTES.md` as the body.
- **Dev Lane (`dev` branch + external dev repo)**:
  - Developer pushes changes to `dev` branch using `dev-publish.ps1`.
  - GitHub Actions workflow (`deploy-dev-pages.yml`) runs on push to `dev`.
  - Workflow overrides `docs/CNAME` with the dev subdomain (e.g. `kap-dev.ignyos.com`).
  - Workflow uses a GitHub Personal Access Token (PAT) to force-push `./docs` output to the root of a separate external dev repository (e.g. `KAP-dev`).

## Interactive Release Notes Workflow

Production releases run interactively via `release.ps1` on `main`:
1. Generates a release diff against the previous git tag and saves it to `release/rel-<timestamp>.txt`.
2. Emits / copies an AI prompt referencing the diff, `RELEASE_NOTES_STYLE.md`, and target `RELEASE_NOTES.md`.
3. Pauses for human/AI interactive update of `RELEASE_NOTES.md`.
4. Commits `RELEASE_NOTES.md` and the diff file, creates annotated tag `<timestamp>`, and pushes branch + tag to origin.
