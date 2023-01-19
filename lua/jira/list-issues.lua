local M = {}

function M.listIssues(opts)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local user = require 'jira.get-jira-user'.getJiraUser()

  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local jiraCommand = {
    "jira",
    "issues",
    "list",
    "-a",
    user,
    "--plain",
  }

  opts = opts or {}

  pickers.new(opts, {
    prompt_title = "Jira Issues",
    finder = finders.new_oneshot_job(jiraCommand, opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()[1]
        require 'jira.view-issue'.viewIssue(selection)
      end)
      return true
    end
  }):find()
end

return M
