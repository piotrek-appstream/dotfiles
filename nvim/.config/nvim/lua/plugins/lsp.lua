local roslyn_path = vim.fn.expand("~/.local/share/roslyn-ls/content/LanguageServer/linux-x64/")
vim.env.PATH = roslyn_path .. ":" .. vim.env.PATH

return {
  "seblyng/roslyn.nvim",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {},
}
