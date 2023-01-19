local M = {}

function M.assignToMe()
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local attach_mappings = function(prompt_bufnr)
    actions.select_default:replace(function()
      actions.close(prompt_bufnr)
      local selection = action_state.get_selected_entry()[1]
      local issueNumber = require 'jira.parse-selection'.parseSelection(selection)

      local me = require 'jira.get-jira-user'.getJiraUser()

      require 'jira.assign-issue'.assignIssue(issueNumber, me)
    end)
    return true
  end

  require('jira.list-issues').listIssues(attach_mappings):find()
end

return M
