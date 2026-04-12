---
name: gh-cli
description: A skill for the GitHub CLI (`gh`)
license: MIT
compatibility: opencode
---

## What I do

This skill serves as a comprehensive, structured API guide for the GitHub CLI (`gh`). It synthesizes the full command set, detailing how each command and subcommand works across major functionalities, effectively acting as a structured reference manual derived from the raw `--help` output.

**Command Summaries (Key Usage & Flags):**

- **`gh auth`**: Manages authentication (`login`, `logout`, `refresh`). Use `gh auth status` to check the current state.
- **`gh repo`**: Manages repositories (`create`, `list`, `clone`, `view`, `delete`, `fork`, `rename`). Use `gh repo clone OWNER/REPO` to copy a repository.
- **`gh issue`**: Manages issues (`create`, `list`, `view`, `close`, `comment`). Use `gh issue create --label bug` to create an issue with a label.
- **`gh pr`**: Manages pull requests (`create`, `list`, `view`, `checkout`, `merge`, `review`). Use `gh pr view 123 --web` to view a PR in the browser.
- **`gh browse`**: Opens a resource in the web browser (`browse [<number> | <path> | <commit-sha>]`). Use `gh browse 123` for issue 123.
- **`gh api`**: Makes raw HTTP requests to the GitHub API. Supports `GET`, `POST`, and others. Key flags include `-F` (to add typed parameters), `-H` (for custom headers), and `--paginate` (for fetching all pages).
- **`gh codespace`**: Manages development environments (`create`, `list`, `edit`, `delete`, `ssh`, `stop`). Use `gh codespace create` to spin up an environment.
- **`gh gist`**: Manages Gists (`create`, `list`, `view`, `clone`, `edit`). Use `gh gist create` to create a new Gist.
- **`gh config`**: Manages CLI settings (`get`, `set`, `list`). Use `gh config set prompt enabled` to enable interactive prompting.
- **`gh status`**: Provides a holistic view of activity (issues, PRs, mentions) across subscribed repositories.
- **`gh search`**: Allows searching across various GitHub entities (`code`, `commits`, `issues`, `prs`, `repos`). Use `--` to include search qualifiers like `-label:bug`.
- **`gh run` / `gh cache`**: Manages GitHub Actions runs and caches. Use `gh run list` to see recent workflow runs, and `gh cache list` to see available caches.
- **`gh ruleset`**: Defines and manages repository rulesets (`list`, `view`, `check`). Use `gh ruleset check branch-name` to see applicable rules.
- **`gh attestation`**: Verifies artifact integrity (`verify`, `download`).
- **`gh agent-task`**: Manages automated tasks/sessions (`create`, `list`, `view`). Use `gh agent-task create "Task description"` to start a new automated task.

## When to use me

Use this skill whenever you need a complete, authoritative, and structured reference for the `gh` CLI. It is essential when you need to understand the entire scope of the CLI's API, from basic setup to highly specific, advanced features like nested API calls or complex repository automation.
