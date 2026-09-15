# Team PM Repo design

> **Status: Parked / mothballed (2026-09-15).** This is a brainstorm-stage concept, not committed to implementation. Circle back here before starting work — see "Open questions / decisions needed" at the bottom for what's still unresolved.

## Source control (initially GitHub) as a replacement for PM software/platforms like ClickUp, Notion, Jira/Atlassian, etc...

- Note: Any locally installed application to assist in this concept must be cross-platform.

I'm considering introducing the concept of "Commit-signals" to track behaviors/actions across a small team.

Here are some ideas to consider:

- The Team repo might need to be referenced in all repos used by anyone on the team.
- Team members have one or more role which dictates what information they have available to them.
- The folder structure should be easy to understand from a human point of view, but the Commit-signals don't need to be.
- The Commit-signals are intended specifically to:
- - Keep team members aware of what they should be focused on.
- - Keep track of any given team member's time for time-sheet purposes.
- - Send notifications to other team members.
- - Etc...

## Commit-signals

- A cross-platform application might need to be installed on the device of the person connecting to the team. This application runs as if a web-socket existed with the main Team Repo.
- Commit signals are powered by AI and/or a small toolkit that runs locally and are used as signals.
- There is a specific data shape the commit uses to send signals.
E.G. 
{
	"userId": "<guid>",
	"signalType":"comment",
	"payload": {
		... <payload is specific to the signalType>
	}
}

## User stories

As a developer:
- I start my day by asking AI in any repo; what is my next task, or where did I leave off, or something to that nature.
- - AI pulls from the PM repo's main (and possibly only) branch.
- - AI compares all changes with a timestamp later than the last update in the personal-manifest.json most recent commit timestamp.
- - A local application (a bridge application) parses all of the commit messages. The commit messages have a very specific convention and are used as signals.

## Relationship to the existing per-project `PM/` model

- Decision (tentative): this Team PM repo concept is intended as an eventual **replacement** for the per-project `PM/` folder lifecycle (`backlog` → `current` → `release-candidate-dev` → `release-candidate` → `completed`, see `shared/project-management/workflow.md`), not a layer that merely observes it.
- Not yet decided: the migration path from the current per-project model to this one, or whether both models need to coexist for some transition period.

## Roles

Every team member has one or more roles. Visibility (what they can see) and permissions (what signals they can emit) are two separate matrices — a member's effective access is the union across all roles they hold.

| Role | Scope | Visibility | Can emit / trigger |
|---|---|---|---|
| **Owner** | Org-wide, all teams/projects | Everything: all signals, all timesheets, all repos referencing the Team PM repo | Role assignment, project creation/archival, any signal type |
| **Project Manager** | One or more specific projects | Task/status/blocker signals for their project(s); rolled-up (not raw) time data for their project(s) | Task assignment, priority changes, notifications to their project's members |
| **Controller** | Org-wide, but financial/time lens only | Raw time-log signals across all projects (for payroll/invoicing/billing); minimal/no visibility into technical task content | Time-sheet corrections/approvals, billing exports |
| **Developer** | Their assigned tasks, within their project(s) | Their own tasks + their project's board; notifications addressed to them | Status changes, comments, time-log, blocker flags |

Notes:
- Multi-role is a normal case, not an edge case (e.g. a small-team member could be `Developer + Project Manager`).
- `Controller` is orthogonal to project structure — it cuts across projects by *data type* (time/billing) rather than by *project membership*, unlike Owner/PM/Developer which scope by project.

### Lanes (active-role scoping)

- A user with multiple roles has a full set of held roles, plus a separate **active/current lane** — which role's view they're currently operating in.
- Switching lanes narrows the *view* (reduces noise) without changing the underlying permission set.
- This only becomes cheap/practical with the companion database below; deriving a lane purely from git replay on every query is the fallback but is not the target experience.

## Companion per-company database (optional accelerator, not a second source of truth)

Git is a good append-only event log for commit-signals, but poor at representing **current mutable state** cheaply (e.g. "what team is Bob on right now") and can't do real push/websocket notifications. A self-hosted, per-company database addresses this, under one hard rule:

- **Git remains the sole source of truth.** The database holds only state that is derived and fully rebuildable by replaying the Team PM repo's commit-signal history. If the database is wiped, replay reconstructs it — there is no data that exists only in the database.
- **Role/team-membership changes are themselves commit-signals** (e.g. `signalType: "role-grant"`, `"role-revoke"`, `"team-assign"`), not a separate database-only write path. Git's immutable, timestamped, attributed history already *is* the audit trail; the database just materializes it into:
  - A **current-state table** (fast "what is Bob's role right now" lookups), and
  - A **history table** (fast "show every role change for Bob / made by Alice" queries without walking git log).
- **Per-company hosting, pluggable backend.** Each company stands up and owns its own database instance (no Ignyos-hosted multi-tenant service). The bridge application should code against a narrow data-provider interface (e.g. `getCurrentRole(userId)`, `getTeamMembership(teamId)`, `appendSignalProjection(signal)`, `getLane(userId, activeRole)`) with swappable backend implementations, so a company can choose its preferred database type/location.
  - If the bridge app ends up being .NET, EF Core's provider model (SQLite, PostgreSQL, SQL Server, MySQL) may satisfy most of this "pluggable backend" need directly rather than requiring a hand-rolled interface — pending the tech-stack decision below.
- **Security implications (this is an authorization system, not just a data store):**
  - No direct client SQL access from the bridge app via a shared connection string — put an API layer in front so query scope is enforced server-side per role.
  - Per-role query scoping enforced server-side (e.g. a PM's query must be structurally incapable of returning another project's raw time entries).
  - Needs a secrets story for how each company's bridge app obtains/rotates its database credentials.
  - Audit trail on role/team-membership changes themselves is already covered by treating those changes as commit-signals (see above).

## Open questions / decisions needed

1. Should identity/access changes (role grants, team assignments) flow through the **same** commit-signal mechanism as routine dev activity, or should they have a separate, more restricted commit path (e.g. only Owners can write to a `roles/` folder) so they're not mixed in with normal work signals?
2. What is the intended tech stack for the companion/bridge application? This determines whether "pluggable DB" is a thin wrapper over an existing ORM's provider model (e.g. EF Core if .NET) or something built from scratch. Note the bridge app must be cross-platform, so this would likely need a new profile distinct from the existing `dotnet-windows-desktop` profile.
3. What is the migration path (if any) from the current per-project `PM/` folder model to this one, and does anything need to coexist during a transition?
4. Which initial database backends should be prioritized for the pluggable provider (e.g. SQLite for zero-infra small teams, Postgres/SQL Server/MySQL for larger self-hosted setups)?