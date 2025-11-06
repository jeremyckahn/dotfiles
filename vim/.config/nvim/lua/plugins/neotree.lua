-- LazyVim-friendly neo-tree.nvim override that adds "copy relative path" mappings
-- and registers which-key labels for them inside Neo-tree buffers.
--
-- Place this file in your LazyVim config (e.g. ~/.config/nvim/lua/custom/plugins/neo-tree.lua)

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
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

      -- Add mappings (merge into existing mappings)
      opts.window.mappings["<leader>y"] = copy_relative_to_root
      opts.window.mappings["<leader>Y"] = copy_relative_to_git_root

      -- filesystem-specific (optional)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      opts.filesystem.window.mappings["<leader>y"] = copy_relative_to_root

      -- which-key labels: register labels only in neo-tree buffers using an autocmd.
      -- This keeps the labels local to the neo-tree UI and doesn't interfere with other buffers.
      local has_wk, wk = pcall(require, "which-key")
      if has_wk then
        -- create a dedicated augroup so the autocmd doesn't get duplicated on reload
        local group = vim.api.nvim_create_augroup("NeoTreeWhichKey", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
          group = group,
          pattern = { "neo-tree" }, -- add "neo-tree-popup" if needed
          callback = function(args)
            local bufnr = args.buf or vim.api.nvim_get_current_buf()
            -- register only for this buffer
            wk.register({
              y = "Neo-tree: copy path (relative)",
              Y = "Neo-tree: copy path (git root)",
            }, {
              mode = "n",
              prefix = "<leader>",
              buffer = bufnr,
              silent = true,
            })
          end,
        })
      else
        -- Fallback: if which-key isn't installed, do nothing.
        -- Optionally you can register global labels like this (uncomment if desired):
        -- if has_wk then wk.register({ y = "Copy rel path", Y = "Copy git rel path" }, { mode = "n", prefix = "<leader>" }) end
      end

      return opts
    end,
  },
}
