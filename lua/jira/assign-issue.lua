local Job = require('plenary.job')

local M = {}

local jiraCmd = '/usr/bin/jira'
local timeout = 20000

function M.assignToMe(bufnr)

  local selection = vim.api.nvim_get_current_line()
  local issueNumber = require 'jira.parse-selection'.parseSelection(selection)

  local user = require 'jira.get-jira-user'.getJiraUser()

  local job = Job:new({
    command = jiraCmd,
    args = { 'issue', 'assign', issueNumber, user },
    on_stdout = function(_, data)
      if (data ~= nil) then
        print(issueNumber .. ' has been assigned to ' .. user)
      end
    end,
  })
  job:sync(timeout)

  vim.notify(issueNumber .. ' has been assign to ' .. user)
  vim.api.nvim_buf_delete(bufnr, { force = true })
end

function M.assignIssue()
  local selection = vim.api.nvim_get_current_line()
  local issueNumber = require 'jira.parse-selection'.parseSelection(selection)

  local Terminal = require('toggleterm.terminal').Terminal
  local term = Terminal:new {
    direction = 'float',
    cmd = 'jira issue assign ' .. issueNumber,
    close_on_exit = true,
  }

  term:toggle()
end

return M
