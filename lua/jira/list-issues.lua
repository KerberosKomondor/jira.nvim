local M = {}

local function listIssuesUi(lines)
  local Popup = require 'nui.popup'
  local event = require 'nui.utils.autocmd'.event

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = 'rounded',
      text = {
        top = ' My Jira Issues ',
        top_align = 'center',
      },
    },
    position = '50%',
    size = {
      width = '80%',
      height = '60%',
    },
  })

  popup:mount()

  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)

  require 'jira.keymaps'.addClose(popup.bufnr)
  require 'jira.keymaps'.addViewIssue(popup.bufnr)
  require 'jira.keymaps'.addAssignIssue()
  require 'jira.keymaps'.addAssignIssueToMe(popup.bufnr)
end

local timeout = 20000

function M.listIssues()
  local user = require 'jira.get-jira-user'.getJiraUser()
  local Job = require 'plenary.job'

  local args = {
    "issues",
    "list",
    "-a",
    user,
    "--plain",
  }

  local issues = {}

  local job = Job:new {
    command = 'jira',
    args = args,
    on_stdout = function(_, line)
      table.insert(issues, line)
    end
  }

  job:sync(timeout)

  listIssuesUi(issues)
end

return M
