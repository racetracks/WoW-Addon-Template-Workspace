-- MyAddon core: the root table, saved variables and the slash command.
-- Always loaded; keep it small (rules C14, G2).
local addonName, ns = ...

local GetAddOnMetadata = C_AddOns.GetAddOnMetadata

_G[addonName] = ns
ns.version = GetAddOnMetadata(addonName, "Version")

local function onAddonLoaded(self, event, name)
	if name ~= addonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	MyAddonDB = MyAddonDB or {}
	ns.db = MyAddonDB
end

local events = CreateFrame("Frame")
events:SetScript("OnEvent", onAddonLoaded)
events:RegisterEvent("ADDON_LOADED")

SLASH_MYADDON1 = "/myaddon"
SlashCmdList.MYADDON = function()
	print(addonName .. " " .. tostring(ns.version))
end
