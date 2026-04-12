---
name: skill-builder
description: A comprehensive guide and helper to define reusable behavior via SKILL.md definitions for OpenCode.
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: documentation-and-creation
---

# Building an Opencode Skill

Agent skills let OpenCode discover reusable instructions from your repository or home directory. Skills are loaded on-demand via the native `skill` tool—agents see available skills and can load the full content when needed.

## 🛠️ 1. Skill File Placement

For a **global skill**, place the `SKILL.md` file in:
`~/.config/opencode/skills/<skill-name>/SKILL.md`

## 🔍 2. Understanding Discovery

OpenCode searches several locations for skills:

- **Project config**: `.opencode/skills/<name>/SKILL.md`
- **Global config**: `~/.config/opencode/skills/<name>/SKILL.md` (This is where we are placing it)
- ... and others (e.g., `.claude/skills`, `.agents/skills`).

## ✍️ 3. Writing the SKILL.md

Each `SKILL.md` **must** start with YAML frontmatter. Only these fields are recognized:

- `name` (required): The skill's unique, lowercase, alphanumeric name.
- `description` (required): A concise explanation (1-1024 characters).
- `license` (optional): The license of the skill.
- `compatibility` (optional): The compatibility scope (e.g., `opencod`).
- `metadata` (optional, string-to-string map): Additional configuration data.

**Validation Rules:**

- `name` must be 1–64 characters.
- `name` must be lowercase alphanumeric with single hyphen separators.
- `name` must not start or end with `-`, nor contain consecutive `--`.

## 📄 4. Content Structure

The skill definition should include:

### What I do

A bulleted list describing the specific actions and functionalities the skill provides (e.g., "Draft release notes," "Propose a version bump").

### When to use me

A clear, actionable guide on the conditions under which an agent should invoke this skill (e.g., "Use this when you are preparing a tagged release.").

## ⚙️ 5. Advanced Configuration

You can control skill access using permissions in `opencode.json`:

- `allow`: Skill loads immediately.
- `deny`: Skill is hidden from the agent.
- `ask`: User is prompted for approval before loading.

Permissions support wildcards (e.g., `internal-*`).

## 🚀 Example of a Complete Skill

```markdown
---
name: git-release
description: Create consistent releases and changelogs
license: MIT
compatibility: opencode
metadata:
  audience: maintainers
  workflow: github
---

## What I do

- Draft release notes from merged PRs
- Propose a version bump
- Provide a copy-pasteable `gh release create` command

## When to use me

Use this when you are preparing a tagged release. Ask clarifying questions if the target versioning scheme is unclear.
```

