-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local theme = require("app.theme")

local theme_group = vim.api.nvim_create_augroup("user_theme", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
  group = theme_group,
  callback = function()
    theme.apply()
  end,
})

local codelens_group = vim.api.nvim_create_augroup("user_roslyn_codelens", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  group = codelens_group,
  pattern = { "*.cs" },
  callback = function()
    pcall(vim.lsp.codelens.refresh)
  end,
})

local spell_group = vim.api.nvim_create_augroup("user_disable_spell", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = spell_group,
  pattern = { "markdown", "gitcommit", "text", "plaintex", "typst" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.wrap = true
  end,
})
