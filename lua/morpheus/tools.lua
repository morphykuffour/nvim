-- in tools.lua
local api = vim.api
local M = {}
function M.makeScratch()
  api.nvim_command('enew') -- equivalent to :enew
  api.botright[0].buftype=nofile -- set the current buffer's (buffer 0) buftype to nofile
  api.botright[0].bufhidden=hide
  api.botright[0].swapfile=false
end
return M
