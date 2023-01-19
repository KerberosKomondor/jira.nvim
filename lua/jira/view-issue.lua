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

function M.viewIssue(selection)
  local issueNumber = require 'jira.parse-selection'.parseSelection(selection)
  local text = getIssueText(issueNumber)

  local Popup = require 'nui.popup'
  local event = require('nui.utils.autocmd').event

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
    },
    position = "50%",
    size = {
      width = "80%",
      height = "60%",
    },
  })

  popup:mount()
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, text)
end

return M
