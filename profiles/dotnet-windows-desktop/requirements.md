# dotnet-windows-desktop — Requirements

A correct implementation of this profile must guarantee:

1. **Single version source of truth.** Every published component (backend, frontend, host,
   installer, release metadata) reports the same version, resolved from one checked-in project file,
   not independently maintained per project.
2. **Dev vs. production is distinguishable from the version itself**, without consulting external
   state, per the fourth-node convention in `architecture.md`.
3. **The host must not silently continue if a required child process fails to start.** The user gets
   a clear failure message, not a blank window.
4. **The installer must carry the application's real branding** (icon, wizard artwork, shortcut
   icon). This must be verified explicitly after any icon/logo change — do not assume it is correct
   just because a project's `ApplicationIcon` was updated, since the actual running/installed exe may
   have been launched via a path that bypasses it.
5. **Update checks are non-blocking and fail safe.** A failed or unreachable manifest fetch must not
   prevent the application from starting or operating normally.
6. **Release notes are required before a production release, not before a dev deploy.** Dev deploys
   are rehearsals and must not carry the same gate as a production release.
7. **Checksums are published alongside any installer artifact**, and the update-check path verifies a
   downloaded update's checksum before treating it as valid.
8. **Local runtime configuration is persisted centrally** in one settings store, not scattered across
   multiple config files that can drift out of sync with each other.
9. **A production release must not ship with an unresolved version mismatch** across its component
   projects, installer metadata, and published release manifest.
