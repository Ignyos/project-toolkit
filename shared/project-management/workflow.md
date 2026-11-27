# Shared Project Management Safety Baseline

This file defines the rules shared by every operating mode. During bootstrap, compose it with
exactly one of `solo-mode.md` or `team-mode.md`, then add only the optional modules the developer
selected. The generated `PM/workflow.md` must name its operating mode and enabled modules.

`PM/project-management.md` is an index, not a second source of workflow rules. Product priorities
and broad roadmap status belong in the project's roadmap, if one exists.

## Work lifecycle

The default work lifecycle is:

`backlog/` -> `current/` -> `completed/`

`completed/` means the work is implemented, required validation has passed, any integration step
required by the agreed criteria or repository policy is complete, and an authorized human has
accepted the result. It does not mean deployed or released. Deployment state is tracked separately
and never changes an item's work status.

Moving an item between folders is a plain file move. Its id (for example, `bug-001` or `feat-002`)
never changes. Use per-prefix counters, not a global counter. Starter prefixes: `bug`, `feat`,
`chore`, `task`, and `spike`.

## Ownership and approval boundaries

During bootstrap, ask who is accountable for priorities and acceptance, and who may authorize
deployment and other consequential external actions. These may be the same person. In Team mode,
ask for reviewer/maintainer roles as needed. Record the agreed roles; do not infer them or assume an
AI assistant has any of these authorities.

- The developer defines or confirms scope and acceptance criteria. The AI may investigate, plan,
  implement, run in-scope validation, and report findings within that agreed scope.
- An authorized human accepts a completed work slice. The AI may update the affected item records
  and lifecycle locations after that acceptance; do not ask for a second approval solely to perform
  this PM bookkeeping.
- Deploying, publishing, tagging, pushing, deleting shared data, or other consequential external
  actions require explicit authorization for that action. Approval to implement or accept work is
  not deployment approval.
- A deployment confirmation authorizes only the stated deployment. It does not certify individual
  work items, accept them, or change their PM state.
- If authority, acceptance, scope, or the effect of an action is unclear, stop and ask. Silence,
  a general "looks good," or approval for a different action is not authorization.

Use short, case-insensitive choices such as `Yes` / `No`, show the default, and make cancellation
effects clear. For consequential actions, the default is `No`.

## Work completion and review

Work is completed in bounded slices, sized to the work actually performed. Before starting, the
slice has observable acceptance criteria and a stated validation scope. At the end, report what
changed, what validation ran and passed or
failed, and what remains unverified. Ask the authorized human to accept the clearly enumerated
slice using a short, visible-default choice (for example, `Accept this slice? [y/N]`). One
acceptance may cover the whole slice; do not
require separate repeated approval for each item when its criteria and review are shared. Do not
bundle unrelated, untouched items into the approval. Do not infer acceptance from silence or a
general "looks good." If acceptance is declined, keep the item active and record the requested
follow-up in its item notes.

Do not mark work complete on AI judgment alone. Once accepted, update the item and move it to
`completed/` without another approval prompt for the status update only when the item's acceptance
criteria are all satisfied and any required integration is complete. For a partial slice, record
the accepted progress but keep the item in `current/`.

## Slice commits and task integration

Review each bounded slice locally and report its validation before requesting acceptance. After
acceptance, normally commit that slice together with its related PM-record updates; do not make a
separate administrative commit just to keep task records current. Keep unaccepted work out of an
approved-slice commit unless the developer explicitly chooses otherwise.

When a task uses a branch and pull requests, normally use one PR for the task, containing its
approved slice commits and related PM updates, rather than opening a PR for each slice. For projects
that publish to a dev environment, typically publish once after the task is integrated. Handle
exceptions individually according to project needs and repository policy. Integration, PR approval,
and deployment remain separate from slice acceptance; publishing still requires explicit
authorization.

## Resuming a stale or ambiguous item

An item can appear unfinished because implementation is incomplete or because its PM record has not
caught up. Before resuming coding or verification, read the item's acceptance criteria and ask the
developer whether the implementation is already believed complete.

- If it is believed complete but criteria remain unchecked, ask whether the criterion is still
  required, should be revised, or should be deferred/dropped. Do not silently expand verification.
- If further verification is still required, agree on its bounded path and completion condition
  before running it.
- An existing working branch or an item remaining in `current/` is not proof that more coding is
  required. Reconcile the actual status first.

## Verification scope

An item's acceptance criteria define what "done" means. Verification must stay within them.

- Before adding a check, state what it verifies and the result that would satisfy it.
- Every verification path has a completion condition and a bounded number of attempts.
- A failed check is evidence about the existing criteria, not permission to invent new scope,
  tooling, or build steps.
- Classify findings as **implementation incorrect**, **correct but unverified**, or **additional
  confidence only**. Fix the first, verify the second within scope, and surface the third without
  expanding the task.
- Stop after cancellation, a repeated failure, or a request to stop. Summarize confirmed and open
  results; do not retry or broaden the path without authorization.

## PM state and publishing are independent

Publishing scripts and workflows operate on build/deployment inputs only. They must not move,
delete, edit, or mark PM items complete, nor make per-item verification or promotion decisions.
Keep deployment authorization, feature verification, human acceptance, and PM state updates as
separate decisions.

Projects may opt into the `deployment-checkpoints.md` module for separate candidate tracking and
promotion. Even then, deployment scripts only perform the explicitly authorized deployment; the
checkpoint is a separate workflow action.

## Interactive terminal requirements

When a command requires a human response (for example, PowerShell `Read-Host`), state which step
needs the developer's interactive terminal and what choices it presents. Do not simulate approval,
pipe a guessed response, or claim a command succeeded when it stopped waiting for input. If the
developer cannot interact with that terminal, stop before the gated action and offer a safe
non-mutating alternative where one exists.

## Optional modules

Only apply coordination rules that were selected during setup:

- `branching.md` — advisory branch and PM housekeeping practices.
- `deployment-checkpoints.md` — separate per-item deployment candidate review and promotion.
- `evidence-policy.md` — persistent per-item verification records.

Absence of a module means its additional rules do not apply. A repository's own branch protection,
CI policy, and release safeguards remain in force regardless of PM mode or module selection.
