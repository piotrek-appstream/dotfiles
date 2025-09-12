local M = {}

-- Which theme + variants to use
M.settings = {
  name = "default", -- e.g. "catppuccin", "tokyonight"
  variants = { light = "light", dark = "dark" }, -- theme-specific names
  colorscheme = nil, -- optional override (e.g. "catppuccin")
}

-- Theme adapters registry: name -> function(opts)
-- opts = { variant="latte"/"mocha"/"day"/"night"/..., settings=M.settings }
local adapters = {}

--- Register a theme adapter
---@param name string
---@param fn fun(opts: { variant: string, settings: table })
function M.register(name, fn)
  adapters[name] = fn
end

-- ---- System dark-mode detection (overrideable) ----
-- You can replace this with your own function: M.is_dark = function() ... end
function M.is_dark()
  -- Try GNOME
  local h = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
  local out = h and h:read("*a") or ""
  if h then
    h:close()
  end
  if out:match("dark") then
    return true
  end

  -- Try KDE (very heuristic)
  local k = io.open(os.getenv("HOME") .. "/.config/kdeglobals", "r")
  if k then
    local txt = k:read("*a") or ""
    k:close()
    if txt:match("ColorScheme=.*[Dd]ark") then
      return true
    end
  end

  -- Try env hint
  if (os.getenv("DARK_MODE") or os.getenv("DARKMODE")) == "1" then
    return true
  end

  return false
end

--- Apply current theme using adapter, or fallback to background
function M.apply()
  local is_dark = M.is_dark()
  local variant = is_dark and M.settings.variants.dark or M.settings.variants.light
  local name = M.settings.name

  local adapter = adapters[name]
  if adapter then
    adapter({ variant = variant, settings = M.settings })
  else
    -- Generic fallback if no adapter registered
    vim.o.background = is_dark and "dark" or "light"
    if M.settings.colorscheme then
      pcall(vim.cmd.colorscheme, M.settings.colorscheme)
    end
  end
end

return M
