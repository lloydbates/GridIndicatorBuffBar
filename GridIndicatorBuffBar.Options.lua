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
GridIndicatorBuffBar = Grid:NewModule(GridIndicatorBuffBarName, GridIndicatorBuffBar)

function GridIndicatorBuffBar:Initialize()
  self.db = Grid.db:RegisterNamespace(GridIndicatorBuffBarName, {
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
GridFrame.options.args[GridIndicatorBuffBarName] = {
  name = L["Buff Bars"],
  type = "group",
  args = {
    barHeight = {
      name = L["Height"],
      desc = L["Height of the buff bar"],
      order = 1, width = "double",
      type = "range", min = 1, max = 100, step = 1,
      get = function (info)
        return GridIndicatorBuffBar.db.profile.barHeight
      end,
      set = function (info, value)
        GridIndicatorBuffBar.db.profile.barHeight = value
      end,      
    },
    barAlpha = {
      name = L["Alpha"],
      desc = L["Alpha value of the buff bar"],
      order = 2, width = "double",
      type = "range", min = 0, max = 1, step = 0.01, bigStep = 0.1,
      get = function (info)
        return GridIndicatorBuffBar.db.profile.barAlpha
      end,
      set = function (info, value)
        GridIndicatorBuffBar.db.profile.barAlpha = value
      end,       
    },
    barBackgroundDimmed = {
      name = L["Background dimmed by"],
      desc = L["The background of the buff bar is dimmed by this much"],
      order = 3, width = "double",
      type = "range", min = 0, max = 1, step = 0.01, bigStep = 0.1,
      get = function (info)
        return GridIndicatorBuffBar.db.profile.barBackgroundDimmed
      end,
      set = function (info, value)
        GridIndicatorBuffBar.db.profile.barBackgroundDimmed = value
      end,       
    },
    barBackgroundAlpha = {
      name = L["Background alpha"],
      desc = L["Alpha value of the background of the buff bar"],
      order = 4, width = "double",
      type = "range", min = 0, max = 1, step = 0.01, bigStep = 0.1,
      get = function (info)
        return GridIndicatorBuffBar.db.profile.barBackgroundAlpha
      end,
      set = function (info, value)
        GridIndicatorBuffBar.db.profile.barBackgroundAlpha = value
      end,       
    },
  },
}