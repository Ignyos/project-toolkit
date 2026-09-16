# Copilot Instructions

## Repository source of truth

Always treat the repository documentation as the source of truth for current product direction and implementation status.

Before answering questions about roadmap, next steps, or feature priorities, read and reconcile the current state in:

- README.md
- docs/product-roadmap.md
- docs/client-navigation-implementation-checklist.md
- docs/host-navigation-and-advanced-settings-plan.md
- PM/project-management.md (see PM/workflow.md for lifecycle rules)

If the docs no longer match reality, update the documentation before answering.

## Current documented status

Do not restate the active item or its status here — that is owned by `PM/project-management.md`'s
`current/` index and by `docs/product-roadmap.md`. Read both before answering roadmap or
next-steps questions; if they disagree with reality, fix the owning file, not this one.

## Direction rules

- Keep `docs/product-roadmap.md` and `PM/project-management.md` synchronized with implementation reality.
- Do not suggest App-management work as the current priority while `docs/product-roadmap.md` marks it deferred.
- Keep the core File Sharing experience as the primary focus.
- When direction changes, update the owning documentation in the same task instead of leaving stale guidance behind.

## "What's next?" rule

Determine the next work from `docs/product-roadmap.md`'s priority order and confirm the active
item in `PM/project-management.md`'s `current/` index; do not treat this file as a second
active-work index.
