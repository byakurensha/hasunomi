---
name: repair
description: Reconcile and simplify the General system after Improvement exposes structural drift, duplicated guidance, growing always-loaded files, or cross-file inconsistency. Use when the user asks for the Repair Process or the Improvement repair gate recommends it.
---

# Repair

Repair keeps accumulated improvements coherent. It is not another routine
retrospective and does not run after every completed task.

Run it when the user explicitly requests Repair, or when Improvement finds a
cross-file contradiction, duplicated ownership, growing always-loaded guidance,
an obsolete route, or a change spanning `ROLE.md`, core rules, or several Skills.

1. **Baseline**: run
   `python3 system/management-tool/management-tool repair-check`. Preserve its
   metrics, failures, and warnings for comparison; do not start by editing.
2. **Canon map**: assign each durable fact one owner: `CLAUDE.md` is the stable
   entry, `ROLE.md` owns working character and boundaries, `SETTINGS.md` owns
   preferences, core rules own mandatory behavior, one Skill owns each
   repeatable workflow, manuals explain use, and `system/` implements fixed
   operations.
3. **Consistency review**: compare the relevant owners and realistic workflows.
   Find contradictions, copied policy, retired routes, stale setup guidance,
   duplicate Skills, and rules that no longer match implementation.
4. **Cost review**: compare user return with always-loaded bytes, startup work,
   API/model effort, maintenance surfaces, external dependencies, and recovery
   cost. Treat size thresholds as review warnings, not automatic deletion rules.
5. **Consolidate**: prefer replace, merge, move, or remove over adding another
   instruction. Keep project history out of ROLE and rules. Do not remove a
   working capability merely to reduce line count.
6. **Verify**: rerun `repair-check`, `doctor`, affected workflow tests, one
   realistic positive case, and one intentional no-change case. Compare the
   before/after metrics and confirm that user state and outputs were preserved.
7. **Close**: record accepted changes, removed duplication, warning
   dispositions, remaining risk, and the smallest next action in the active
   project `MASTER.md`. Then run:

   ```text
   python3 system/management-tool/management-tool repair-done \
     --changed RELATIVE_PATH
   ```

   Add one `--changed` for every intentionally changed General path. Omit it
   when Repair correctly concludes that no change is needed.

Repair is complete only when hard consistency checks pass, every warning has a
disposition, affected capabilities still work, and the resulting system is no
more complicated than the problem requires.
