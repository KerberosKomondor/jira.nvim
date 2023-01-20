local M = {}

local m = 'n' --modes
local km_add = vim.api.nvim_buf_set_keymap
local km_del = vim.api.nvim_buf_del_keymap
local km_opts = { noremap = true, silent = true }

function M.addClose(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>:q!<cr>', { noremap = true, silent = true })
end

local function add(bufnr, key, cmd)
  km_add(bufnr, m, key, cmd, km_opts)
end

local function del(bufnr, key)
  km_del(bufnr, m, key)
end

--[[ VIEW ]]
local viewKey = 'v'
function M.addViewIssue(bufnr)
  add(bufnr, viewKey, '<cmd>lua require("jira.view-issue").viewIssue(' .. bufnr .. ')<cr>')
end

function M.delViewIssue(bufnr)
  del(bufnr, viewKey)
end

--[[ END VIEW ]]

--[[ ASSIGN ]]
local assignKey = 'a'
function M.addAssignIssue(bufnr)
  add(bufnr, assignKey, '<cmd>lua require("jira.assign-issue").assignIssue(' .. bufnr .. ')<cr>')
end

function M.delAssignIssue(bufnr)
  del(bufnr, assignKey)
end

--[[ END ASSIGN]]

--[[ ASSIGN TO ME ]]
local assignToMeKey = 'm'
function M.addAssignIssueToMe(bufnr)
  add(bufnr, assignToMeKey, '<cmd>lua require("jira.assign-issue").assignIssueToMe(' .. bufnr .. ')<cr>')
end

function M.delAssignIssueToMe(bufnr)
  del(bufnr, assignToMeKey)
end

--[[ END ASSIGN TO ME]]
return M
