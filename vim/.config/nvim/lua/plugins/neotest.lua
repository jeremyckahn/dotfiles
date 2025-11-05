return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },

      -- disable auto-opening the per-test output on run/failure
      output = {
        enabled = true,
        open_on_run = false,
      },

      -- don't open quickfix automatically
      quickfix = {
        enabled = true,
        open = false,
      },

      -- prevent the summary window from auto-opening (no-op function)
      -- neotest expects summary.open to be a string command or a function returning a win id
      summary = {
        enabled = true,
        open = function()
          return 0
        end,
      },
    },
  },
}
