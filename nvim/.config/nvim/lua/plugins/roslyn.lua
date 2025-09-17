return {
  "seblyng/roslyn.nvim",
  init = function()
    local roslyn_path = vim.fn.expand("~/.local/share/roslyn-ls/content/LanguageServer/linux-x64/")
    if vim.fn.isdirectory(roslyn_path) == 1 then
      local current = vim.env.PATH or ""
      if not current:find(vim.pesc(roslyn_path), 1, true) then
        vim.env.PATH = roslyn_path .. ":" .. current
      end
    end
  end,
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    broad_search = true,
  },
}
