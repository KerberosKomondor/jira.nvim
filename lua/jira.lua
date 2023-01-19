local M = {}

function M.setup()
  vim.api.nvim_create_user_command('JiraListIssues', require('./jira/list-issues').listIssues, {})
end

return M
