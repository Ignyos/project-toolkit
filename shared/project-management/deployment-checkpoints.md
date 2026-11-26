# Optional Deployment Candidate Checkpoints

Use this module only when explicitly selected during bootstrap. It adds coordination around
deployment candidates without changing the work lifecycle or granting deployment authority.

- Track candidate IDs and their separate deployment-verification state in a PM deployment index
  (for example, `PM/deployments/dev.md` and `PM/deployments/production.md`). Do not move work
  items out of `backlog/`, `current/`, or `completed/` to represent deployment state.
- Before promotion to a deployment candidate list, an authorized human explicitly confirms the
  item-level verification decision. Keep this decision separate from acceptance and deployment
  authorization.
- A dev deployment may present the current dev candidate list for review, but it does not require
  a new decision on every unchanged candidate. Ask only for a newly required or unresolved
  decision; explain the specific choice and its consequence.
- Promotion or removal from a candidate list is a separate, explicit decision. Do not infer
  promotion from a successful deployment or a general approval.
- The publish script asks once for authorization to perform the named deployment, using a clear
  default-No `Yes` / `No` prompt. It does not collect per-item decisions, update candidate lists,
  or edit task files.
- State clearly when a candidate requires the developer at an interactive terminal. Never simulate
  a live approval.
