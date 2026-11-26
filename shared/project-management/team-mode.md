# Team Operating Mode

This is the Team overlay for `PM/workflow.md`. It is independent of the selected technology
profile. Use it with the shared safety baseline.

- Keep the default work lifecycle to `backlog/`, `current/`, and `completed/`; deployment is
  separate from work status.
- During setup, ask for the team's accountable owner/maintainer and who may review and accept work.
  Record deployment authority separately. Do not infer these roles from repository access or from
  an AI assistant's participation.
- Add assignee, reviewer, handoff notes, or decision history to an item when coordination requires
  them. Do not make every field or a particular approval sequence mandatory by default.
- Team members may prepare and review work according to the agreed roles. Only an authorized human
  accepts work; a reviewer decision does not itself authorize a deployment.
- Pull requests, separate PM commits, per-item evidence, and deployment candidate checkpoints are
  governed by repository policy or explicitly selected optional modules, not by Team mode alone.
- Make handoffs resumable: keep current scope, acceptance criteria, decisions, validation status,
  and next action in the owning item or project documentation.
