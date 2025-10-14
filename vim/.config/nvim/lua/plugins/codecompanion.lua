local fmt = string.format

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
          },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = os.getenv("OLLAMA_URL"),
              },
              headers = {
                ["Content-Type"] = "application/json",
              },
              schema = {
                model = {
                  default = os.getenv("OLLAMA_MODEL"),
                },
              },
              parameters = {
                sync = true,
              },
              num_ctx = {
                default = 32768,
              },
            })
          end,
          lmstudio = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = os.getenv("LM_STUDIO_URL"),
              },
              headers = {
                ["Content-Type"] = "application/json",
              },
              schema = {
                model = {
                  default = os.getenv("LM_STUDIO_MODEL"),
                },
              },
              parameters = {
                sync = true,
              },
              num_ctx = {
                default = 32768,
              },
            })
          end,
          acp = {
            claude_code = function()
              return require("codecompanion.adapters").extend("claude_code", {
                env = {
                  CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_OAUTH_TOKEN"),
                },
              })
            end,
          },
        },
        prompt_library = {
          ["Vitest"] = {
            strategy = "chat",
            description = "Generate Vitest unit tests for the selected code",
            opts = {
              is_default = true,
              is_slash_cmd = false,
              modes = { "v" },
              short_name = "vitest",
              auto_submit = true,
              user_prompt = false,
              stop_context_insertion = true,
            },
            prompts = {
              {
                role = "system",
                content = [[When generating unit tests, follow these steps:

1. Identify the programming language.
2. Identify the purpose of the function or module to be tested.
3. Generate unit tests using Vitest.
4. Ensure the tests cover:
      - Normal cases
      - Edge cases
      - Error handling (if applicable)
5. Provide the generated unit tests in a clear and organized manner without additional explanations or chat.]],
                opts = {
                  visible = false,
                },
              },
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                  return fmt(
                    [[Generate Vitest unit tests for this code from buffer %d:

```%s
%s
```
]],
                    context.bufnr,
                    context.filetype,
                    code
                  )
                end,
                opts = {
                  contains_code = true,
                },
              },
            },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>a",
        "<cmd>CodeCompanionActions<cr>",
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "<leader>a",
        "<cmd>CodeCompanionActions<cr>",
        mode = "v",
        noremap = true,
        silent = true,
      },
      {
        "ga",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = "v",
        noremap = true,
        silent = true,
      },
    },
  },
}
