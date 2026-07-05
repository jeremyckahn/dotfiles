---
name: fix-all
description: Searches the codebase for all FIXME comments and addresses them.
---
# Fix All FIXME Comments

This skill searches the current workspace codebase for `FIXME` comments and systematically addresses, implements, and verifies them.

## Workflow

1. **Locate Comments**: Use `grep_search` (or a terminal grep command if the tool is not available) to find all occurrences of `FIXME` in the workspace. Exclude third-party dependency directories (such as `node_modules`, `.git`, `vendor`, `build`, `dist`).
2. **Review & Plan**: For each found `FIXME` comment:
   - Use `view_file` to read the context around the comment.
   - Analyze the target code and description in the comment.
   - Determine what change is required.
3. **Address the FIXME**:
   - If the task is straightforward, write the necessary code changes using `replace_file_content` or `multi_replace_file_content`.
   - Remove the `FIXME` comment or update it as appropriate.
   - If the fix is highly ambiguous or carries structural risks, present a summary to the user and ask for confirmation/guidance.
4. **Verify**:
   - Run compilation or project tests (e.g., `npm test`, `pytest`, `cargo test` depending on project language) to verify correctness and ensure no regression.
