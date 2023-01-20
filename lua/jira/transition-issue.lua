local M = {}

function M.transitionIssue(ticketNumber, user)
  local Job = require('plenary.job')
  local jiraCmd = '/usr/bin/jira'

  vim.api.nvim_get_color_map()



  local opts = {
    command = jiraCmd,
    args = { 'transition', 'issue', ticketNumber, user },
    on_stdout = function(_, data)
      if (data ~= nil) then
        print(ticketNumber .. ' has been assigned to ' .. user)
      end
    end,
  }


  local color = #282a36
  local job = Job:new(opts)
  job:sync(20000)

end

return M
