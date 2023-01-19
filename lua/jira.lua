local M = {}

function M.setup()
  vim.api.nvim_create_user_command('JiraViewIssue', require('./jira/view-issue').viewIssue, {})
end

return M
