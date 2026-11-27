# Solo Operating Mode

This is the Solo overlay for `PM/workflow.md`. It is independent of the selected technology
profile. Use it with the shared safety baseline.

- Keep work tracking to `backlog/`, `current/`, and `completed/`. Do not require release-candidate
  folders or separate administrative PM commits.
- The developer is the accountable owner unless they designate another person. The developer sets
  scope and acceptance criteria, reviews the bounded result, and explicitly accepts it.
- One human acceptance may cover a clearly enumerated work slice. Do not add a per-item evidence
  log, a second status-transition approval, or per-item deployment-promotion approval unless the
  developer opted into the corresponding module.
- Do not require a pull request or a dedicated working branch solely because of PM convention.
  Follow repository protections and any separately enabled branching policy.
- Keep PM records concise and update them as part of the accepted work. When using task branches,
  normally include the related PM update in each accepted slice commit rather than making a separate
  administrative commit.
- Deployment remains a separate, explicitly authorized operation. A deploy does not mark work
  accepted or completed.
