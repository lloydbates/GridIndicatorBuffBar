-------------------------------------------------------------------------------
-- Addon references passed by Blizzard
-------------------------------------------------------------------------------
local _, GridIndicatorBuffBar = ...

-------------------------------------------------------------------------------
-- References and local upvalues
-------------------------------------------------------------------------------
local Grid = Grid
local GridFrame = Grid:GetModule("GridFrame")
local L = Grid.L

local Media = LibStub("LibSharedMedia-3.0")

-------------------------------------------------------------------------------
-- Buff Bar indicator
-------------------------------------------------------------------------------
local buffBarNew 
local buffBarReset
local buffBarSetStatus
local buffBarClearStatus

buffBarNew = function(frame)
  local bar = CreateFrame("StatusBar", nil, frame)
  bar:SetFrameStrata("HIGH")
  bar:SetStatusBarTexture("Interface\\Addons\\Grid\\gradient32x32")
  bar.texture = bar:GetStatusBarTexture()
  bar.texture:SetHorizTile(false)

  bar:SetPoint("BOTTOMLEFT")
  bar:SetPoint("TOPRIGHT")
  
  bar.background = bar:CreateTexture(nil, "BACKGROUND")
  bar.background:SetAllPoints(bar)
  
  return bar
end

buffBarReset = function(self)
  local profile = GridFrame.db.profile
  local options = GridIndicatorBuffBar.db.profile
  local texture = Media:Fetch("statusbar", profile.texture) or "Interface\\Addons\\Grid\\gradient32x32"
  local offset = profile.borderSize + 1
  
  self:SetPoint("BOTTOMLEFT", offset, offset)
  self:SetPoint("TOPRIGHT", -offset, -profile.frameHeight + options.barHeight + offset) 
  self:SetOrientation("HORIZONTAL")

  local r, g, b, a = self:GetStatusBarColor()
  self:SetStatusBarTexture(texture)
  self:SetStatusBarColor(r, g, b, a)

  r, g, b, a = self.background:GetVertexColor()
  self.background:SetTexture(texture)
  self.background:SetHorizTile(false)
  self.background:SetVertTile(false)
  self.background:SetVertexColor(r, g, b, a)
end

buffBarSetStatus = function(self, color, text, value, maxValue, texture, texCoords, count, start, duration)
  local position = tonumber(text)
  if not position or not duration then
    buffBarClearStatus(self)
    return
  end
    
  position = position + 1
  if position > duration then 
    position = duration 
  end

  local options = GridIndicatorBuffBar.db.profile
  local maximum = duration
  
  self:SetMinMaxValues(0, maximum)
  self:SetValue(position)
  
  self:SetStatusBarColor(color.r, color.g, color.b, options.barAlpha)
  self.background:SetVertexColor(color.r * options.barBackgroundDimmed, color.g * options.barBackgroundDimmed, color.b * options.barBackgroundDimmed, options.barBackgroundAlpha)
end

buffBarClearStatus = function(self)
  self:SetMinMaxValues(0, 100)
  self:SetValue(100)

  self:SetStatusBarColor(0, 0, 0, 0)
  self.background:SetVertexColor(0, 0, 0, 0)
end

GridFrame:RegisterIndicator("buffBar", L["Buff Bar"], 
  buffBarNew, 
  buffBarReset,
  buffBarSetStatus,
  buffBarClearStatus) 

-------------------------------------------------------------------------------
-- Called when any value was changed in the options dialog
-------------------------------------------------------------------------------
function GridIndicatorBuffBar:OnConfigChanged(key, value)
  if key == "barHeight" then
    GridFrame:UpdateAllFrames()
  end
end  