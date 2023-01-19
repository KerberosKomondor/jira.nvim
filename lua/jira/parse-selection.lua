local M = {}

local function getTicketNumber(item)
  local tbl = {}
  for i in string.gmatch(item, "%S+") do
    table.insert(tbl, i)
  end

  return tbl[2]
end

function M.parseSelection(selection)
  local ticketNumber = getTicketNumber(selection)
  return ticketNumber
end

return M
