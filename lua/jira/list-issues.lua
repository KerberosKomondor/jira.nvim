local M = {}

function M.listIssues(attach_mappings, opts)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local user = require 'jira.get-jira-user'.getJiraUser()

  local jiraCommand = {
    "jira",
    "issues",
    "list",
    "-a",
    user,
    "--plain",
  }

  opts = opts or {}

  local picker = pickers.new(opts, {
    prompt_title = "Jira Issues",
    finder = finders.new_oneshot_job(jiraCommand, opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = attach_mappings
  })
  return picker
end

return M
