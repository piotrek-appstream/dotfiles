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

local function prefers_dark_from_gsettings()
  local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
  if not handle then
    return nil
  end

  local output = handle:read("*a") or ""
  handle:close()

  if output:match("dark") then
    return true
  end

  if output:match("light") then
    return false
  end
end

local function prefers_dark_from_kde()
  local kdeglobals = os.getenv("HOME") .. "/.config/kdeglobals"
  local file = io.open(kdeglobals, "r")
  if not file then
    return nil
  end

  local contents = file:read("*a") or ""
  file:close()

  if contents:match("ColorScheme=.*[Dd]ark") then
    return true
  end

  if contents:match("ColorScheme=.*[Ll]ight") then
    return false
  end
end

local function prefers_dark_from_env()
  local value = os.getenv("DARK_MODE") or os.getenv("DARKMODE")
  if not value then
    return nil
  end

  if value == "1" or value == "true" then
    return true
  end

  if value == "0" or value == "false" then
    return false
  end
end

local detectors = {
  prefers_dark_from_gsettings,
  prefers_dark_from_kde,
  prefers_dark_from_env,
}

-- ---- System dark-mode detection (overrideable) ----
-- You can replace this with your own function: M.is_dark = function() ... end
function M.is_dark()
  for _, detector in ipairs(detectors) do
    local ok, choice = pcall(detector)
    if ok and type(choice) == "boolean" then
      return choice
    end
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
