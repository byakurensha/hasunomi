---
name: improvement
description: Run the formal seven-stage improvement process when requested or when accumulated evidence makes a full review worthwhile.
---

# Improvement

Improvement is a closed loop, not a short retrospective:

```text
Evidence -> Root cause -> Disposition -> Change -> Verification
```

Use `system/record-templates/REVIEW.md` and complete all seven stages.

Do not trigger this process from a fixed number of completed tasks. Compare the
likely reusable benefit with the time, API cost, disruption, and available
evidence. Routine completion records may accumulate without forcing a formal
review.

1. **Scope Recall**: restate the request, success criteria, constraints, project
   `MASTER.md`, actual outputs, corrections, and available evidence.
2. **Output Review**: inspect recipient-facing results for correctness,
   usability, safety, completeness, and avoidable complexity.
3. **Work Reflection**: separate symptoms from supported root causes and decide
   whether each issue is isolated, project-specific, or reusable.
4. **Memory Review**: search `MEMORY/` before changing it. Merge, replace, or
   remove stale entries instead of adding duplicates.
5. **Method Check**: give every finding one destination: Project, Memory,
   SETTINGS, ROLE, core rule, Skill, Template, Archive, or No change.
6. **Targeted Update**: apply only justified high-value changes, remove
   obsolete guidance, and verify realistic positive and no-change cases. Do
   not solve a cross-file structural problem by adding another copied rule.
7. **Next Action and Repair Gate**: record changes, evidence,
   rejected/deferred items, remaining risk, next owner, and the smallest next
   action in `MASTER.md`. Decide whether Repair is required. It is required
   when the finding spans `ROLE.md`, core rules, several Skills, or exposes
   duplication, contradiction, retired routes, or always-loaded growth.

Ask before a major policy change, external-account action, payment, destructive
work, or a change to the user's established workflow. A valid run may conclude
that no change is needed. Update setup orientation and both manuals whenever a
first-time workflow changes.

After the review is recorded and verified, run the command below. Add one
`--changed RELATIVE_PATH` for each General file or folder intentionally changed
by this review. Do not include unrelated user edits.

```text
python3 system/management-tool/management-tool improvement-done \
  --changed MEMORY/MEMORY.md
```

Omit `--changed` when the review changes no reusable rule, setting, template,
or Memory file. This command runs a lightweight structural check and reports
whether the separate Repair Process is recommended. If recommended, complete
the repair skill before treating the system-level finding as closed.
