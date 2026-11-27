# PM Branching Guidance (Optional Module)

> Optional add-on to the selected operating mode. Offer this during PM setup (greenfield or
> existing) as an opt-in choice — when the developer declines, none of the rules below apply and
> branching is left entirely to the developer's own judgment.

## Why this exists

Work state (`backlog/` -> `current/` -> `completed/`) lives in files tracked by git. This convention
keeps unrelated PM housekeeping distinct while allowing task records to travel with the approved
work they describe.

## Core principle

Two kinds of changes are coordinated differently:

- **Task-related PM changes** — updating the task's item file to reflect an approved slice. These
  belong on that task's working branch and are normally committed with the slice.
- **Unrelated PM housekeeping changes** — creating or editing unrelated item files under `PM/`.
  These may be committed directly to `dev` when already on `dev`.
- **Code changes** — everything else. These belong on a dedicated working branch, never committed
  directly to `dev`.

## Branch naming

A working branch for an item is named after its id: `<id>` (for example `feat-014`), optionally
with a short slug appended: `<id>-<slug>` (for example `feat-014-branch-policy`).

## Rule 1 — Adding/editing a PM item while already on `dev`

No special handling needed. Commit the PM item change directly to `dev`.

## Rule 2 — Updating the task's PM record on a working branch

The AI must not switch branches or commit on the developer's behalf without confirmation. Keep
task-related PM updates on the working branch; do not switch to `dev` or merge `dev` back merely to
record task progress. Suggested sequence, offered as a strong suggestion (not a hard gate):

1. Update the task's PM record to reflect the slice.
2. Present the slice and validation results for local review and explicit acceptance.
3. After acceptance, normally commit the slice and its related PM update together.
4. Keep the task item in `current/` until its completion criteria and required integration are met.

## Rule 3 — Starting code work on an existing item while on `dev`

Before any code edit, the AI must strongly suggest creating (or switching to, if it already
exists) a working branch named after the item id, and switch to it before making changes. Do not
begin editing source files on `dev`.

## Rule 4 — Starting code work on a task that has no PM item yet

Before any code edit or branch creation, the AI must strongly suggest creating a trackable item
first (in `backlog/` or `current/` per the normal lifecycle), so the resulting working branch and
its commits can be tied to an id. Only after the item exists should Rule 3 apply.

## Rule 5 — Integrating an accepted task into `dev`

Trigger: the task's approved slices are ready, but a required merge/integration step is still open.

Suggest integrating the task branch, normally with one PR for the task containing its accepted slice
commits and related PM updates, rather than a PR per slice. If integration is part of the repository's
completion criteria, keep the item in `current/` until integration is complete; then update its PM
state without asking for a second acceptance. Where the project publishes to dev, typically publish
once after integration; handle exceptions individually and obtain the required deployment
authorization. Ask whether to delete the branch or keep it around for traceability. Advisory.

## Rule 6 — Preferring a PR over a local merge

Trigger: the repository uses branch protection or PR-based review on `dev`. Suggest opening one PR
for the task instead of merging locally, and wait for the PR to be completed before treating the
task as integrated. Do not open a separate PR for each accepted slice by default. If it's unclear
which mode the repo uses, ask rather than assume. Advisory.

## Rule 7 — Working branch has fallen behind `dev`

Trigger: `dev` has advanced with other merged items since the working branch was created. Before
continuing work, or before the Rule 5 integration, suggest merging (or rebasing) `dev` into the
working branch if needed to resolve divergence or meet repository policy. Do not sync solely to make
task-related PM updates visible on `dev`; they become visible when the task is integrated. Advisory.

## Rule 8 — Merge conflict while syncing `dev` into a working branch

Trigger: a conflict occurs during a Rule 7 sync. Stop, surface the conflicting files, and ask the
developer how to resolve them. Never auto-resolve a conflict silently.

## Rule 9 — Item demoted or descoped while its working branch exists

Trigger: the item stays active or is descoped while a working branch for it still exists. Ask
whether to keep the branch paused for later, delete it, or fold any salvageable changes elsewhere.
Advisory.

## Rule 10 — Switching away from unfinished work

Trigger: the developer wants to start or switch to a different item while the current working
branch has uncommitted changes. Suggest committing or stashing those changes first rather than
switching branches with unsaved work in place. Advisory.

## Rule 11 — Resuming work on an item that already has a branch

Trigger: Rule 3 applies, but a branch named after the item id already exists locally or on the
remote (for example, from a prior session). Suggest checking out the existing branch instead of
creating a new or conflicting one. Before resuming any coding or verification on it, first
reconcile the item's actual completion status per `workflow.md`'s "Resuming a stale or ambiguous
item" — the branch existing is not proof the item is still unfinished. Advisory.

## Rule 12 — One branch spanning multiple items

Trigger: a single change legitimately addresses more than one tracked item. Suggest either naming
the branch after both ids (for example `bug-014-bug-015`) or asking whether the items should be
split or consolidated into one. Advisory.

## Rule 13 — Branching off another working branch (dependency chain)

Trigger: an item's work depends on unmerged changes in another item's working branch. Suggest
branching from that other working branch rather than from `dev`, and flag the dependency so merge
order is preserved (the dependency must merge before or alongside the dependent item). Advisory.

## Rule 14 — Temptation to commit a small code fix directly to `dev`

Trigger: the developer wants to skip a working branch for a change that feels too small to bother
with one. Still strongly suggest a working branch tied to an item id, so the PM-housekeeping /
code separation from the Core principle holds regardless of change size. Advisory.

## Rule 15 — Avoiding accidental commits on a release branch

Trigger: the current branch is a production/release branch (for example `main`) and a code or PM
edit is about to be made. Stop and warn before proceeding, and suggest switching to `dev` or the
appropriate working branch. Treat this closer to blocking given the risk of contaminating a
release branch.

## Rule 16 — Task PM updates alongside code changes

Trigger: a working branch has code changes and a PM update for the same task. Keep the related PM
update with the approved slice commit rather than splitting it into a separate dev commit. Keep
unrelated PM housekeeping separate. Advisory.

## Enforcement style

All rules here are advisory ("strongly suggest") — the AI proposes the sequence and waits for
developer confirmation before acting; it never performs branch switches, merges, or commits
unprompted. This is distinct from the hard branch gates enforced by generated publish scripts
(`publish-dev.ps1`, `publish-live.ps1`, `release.ps1`), which fail closed regardless of
confirmation.

## Extending this file

Add new workflow examples below as additional numbered rules. Each rule should state: the trigger
condition, the current branch, the suggested action sequence, and whether it's advisory or
blocking.
