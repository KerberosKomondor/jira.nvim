local M = {}

function M.setup()
  vim.api.nvim_create_user_command('JiraViewIssue', require('./jira/view-issue').viewIssue, {})
  vim.api.nvim_create_user_command('JiraAssignToMe', require('./jira/assign-to-me').assignToMe, {})
end

return M
