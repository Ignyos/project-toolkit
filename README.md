# Ignyos Project Toolkit

> **AI-Native Engineering Infrastructure & Project Management**  
> *Scaffold, govern, and release any project using AI agents guided by clear architectural specs — with zero repository noise or permanent dependencies.*

---

## Why Project Toolkit?

Traditional project templates and shared CI/CD scripts force every project into a lowest-common-denominator mold. Rigid templates become stale, submodule dependencies break, and shared scripts grow complex trying to accommodate every edge case.

**Project Toolkit flips this model:**

- 🤖 **Documentation as Executable Rules**: Each project type is defined by an `architecture.md` and `requirements.md`. AI agents generate fresh, idiomatic scripts and workflows tailored specifically to *your* project's constraints.
- 🧹 **Zero Repository Clutter (Ephemeral Bootstrapping)**: The toolkit is shallow-cloned temporarily into a `.scratch-toolkit/` directory during setup and **deleted as soon as bootstrapping completes**. Nothing stays in your repo except a 5-line origin breadcrumb header in generated files.
- 📋 **AI-Driven Project Management**: Built-in `PM/` conventions (`backlog` → `current` → `release-candidate-dev` → `release-candidate` → `completed`) keep AI development sessions strictly aligned with current priorities without status drift.
- 🚀 **Dual-Lane Release Architecture**: Built-in dev and production lane isolation ensures dev builds never leak pre-production code or dev domains into live releases.

---

## Quick Start (AI Bootstrap Prompt)

To adopt or bootstrap a project using `project-toolkit`, copy the prompt below and paste it directly into your AI assistant in VS Code (e.g. GitHub Copilot Chat):

```text
Please bootstrap or reconcile this repository using the Ignyos Project Toolkit.

Follow these steps:
1. Run `git clone --depth 1 https://github.com/Ignyos/project-toolkit .scratch-toolkit` in the terminal to shallow-clone the toolkit.
2. Run `.\.scratch-toolkit\bootstrap.ps1` in PowerShell to begin the interactive interview (choose Full Profile or Project Management Only, then Greenfield or Existing).
3. Follow the directives output by the bootstrap script and profile documents (`architecture.md`, `requirements.md`, `implementation-steps.md`, `acceptance-checklist.md`).
4. Apply origin breadcrumbs per `shared/breadcrumb-spec.md` to generated files.
5. Reconcile or set up `AGENTS.md` and `PM/` project management structure per the profile guidelines.
6. Once implementation and acceptance verification are complete, delete the `.scratch-toolkit` directory.
```

## How It Works (The Ephemeral Bootstrap Model)

Consuming projects **do not** add `project-toolkit` as a git submodule or commit toolkit files into their repository.

Bootstrapping uses a temporary shallow clone and hand-off:

1. **Shallow Clone**: Clone the toolkit into a temporary scratch directory:
   ```powershell
   git clone --depth 1 <toolkit-repo-url> .scratch-toolkit
   ```
2. **Run Entry Point**: Execute the bootstrap entry script:
   ```powershell
   .\.scratch-toolkit\bootstrap.ps1
   ```
3. **AI Generation & Reconciliation**: An AI agent reads the selected profile (`profiles/<profile-name>/`) and generates or reconciles project-tailored scripts, `.vscode/launch.json`, `.github/workflows/`, and `PM/` structure.
4. **Origin Breadcrumb**: Generated files receive an origin breadcrumb comment header per `shared/breadcrumb-spec.md` (recording source URL, commit SHA, profile name, and timestamp).
5. **Cleanup**: The scratch clone directory `.scratch-toolkit` is deleted.

The resulting consuming project is 100% self-contained with zero toolkit clutter, while remaining fully traceable back to the exact toolkit commit and profile that generated it.

## Growing the Toolkit (Contributing a New Profile)

If an existing or greenfield project does not fit any existing profile in `profiles/`, you can author and push a new profile directly back to `project-toolkit` during the bootstrap run:

1. In `bootstrap.ps1`, select **Full Project Profile**, then choose `[+] Create a New Profile`.
2. Enter the new profile folder name (e.g. `python-fastapi-service`).
3. The bootstrapper dispatches to `bootstrap/create-new-profile.ps1` which guides the AI assistant in drafting the 5 core profile files under `.scratch-toolkit/profiles/<new-profile>/`:
   - `architecture.md`
   - `requirements.md`
   - `implementation-steps.md`
   - `acceptance-checklist.md`
   - `reference/` (copies real working scripts if an existing project)
4. The AI assistant stages and commits the new profile locally (`git commit -m "feat(profile): add <new-profile>"`).
5. The assistant attempts `git push origin main`. If the developer lacks write permissions (e.g. Git 403), the bootstrapper offers 3 fallback submission paths:
   - **Personal Fork & PR**: Push to a developer fork and open a Pull Request against `project-toolkit`.
   - **Export Zip Artifact**: Package the profile into `artifacts/new-profile-<name>.zip` for submission via a GitHub Issue or Discussion.
   - **Proceed Locally**: Continue bootstrapping the target project using the locally committed profile.
6. The bootstrapper immediately proceeds to use the newly created profile to bootstrap the target project!

## Repository Structure

- `profiles/` — Profile definitions by project type (e.g., `dotnet-windows-desktop`, `vanilla-js-github-pages-spa`).
  - `architecture.md` — High-level project shape and components.
  - `requirements.md` — Mandatory requirements for a correct implementation.
  - `implementation-steps.md` — Step-by-step guidance for AI-assisted generation (greenfield & existing).
  - `acceptance-checklist.md` — Post-generation verification checklist.
  - `reference/` — Real, working reference scripts (labeled as reference, not a template).
- `shared/` — Cross-cutting conventions.
  - `breadcrumb-spec.md` — Comment header format for generated files.
  - `ai-direction-guidance.md` — Guidance for setting up `AGENTS.md` and Copilot instructions.
  - `project-management/` — Standard `PM/` folder structure and workflow rules.
