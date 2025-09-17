return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "stylua") then
        table.insert(opts.ensure_installed, "stylua")
      end
    end,
  },
}
