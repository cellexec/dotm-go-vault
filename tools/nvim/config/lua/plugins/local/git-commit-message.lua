print("Loading git-commit-message.lua")
return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local commit_types = {
      { "feat", "A new feature" },
      { "fix", "A bug fix" },
      { "docs", "Documentation only changes" },
      { "style", "Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)" },
      { "refactor", "A code change that neither fixes a bug nor adds a feature" },
      { "perf", "A code change that improves performance" },
      { "test", "Adding missing tests or correcting existing tests" },
      { "chore", "Changes to the build process or auxiliary tools and libraries such as documentation generation" },
      { "ci", "Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)" },
      { "build", "Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)" },
    }

    local function git_message_picker()
      require("telescope.pickers").new({}, {
        prompt_title = "Git Commit Message",
        finder = require("telescope.finders").new_table {
          results = commit_types,
          entry_maker = function(entry)
            return {
              value = entry[1],
              display = string.format("%s: %s", entry[1], entry[2]),
              ordinal = entry[1],
            }
          end,
        },
        sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.api.nvim_put({ selection.value .. ": " }, "c", false, true)
          end)
          return true
        end,
      }):find()
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gitcommit",
      callback = function()
        vim.keymap.set("n", "<leader>gm", git_message_picker, { buffer = true, desc = "Git Message" })
      end,
    })
  end,
}