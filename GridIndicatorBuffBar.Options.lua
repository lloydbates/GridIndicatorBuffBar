-------------------------------------------------------------------------------
-- Addon references passed by Blizzard
-------------------------------------------------------------------------------
local GridIndicatorBuffBarName, GridIndicatorBuffBar = ...

-------------------------------------------------------------------------------
-- References and local upvalues
-------------------------------------------------------------------------------
local Grid = Grid
local GridFrame = Grid:GetModule("GridFrame")
local L = Grid.L

-------------------------------------------------------------------------------
-- Build a new module
-------------------------------------------------------------------------------
local module = Grid:NewModule("buffBar")

function module:OnInitialize()
  GridIndicatorBuffBar.db = Grid.db:RegisterNamespace(GridIndicatorBuffBarName, {
    profile = {
      barHeight = 4,
      barAlpha = 1,
      barBackgroundDimmed = 0.3,
      barBackgroundAlpha = 0.75
    }
  })
end

-------------------------------------------------------------------------------
-- Inject options into Grid
-------------------------------------------------------------------------------
GridFrame.options.args["buffBar"] = {
  name = L["Buff Bars"],
  type = "group",
  get = function (info)
    local k = info[#info]
    return GridIndicatorBuffBar.db.profile[k]
  end,
  set = function (info, value)
    local k = info[#info]
    GridIndicatorBuffBar.db.profile[k] = value
  end,
  args = {
    barHeight = {
      name = L["Height"],
      desc = L["Height of the buff bar"],
      order = 1, width = "double",
      type = "range", min = 1, max = 100, step = 1,
    },
    barAlpha = {
      name = L["Alpha"],
      desc = L["Alpha value of the buff bar"],
      order = 2, width = "double",
      type = "range", min = 0, max = 1, step = 0.01, bigStep = 0.1,
    },
    barBackgroundDimmed = {
      name = L["Background dimmed by"],
      desc = L["The background of the buff bar is dimmed by this much"],
      order = 3, width = "double",
      type = "range", min = 0, max = 1, step = 0.01, bigStep = 0.1,
    },
    barBackgroundAlpha = {
      name = L["Background alpha"],
      desc = L["Alpha value of the background of the buff bar"],
      order = 4, width = "double",
      type = "range", min = 0, max = 1, step = 0.01, bigStep = 0.1,
    },
  },
}