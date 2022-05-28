
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    enable = "all",
  },
  highlight = {
    enable = true,
  },
  -- indent = {
  --   enable = true
  -- },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    },
}
