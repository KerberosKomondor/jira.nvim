local M = {}

local m = 'n' --modes
local km_add = vim.api.nvim_buf_set_keymap
local km_del = vim.api.nvim_buf_del_keymap
local km_opts = { noremap = true, silent = true }

function M.addClose(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>:q!<cr>', { noremap = true, silent = true })
end

--[[ VIEW ]]
local viewKey = 'v'
function M.addViewIssue(bufnr)
  km_add(bufnr, m, viewKey, '<cmd>lua require("jira.view-issue").viewIssue(' .. bufnr .. ')<cr>', km_opts)
end

function M.delViewIssue(bufnr)
  km_del(bufnr, m, viewKey)
end

--[[ END VIEW ]]

return M
