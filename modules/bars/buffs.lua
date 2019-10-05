--[[
    modules\bars\buffs.lua
    Styles and Positions the Cast Bar.
]]
ImpUI_Buffs = ImpUI:NewModule('ImpUI_Buffs', 'AceEvent-3.0', 'AceHook-3.0');

-- Get Locale
local L = LibStub('AceLocale-3.0'):GetLocale('ImprovedBlizzardUI');

-- Local Functions
local Buffs = CreateFrame('Frame', nil, UIParent);

Buffs.buffPoint = BuffFrame.SetPoint;
Buffs.buffScale = BuffFrame.SetScale;

-- Local Variables
local dragFrame;

--[[
	Called when unlocking the UI.
]]
function ImpUI_Buffs:Unlock()
    dragFrame:Show();
end

--[[
	Called when locking the UI.
]]
function ImpUI_Buffs:Lock()
    local point, relativeTo, relativePoint, xOfs, yOfs = dragFrame:GetPoint();

    ImpUI.db.char.buffsPosition = Helpers.pack_position(point, relativeTo, relativePoint, xOfs, yOfs);

    dragFrame:Hide();
end

--[[
	Loads the position of the Buff Frame from SavedVariables.
]]
function ImpUI_Buffs:LoadPosition()
    local pos = ImpUI.db.char.buffsPosition;
    local scale = ImpUI.db.char.buffsScale;
    
    -- Set Drag Frame Position
    dragFrame:SetPoint(pos.point, pos.relativeTo, pos.relativePoint, pos.x, pos.y);

    BuffFrame:ClearAllPoints();
    Buffs.buffPoint(BuffFrame, 'RIGHT', dragFrame, -10, -10);
    Buffs.buffScale(BuffFrame, scale);
end


--[[
	Fires when the module is Initialised.
	
    @ return void
]]
function ImpUI_Buffs:OnInitialize()
end

--[[
	Fires when the module is Enabled. Set up frames, events etc here.
	
    @ return void
]]
function ImpUI_Buffs:OnEnable()
    -- Create Drag Frame and load position.
    dragFrame = Helpers.create_drag_frame('ImpUI_Buffs_DragFrame', 250, 50, L['Buffs & Debuffs']);

    ImpUI_Buffs:LoadPosition();

    self:SecureHook(BuffFrame, 'SetPoint', 'LoadPosition');
end

--[[
	Clean up behind ourselves if needed.
	
    @ return void
]]
function ImpUI_Buffs:OnDisable()
end