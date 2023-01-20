local M = {}

function M.setup()
  vim.api.nvim_create_user_command('JiraListIssues', require('./jira/list-issues').listIssues, {})
  --vim.api.nvim_create_user_command('JiraAssignToMe', require('./jira/assign-to-me').assignToMe, {})
  --vim.api.nvim_create_user_command('JiraTransitionIssue', require('./jira/transition-issue').transitionIssue, {})
end

return M
