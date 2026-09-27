# PM Workflow Rules

`project-management.md` is a pure index. This file owns the rules. See `AGENTS.md` for current
direction and priorities — this file only defines process.

## Lifecycle

`backlog/` -> `current/` -> `release-candidate-dev/` -> `release-candidate/` -> `completed/`

Moving an item between folders is a plain file move. Its id (for example `bug-001`, `feat-002`)
never changes.

## Ids and prefixes

Per-prefix counters, not a global counter: `bug-001`, `bug-002`, ... and `feat-001`, `feat-002`, ...
counted separately. Starter prefixes: `bug`, `feat`, `chore`, `task`, `spike`.

## Completion confirmation

Work is done in slices. A slice may cover one item or several. A slice is bounded by the work
actually performed — it is never sized to reduce how often the developer is asked.

- An item is never marked complete, and never leaves `current/`, on AI judgment alone.
- At the end of a slice the AI stops and presents one confirmation request listing every item that
  slice touched. For each item it states what changed, how it was verified, and what was not
  covered.
- The developer answers per item. A single approval covering the whole list is allowed only when
  the developer gives it explicitly; it is never assumed from silence or from a general "looks good".
- Confirmed: update the item file, then perform the folder move.
- Rejected: the item stays where it is and the feedback is appended to its item file so the next
  session does not relitigate it.
- Request first, write second. Marking an item complete in the same turn as asking defeats the gate.
- Only items the slice actually touched appear in the list. Unrelated in-flight items are not
  bundled in to ride along on the same approval.

## Resuming a stale or ambiguous item

An item can look unfinished in `PM/` for two very different reasons: the code work genuinely isn't
done, or the code work is done and only a checklist entry or confirmation gate hasn't caught up.
Resuming work on an item must not assume the first without checking.

- Before resuming coding, verification, or building on an item (including checking out its
  existing working branch), re-read its acceptance criteria and ask the developer whether the
  implementation is already believed complete, independent of what the item file currently says.
- If the developer believes the implementation is complete while criteria remain unchecked, do not
  silently keep working those criteria as originally scoped. Ask which applies, then act on the
  answer:
  1. The criterion is still required as-written — get explicit authorization for one bounded
     verification path (see Verification scope discipline below), then run the
     completion-confirmation gate.
  2. The criterion should be revised, deferred, or dropped — update the item file to say so and
     record why, then run the completion-confirmation gate against the item as revised.
- An item's working branch existing, or being checked out again, is not itself a signal that the
  item is still active work. A completed item can keep its branch around until merge/cleanup;
  resuming that branch is maintenance, not automatic continuation of the original item.
- "The item is still in `current/`" or "the branch still exists" is never sufficient reason on its
  own to keep expanding verification work. Reconcile the item's actual status first; only then
  decide whether further work is warranted.

## Verification scope discipline

An item's existing acceptance criteria define what "done" means. Verifying that criteria stays
inside it; verification is not a side door for growing the item.

- Before adding a new check, script, or build step to verify an item, state what it is checking
  and what result would satisfy it. If that can't be stated up front, it isn't ready to run.
- A verification path must have a stated completion condition and a bounded number of attempts. If
  meeting that condition requires new tooling, source changes, or repeated retries, stop — that is
  new scope, not verification.
- A failed verification result is evidence about the item's *existing* acceptance criteria. It is
  not, by itself, license to invent new acceptance criteria, new tooling, or new build/test steps.
- Sort every verification finding into one of three named buckets, and only act on the first two:
  1. **Implementation incorrect** — fix it.
  2. **Implementation correct but unverified** — verify it, within the bounded attempts above.
  3. **Additional confidence would be nice to have** — out of scope; surface it as a suggestion,
     don't build it.
- A cancelled command, a second failed attempt at the same check, or the developer naming a loop
  or repetition is a stop signal. Stop, summarize what is confirmed vs. still open, and wait — do
  not rerun or re-expand the same verification path without the developer explicitly asking to
  continue.
- If a self-added check needs its own rounds of fixes before it can even run cleanly, that check is
  new scope, not verification. Pause and ask whether it belongs in this item before continuing.

## Checkpoints

- Adding an item to `release-candidate-dev/` creates an expectation that a dev build/deploy is
  coming next.
- Every dev deploy reviews **every** item currently in `release-candidate-dev/`. For each, ask
  directly: "did this get verified? Promote to `release-candidate/`, or demote?"
- A demoted item's target (`current/` or `backlog/`) is decided in the moment by asking — there is
  no fixed rule for which one applies.
- This checkpoint is a blocking step inside the dev-publish script itself, using the standard
  script-prompt / actor-input loop.

## Production release

- Everything in `release-candidate/` at release time is, by definition, part of the release — no
  diff-matching needed.
- At the start of a new production release: empty `completed/` (delete what the previous release
  left there) and commit that deletion, then batch-move everything from `release-candidate/` into
  `completed/`, then create the release tag and push. `completed/` never accumulates across
  releases; full history stays recoverable through git log.
- The release script may use both the raw diff and the `release-candidate/` item files together to
  ground release-notes generation.

## Dev deploys never touch PM state outside the checkpoint above

No other PM folder transition happens on a dev deploy.

## Optional: branch discipline

`branching.md` is an opt-in companion to this file covering how PM housekeeping changes and code
changes should be split across `dev` and per-item working branches. It only applies if the project
opted in during bootstrap and `PM/branching.md` exists.
