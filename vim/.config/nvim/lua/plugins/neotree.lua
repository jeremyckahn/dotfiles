-- LazyVim-friendly neo-tree.nvim override that adds "copy relative path" mappings
-- Place this file in your LazyVim config (e.g. ~/.config/nvim/lua/plugins/neo-tree.lua)

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- Use opts function so Lazy will pass the plugin's default opts and we can merge.
    opts = function(_, opts)
      local function normalize_path(p)
        if not p then
          return p
        end
        p = p:gsub("\\", "/")
        p = p:gsub("/+$", "")
        return p
      end

      local function copy_relative_to_root(state)
        local node = state.tree:get_node()
        if not node or not node.path then
          vim.notify("No node path to copy", vim.log.levels.WARN)
          return
        end
        local full = normalize_path(node.path)
        local root = normalize_path(state.path or vim.loop.cwd() or "")
        local rel = full
        if root ~= "" and full:sub(1, #root) == root then
          rel = full:sub(#root + 2)
        end
        if rel == "" then
          rel = "."
        end
        vim.fn.setreg("+", rel)
        vim.fn.setreg('"', rel)
        vim.notify("Copied relative path: " .. rel)
      end

      local function copy_relative_to_git_root(state)
        local node = state.tree:get_node()
        if not node or not node.path then
          vim.notify("No node path to copy", vim.log.levels.WARN)
          return
        end
        local full = normalize_path(node.path)

        -- try git root for this file/dir
        local git_root = ""
        local ok, out = pcall(function()
          return vim.fn.systemlist({ "git", "-C", full, "rev-parse", "--show-toplevel" })
        end)
        if ok and type(out) == "table" and #out > 0 then
          git_root = out[1] or ""
        end
        if git_root == "" then
          git_root = state.path or vim.loop.cwd() or ""
        end

        git_root = normalize_path(git_root)
        local rel = full
        if git_root ~= "" and full:sub(1, #git_root) == git_root then
          rel = full:sub(#git_root + 2)
        end
        if rel == "" then
          rel = "."
        end
        vim.fn.setreg("+", rel)
        vim.fn.setreg('"', rel)
        vim.notify("Copied path (git-root relative): " .. rel)
      end

      -- Ensure opts.window and opts.window.mappings exist
      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}

      -- Merge in new mappings without clobbering existing ones.
      -- Use <leader>y / <leader>Y so we don't unintentionally override builtin 'y'.
      opts.window.mappings["<leader>y"] = copy_relative_to_root
      opts.window.mappings["<leader>Y"] = copy_relative_to_git_root

      -- If you prefer to add the mapping only for the filesystem source, use:
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      -- filesystem-specific mapping (optional)
      opts.filesystem.window.mappings["<leader>y"] = copy_relative_to_root

      -- If you explicitly want to OVERRIDE the default 'y' behavior (not recommended by default),
      -- uncomment the next line:
      -- opts.window.mappings["y"] = copy_relative_to_root

      return opts
    end,
  },
}
