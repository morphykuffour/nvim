local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "morpheus.lsp.lsp-installer"
require("morpheus.lsp.handlers").setup()
-- require "morpheus.lsp.null-ls"
