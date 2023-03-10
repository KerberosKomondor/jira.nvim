local M = {}

function M.getJiraUser()
  local Job = require('plenary.job')
  local jiraCmd = '/usr/bin/jira'

  local user = nil

  local opts = {
    command = jiraCmd,
    args = { 'me' },
    on_stdout = function(_, data)
      user = data
    end,
  }

  local job = Job:new(opts)
  job:sync(20000)

  return user
end

return M
