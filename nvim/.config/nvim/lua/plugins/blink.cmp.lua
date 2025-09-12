return {
  {
    "saghen/blink.cmp",
    -- The following does not work for some reason
    -- opts = {
    --   keymap = { preset = "super-tab" },
    -- },
    opts = function(_, opts)
      opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
        -- Copied from https://github.com/Saghen/blink.cmp/blob/fa9e5fa324f8a721a562a7baeba35a0da44ec651/lua/blink/cmp/keymap/presets.lua#L42
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "cancel", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      })

      return opts
    end,
  },
}
