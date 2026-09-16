# AI Direction Guidance

This document defines how the bootstrapping process sets up or reconciles AI direction files (`AGENTS.md`, `.github/copilot-instructions.md`, `SKILL.md`) in a target project.

## Principle: Single Source of Truth

Repository documentation and AI direction files are the source of truth for project direction, status, and AI assistant behavior. AI assistants must rely on checked-in documentation rather than memory or stale context.

## Greenfield Project Setup

When bootstrapping a new project:

1. Create `AGENTS.md` at the project root with:
   - Project purpose and canonical project status.
   - Required workflow rules (e.g. read status before answering roadmap questions).
   - Pointer sentence to `PM/workflow.md` for project management lifecycle rules.
2. Create `.github/copilot-instructions.md` with repository-specific Copilot instructions aligned with `AGENTS.md`.

## Existing Project Reconciliation

When adopting the toolkit in an existing project:

1. **Read existing AI direction files first.** Inspect `AGENTS.md`, `.github/copilot-instructions.md`, or similar files.
2. **Preserve existing project context.** Do not overwrite existing status, architectural notes, or custom project rules.
3. **Append / Merge profile direction rules.** Add the pointer to `PM/workflow.md` and any profile-specific constraints (e.g., version source of truth rules or dual-lane publishing requirements).
4. Verify that the reconciled file does not contain contradictory guidance or duplicate sections.

## Optional: Branch-Discipline Guidance

`shared/project-management/branching.md` is an opt-in module layered on top of `workflow.md`. It
is offered as a developer choice during bootstrap (greenfield or existing), never assumed:

1. If the developer opts in, copy `branching.md` into `PM/branching.md` in the target project and
   apply the origin breadcrumb per `shared/breadcrumb-spec.md`.
2. Add a `Branching Policy: enabled, see PM/branching.md` pointer line next to the existing
   `PM/workflow.md` pointer sentence in `AGENTS.md` / `.github/copilot-instructions.md`.
3. If the developer declines, do not create `PM/branching.md` and do not add the pointer line.
   Absence of the file means the rules do not apply.
