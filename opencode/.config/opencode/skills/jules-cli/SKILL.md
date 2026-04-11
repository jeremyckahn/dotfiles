---
name: jules-cli
description: Executes tasks using the jules CLI and recursively explores its full command surface area.
license: MIT
compatibility: opencodemetadata:
  audience: dev-ops
  workflow: cli
---

## What I do

This skill provides a complete API reference for the Jules CLI, allowing agents to execute tasks and understand the entire tool's command structure.

## When to use me

Use this when you need to execute a specific task in Google Jules via CLI, or when you need a comprehensive overview of what the `jules` CLI can do.

## Jules CLI API Reference

This document provides a comprehensive reference for the Jules CLI, an asynchronous coding agent from Google.

### Global Options

The following flags apply globally to almost all `jules` commands:

- `--theme string`: Specifies the color theme to use (`dark` or `light`). Defaults to `"dark"`.

### Core Commands

#### `jules --help`

Displays a high-level overview of all available commands and examples.

#### `jules version`

Shows the current version of the Jules CLI.

#### `jules login`

Logs the user's Google account to enable Jules functionality.

- `--no-launch-browser`: Allows manual code entry instead of automatic browser launch.

#### `jules logout`

Logs the user out of their Google account.

#### `jules new`

Assigns a new session to Jules, which defaults to the current working directory's repository.
**Usage:** `jules new [flags]`
**Examples:**

- `jules new "add the solarized dark theme"`: Creates a session for a general task in the current repo.
- `jules new --repo jiahao42/jules-cli "add the solarized dark theme"`: Creates a session for a specific repository.
- `jules new --parallel 3 "task"`: Creates multiple parallel sessions for the same task (1-5).
- `cat TODO.md | jules new`: Creates sessions based on content piped from a file.
  **Flags:**
- `--parallel int`: Specifies the number of parallel sessions to create (1-5). Defaults to 1.
- `--repo string`: The repository Jules should work on (e.g., `jiahao42/jules-cli`).

#### `jules remote`

A suite of commands for interacting with remote Jules sessions.
**Usage:** `jules remote [command]`

##### `jules remote list`

Lists either remote sessions or connected repositories.
**Usage:** `jules remote list [flags]`
**Examples:**

- `jules remote list --session`: Lists all active remote sessions.
- `jules remote list --repo`: Lists all connected repositories.

##### `jules remote new`

Creates a new session in a remote Virtual Machine (VM).
**Usage:** `jules remote new [flags]`
**Examples:**

- `jules remote new --session "task"`: Creates a session based on a task description.
- `jules remote new --repo jiahao42/jules-cli --session "task"`: Creates a session in a specific remote repository.
- `jules remote new --parallel 3 --session "task"`: Creates multiple parallel sessions.
  **Flags:**
- `--parallel int`: Specifies the number of parallel sessions (1-5). Defaults to 1.
- `--repo string`: The repository Jules should work on (e.g., `jiahao42/jules-cli`).
- `--session string`: The task description for the new session.

##### `jules remote pull`

Retrieves and applies the results of a completed remote session.
**Usage:** `jules remote pull [flags]`
**Examples:**

- `jules remote pull --session 123456`: Pulls results from a specific session ID.
- `jules remote pull --session 123456 --apply`: Pulls results and applies the generated patch to the local repository.
  **Flags:**
- `--apply`: Automatically applies the patch from the remote session to the local repository.
- `--session string`: The ID of the session to pull from.

#### `jules teleport`

Clones a repository and applies the session changes, or applies the patch to an existing local repository.
**Usage:** `jules teleport <session_id> [flags]`
**Examples:**

- `jules teleport 123456`: Clones the repo and applies the session changes.
- This command automatically handles applying the patch if the user is already in the relevant repository.

### Summary of Capabilities

| Command              | Primary Function                                                               |
| :------------------- | :----------------------------------------------------------------------------- |
| `jules new`          | Initiates a new coding session on a local or specified repository.             |
| `jules remote`       | Manages sessions in a remote VM, allowing for distributed and persistent work. |
| `jules remote list`  | Provides an overview of active remote sessions and linked repositories.        |
| `jules remote new`   | Starts a new coding task within a dedicated remote environment.                |
| `jules remote pull`  | Retrieves and applies the completed work (patches) from a remote session ID.   |
| `jules teleport`     | Seamlessly integrates remote changes by cloning or applying patches locally.   |
| `jules login/logout` | Handles authentication with the user's Google account.                         |
| `jules version`      | Reports the CLI software version.                                              |

# Jules CLI API Reference

This document provides a comprehensive reference for the Jules CLI, an asynchronous coding agent from Google.

## Global Options

The following flags apply globally to almost all `jules` commands:

- `--theme string`: Specifies the color theme to use (`dark` or `light`). Defaults to `"dark"`.

## Core Commands

### `jules --help`

Displays a high-level overview of all available commands and examples.

### `jules version`

Shows the current version of the Jules CLI.

### `jules login`

Logs the user's Google account to enable Jules functionality.

- `--no-launch-browser`: Allows manual code entry instead of automatic browser launch.

### `jules logout`

Logs the user out of their Google account.

### `jules new`

Assigns a new session to Jules, which defaults to the current working directory's repository.
**Usage:** `jules new [flags]`
**Examples:**

- `jules new "add the solarized dark theme"`: Creates a session for a general task in the current repo.
- `jules new --repo jiahao42/jules-cli "add the solarized dark theme"`: Creates a session for a specific repository.
- `jules new --parallel 3 "task"`: Creates multiple parallel sessions for the same task (1-5).
- `cat TODO.md | jules new`: Creates sessions based on content piped from a file.
  **Flags:**
- `--parallel int`: Specifies the number of parallel sessions to create (1-5). Defaults to 1.
- `--repo string`: The repository Jules should work on (e.g., `jiahao42/jules-cli`).

### `jules remote`

A suite of commands for interacting with remote Jules sessions.
**Usage:** `jules remote [command]`

#### `jules remote list`

Lists either remote sessions or connected repositories.
**Usage:** `jules remote list [flags]`
**Examples:**

- `jules remote list --session`: Lists all active remote sessions.
- `jules remote list --repo`: Lists all connected repositories.

#### `jules remote new`

Creates a new session in a remote Virtual Machine (VM).
**Usage:** `jules remote new [flags]`
**Examples:**

- `jules remote new --session "task"`: Creates a session based on a task description.
- `jules remote new --repo jiahao42/jules-cli --session "task"`: Creates a session in a specific remote repository.
- `jules remote new --parallel 3 --session "task"`: Creates multiple parallel sessions.
  **Flags:**
- `--parallel int`: Specifies the number of parallel sessions (1-5). Defaults to 1.
- `--repo string`: The repository Jules should work on (e.g., `jiahao42/jules-cli`).
- `--session string`: The task description for the new session.

#### `jules remote pull`

Retrieves and applies the results of a completed remote session.
**Usage:** `jules remote pull [flags]`
**Examples:**

- `jules remote pull --session 123456`: Pulls results from a specific session ID.
- `jules remote pull --session 123456 --apply`: Pulls results and applies the generated patch to the local repository.
  **Flags:**
- `--apply`: Automatically applies the patch from the remote session to the local repository.
- `--session string`: The ID of the session to pull from.

### `jules teleport`

Clones a repository and applies the session changes, or applies the patch to an existing local repository.
**Usage:** `jules teleport <session_id> [flags]`
**Examples:**

- `jules teleport 123456`: Clones the repo and applies the session changes.
- This command automatically handles applying the patch if the user is already in the relevant repository.

## Summary of Capabilities

| Command              | Primary Function                                                               |
| :------------------- | :----------------------------------------------------------------------------- |
| `jules new`          | Initiates a new coding session on a local or specified repository.             |
| `jules remote`       | Manages sessions in a remote VM, allowing for distributed and persistent work. |
| `jules remote list`  | Provides an overview of active remote sessions and linked repositories.        |
| `jules remote new`   | Starts a new coding task within a dedicated remote environment.                |
| `jules remote pull`  | Retrieves and applies the completed work (patches) from a remote session ID.   |
| `jules teleport`     | Seamlessly integrates remote changes by cloning or applying patches locally.   |
| `jules login/logout` | Handles authentication with the user's Google account.                         |
| `jules version`      | Reports the CLI software version.                                              |
