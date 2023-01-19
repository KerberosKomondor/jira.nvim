local M = {}

function M.assignIssue(ticketNumber, user)
  local Job = require('plenary.job')
  local jiraCmd = '/usr/bin/jira'

  local opts = {
    command = jiraCmd,
    args = { 'assign', 'issue', ticketNumber, user },
    on_stdout = function(_, data)
      if (data ~= nil) then
        print(ticketNumber .. ' has been assigned to ' .. user)
      end
    end,
  }

  local job = Job:new(opts)
  job:sync(20000)

  return user

end

return M
