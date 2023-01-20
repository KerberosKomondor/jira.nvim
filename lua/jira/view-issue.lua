local M = {}

local function getIssueText(issueNumber)
  local Job = require('plenary.job')
  local jiraCmd = '/usr/bin/jira'

  local issueText = {}

  local opts = {
    command = jiraCmd,
    args = { 'issue', 'view', issueNumber, '--plain' },
    on_stdout = function(_, line)
      table.insert(issueText, line)
    end,
  }

  local job = Job:new(opts)
  job:sync(20000)

  return issueText
end

function M.viewIssue(bufnr)
  require 'jira.keymaps'.delViewIssue(bufnr)

  local selection = vim.api.nvim_get_current_line()
  local issueNumber = require 'jira.parse-selection'.parseSelection(selection)
  local text = getIssueText(issueNumber)

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, text)
end

return M
