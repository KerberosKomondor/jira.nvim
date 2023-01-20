local M = {}

function M.transitionIssue(bufnr)
  local selection = vim.api.nvim_get_current_line()
  local issueNumber = require 'jira.parse-selection'.parseSelection(selection)

  local Terminal = require('toggleterm.terminal').Terminal
  local term = Terminal:new {
    direction = 'float',
    cmd = 'jira issue transition ' .. issueNumber,
    close_on_exit = true,
  }

  term:toggle()

  vim.notify(issueNumber .. ' has been transitioned')
end

return M
