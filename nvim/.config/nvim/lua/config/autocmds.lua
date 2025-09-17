-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local theme = require("app.theme")

vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
  callback = function()
    theme.apply()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, { -- "CursorHold"
  pattern = { "*.cs" },
  callback = function()
    pcall(vim.lsp.codelens.refresh)
  end,
})

-- Disable spell check that's enabled by LaziVim by default.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit", "text", "plaintex", "typst" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.wrap = true
  end,
})
