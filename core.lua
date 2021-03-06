-- Create Ace3 Addon.
ImpUI = LibStub('AceAddon-3.0'):NewAddon('ImprovedBlizzardUI_Classic', 'AceConsole-3.0', 'AceHook-3.0');

-- Get Localisation
local L = LibStub('AceLocale-3.0'):GetLocale('ImprovedBlizzardUI_Classic');

-- LibSharedMedia-3.0
LSM = LibStub('LibSharedMedia-3.0');

--[[
    Opens the Improved Blizzard UI options panel.

    Yes this really does call the exact same function twice. This is due to a Blizzard
    bug that has existed ever since InterfaceOptionsFrame_OpenToCategory was put in
    the game. Since it's been years and would take someone 2 minutes to fix, we 
    can only assume Blizzard just doesn't care and won't ever fix it.
	
    @ return void
]]
local function OpenOptions()
    InterfaceOptionsFrame_OpenToCategory(ImpUI.optionsFrame);
    InterfaceOptionsFrame_OpenToCategory(ImpUI.optionsFrame);
end

-- The Modules / Elements that can be moved.
local draggable = {
    'ImpUI_OSD',
    'ImpUI_Killfeed',
    'ImpUI_Player',
    'ImpUI_Target',
    'ImpUI_Party',
    'ImpUI_CastBar',
    'ImpUI_Buffs',
};

local isEditing = false;

--[[
	Unlocks all of the UI draggable frames.
]]
local function UnlockFrames()
    if (isEditing) then return; end

    for i, module in pairs (draggable) do
        local m = ImpUI:GetModule(module);
        m:Unlock();
    end 

    isEditing = true;
end

--[[
	Locks all of the UI draggable frames.
]]
local function LockFrames()
    if (isEditing == false) then return; end

    for i, module in pairs (draggable) do
        local m = ImpUI:GetModule(module);
        m:Lock();
    end 

    isEditing = false;
end

--[[
    Just prints the addons configuration options.
	
    @ return void
]]
local function PrintConfig()
    ImpUI:Print(L['/imp - Open the configuration panel.']);
    ImpUI:Print(L['/imp grid - Toggle a grid to aid in interface element placement.']);
    ImpUI:Print(L['/imp unlock - Unlocks the interfaces movable frames. Locking them saves position.']);
    ImpUI:Print(L['/imp lock - Locks the interfaces movable frames.']);
end

--[[
    Handles the /imp slash command.

    For now just opens options.
	
    @ return void
]]
function ImpUI:HandleSlash(input)
    -- Nothing provided. Just open options and print config commands.
    if (not input or input:trim() == '') then
        OpenOptions();
        PrintConfig();
    end

    local command = input:trim();

    -- Grid
    if (command == 'grid') then
        local grid = ImpUI:GetModule('ImpUI_Grid');
        grid:ToggleGrid();
        return;
    end

    -- Unlock
    if (command == 'unlock') then
        UnlockFrames();
    end

    -- Lock
    if (command == 'lock') then
        LockFrames();
    end
end

--[[
	Fires when the Addon is Initialised.
	
    @ return void
]]
function ImpUI:OnInitialize()
    -- Set up Improved Blizzard UI font.
    LSM:Register(LSM.MediaType.FONT, 'Improved Blizzard UI', [[Interface\AddOns\ImprovedBlizzardUI_Classic\media\ImprovedBlizzardUI.ttf]]);

    -- Set up DB
    self.db = LibStub('AceDB-3.0'):New('ImpUI_DB', ImpUI_Config.defaults, true);

    -- Register Config
    LibStub('AceConfig-3.0'):RegisterOptionsTable('ImprovedBlizzardUI_Classic', ImpUI_Config.options);

    -- Add to Blizz Config
    self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('ImprovedBlizzardUI_Classic', 'Improved Blizzard UI');

    -- Register Slash Command
    self:RegisterChatCommand('imp', 'HandleSlash');

    -- Finally print Intialized Message.
    print('|cffffff00Improved Blizzard UI (Classic Edition) - ' .. GetAddOnMetadata('ImprovedBlizzardUI_Classic', 'Version') .. ' Initialized.');
end