-- Get Localisation
local L = LibStub('AceLocale-3.0'):GetLocale('ImprovedBlizzardUI_Classic');

ImpUI_Config = {};

--[[
	Defaults for every new character.
]]
ImpUI_Config.defaults = {
    char = {
        primaryInterfaceFont = 'Improved Blizzard UI',
        afkMode = true,
        autoRepair = true,
        autoSell = true,
        minifyStrings = true,
        hideChatButtons = true,
        styleChat = true,
        chatFont = 'Improved Blizzard UI',
        outlineChat = true,
        healthWarnings = true,
        healthWarningFont = 'Improved Blizzard UI',
        healthWarningSize = 26,
        healthWarningHalfColour = Helpers.colour_pack(0, 1, 1, 1),
        healthWarningQuarterColour = Helpers.colour_pack(1, 0, 0, 1),
        announceInterrupts = true,
        interruptChannel = 1,
        killingBlows = true,
        killingBlowMessage = L['Killing Blow!'],
        killingBlowColour = Helpers.colour_pack(1, 1, 0, 1),
        killingBlowSize = 26,
        killingBlowFont = 'Improved Blizzard UI',
        killingBlowInWorld = false,
        killingBlowInPvP = true,
        killingBlowInInstance = false,
        killingBlowInRaid = false,

        autoRel = true,
        autoRelInWorld = false,
        autoRelInInstance = false,
        autoRelInPvP = true,
        autoRelInRaid = false,

        showCoords = true,
        minimapCoordsFont = 'Improved Blizzard UI',
        minimapCoordsColour = Helpers.colour_pack(1, 1, 0, 1),
        minimapCoordsSize = 13,
        minimapZoneTextFont = 'Improved Blizzard UI',
        minimapZoneTextSize = 13,
        minimapClockFont = 'Improved Blizzard UI',
        minimapClockSize = 10,

        performanceFrame = true,
        performanceFrameSize = 14,

        osdPosition = Helpers.pack_position('CENTER', nil, 'CENTER', 0, 72),
        killFeedPosition = Helpers.pack_position('TOPLEFT', nil, 'TOPLEFT', 8.33, -5),

        styleUnitFrames = true,
        
        playerFrameScale = 1.1,
        playerFramePosition = Helpers.pack_position('CENTER', nil, 'CENTER', -305.16, -160.82),
        playerClassColours = true,
        playerHidePortraitSpam = true,
        playerHideOOC = true,

        targetFrameScale = 1.1,
        targetFramePosition = Helpers.pack_position('CENTER', nil, 'CENTER', 305.16, -160.82),
        targetClassColours = true,
        targetBuffsOnTop = true,
        targetOfTargetClassColours = true,

        partyFrameScale = 1.2,
        partyFramePosition = Helpers.pack_position('CENTER', nil, 'CENTER', -550, 100),

        killFeed = true,
        killFeedFont = 'Improved Blizzard UI',
        killFeedSize = 17,
        killFeedSpacing = 26,
        killFeedInWorld = false,
        killFeedInInstance = true,
        killFeedInRaid = true,
        killFeedInPvP = true,
        killFeedShowSpell = true,
        killFeedShowDamage = true,
        killFeedFadeInactive = true,

        anchorMouse = true,
        styleTooltips = true,
        tooltipGuildColour = Helpers.colour_pack(1, 0.529, 1, 1),
        tooltipHostileBorder = true,
        tooltipNameClassColours = true,
        tooltipToT = true,
        tooltipHealthClassColours = true,
        tooltipItemRarity = true,

        castBarScale = 1.0,
        castBarPosition = Helpers.pack_position('CENTER', nil, 'CENTER', 0, -175);
        castBarPlayerTimer = true,
        castBarTargetTimer = true,
        castBarFontSize = 13,

        buffsPosition = Helpers.pack_position('TOPRIGHT', nil, 'TOPRIGHT', -200, -25),
        buffsScale = 1.1;
    },
};

--[[
	Configuration Menu.
]]
ImpUI_Config.options = {
    name = 'Improved Blizzard UI - '..GetAddOnMetadata('ImprovedBlizzardUI_Classic', 'Version'),
    handler = ImpUI,
    type = 'group',
    childGroups = "tab",
    args = {
        -- Unit Frames
        unitframes = {
            name = L['Unit Frames'],
            desc = L['Unit Frames'],
            type = 'group',
            order = 1,
            args = {
                styleUnitFrames = {
                    type = 'toggle',
                    name = L['Style Unit Frames'],
                    desc = L['Applies modified textures and font styling to the Player, Target and Party Frames. This will trigger a UI Reload!'],
                    get = function ()
                        return ImpUI.db.char.styleUnitFrames;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.styleUnitFrames = newValue;
                        ReloadUI();
                    end,
                    order = 1,
                },

                -- Player Frame Section
                playerHeader = {
                    type = 'header',
                    name = L['Player Frame'],
                    order = 2,
                },

                playerClassColours = {
                    type = 'toggle',
                    name = L['Display Class Colours'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.playerClassColours;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.playerClassColours = newValue;
                        ImpUI_Player:ToggleClassColours(newValue);
                    end,
                    order = 3,
                },

                playerHidePortraitSpam = {
                    type = 'toggle',
                    name = L['Hide Portrait Spam'],
                    desc = L['Hides the damage text that appears over the Player portrait when damaged or healed.'],
                    get = function ()
                        return ImpUI.db.char.playerHidePortraitSpam;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.playerHidePortraitSpam = newValue;
                    end,
                    order = 4,
                },

                playerHideOOC = {
                    type = 'toggle',
                    name = L['Hide Out of Combat'],
                    desc = L['Hides the Player Frame when you are out of combat, have no target and are at full health.'],
                    get = function ()
                        return ImpUI.db.char.playerHideOOC;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.playerHideOOC = newValue;

                        ImpUI_Player:TogglePlayer(newValue);
                    end,
                    order = 5,
                },

                playerFrameScale = {
                    type = 'range',
                    name = L['Player Frame Scale'],
                    desc = '',
                    min = 0.1,
                    max = 4.0,
                    step = 0.1,
                    get = function ()
                        return ImpUI.db.char.playerFrameScale;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.playerFrameScale = newValue; 

                        ImpUI_Player:LoadPosition();
                    end,
                    isPercent = false,
                    order = 6,
                },

                -- Target Frame Section
                targetHeader = {
                    type = 'header',
                    name = L['Target Frame'],
                    order = 7,
                },

                targetClassColours = {
                    type = 'toggle',
                    name = L['Display Class Colours'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.targetClassColours;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.targetClassColours = newValue;
                        TargetFrame:Hide();
                    end,
                    order = 8,
                },

                targetBuffsOnTop = {
                    type = 'toggle',
                    name = L['Buffs On Top'],
                    desc = L['Displays the Targets Buffs above the Unit Frame.'],
                    get = function ()
                        return ImpUI.db.char.targetBuffsOnTop;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.targetBuffsOnTop = newValue;
                        TargetFrame:Hide();
                    end,
                    order = 9,
                },

                targetOfTargetClassColours = {
                    type = 'toggle',
                    name = L['ToT Class Colours'],
                    desc = L['Colours Target of Target Health bar to match their class.'],
                    get = function ()
                        return ImpUI.db.char.targetOfTargetClassColours;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.targetOfTargetClassColours = newValue;
                        TargetFrame:Hide();
                    end,
                    order = 10,
                },

                targetFrameScale = {
                    type = 'range',
                    name = L['Target Frame Scale'],
                    desc = '',
                    min = 0.1,
                    max = 4.0,
                    step = 0.1,
                    get = function ()
                        return ImpUI.db.char.targetFrameScale;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.targetFrameScale = newValue; 

                        ImpUI_Target:LoadPosition();
                    end,
                    isPercent = false,
                    order = 6,
                },

                -- Party Frames Section
                partyHeader = {
                    type = 'header',
                    name = L['Party Frames'],
                    order = 11,
                },

                partyFrameScale = {
                    type = 'range',
                    name = L['Party Frame Scale'],
                    desc = '',
                    min = 0.1,
                    max = 4.0,
                    step = 0.1,
                    get = function ()
                        return ImpUI.db.char.partyFrameScale;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.partyFrameScale = newValue; 

                        ImpUI_Party:LoadPosition();
                    end,
                    isPercent = false,
                    order = 12,
                },
            }
        },

        -- Action Bars
        actionbars = {
            name = L['Bars'],
            desc = L['Bars'],
            type = 'group',
            order = 2,
            args = {
                -- Casting Bar Section
                castBarHeader = {
                    type = 'header',
                    name = L['Cast Bar'],
                    order = 1,
                },

                castBarScale = {
                    type = 'range',
                    name = L['Scale'],
                    desc = '',
                    min = 0.1,
                    max = 4.0,
                    step = 0.1,
                    get = function ()
                        return ImpUI.db.char.castBarScale;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.castBarScale = newValue; 

                        ImpUI_CastBar:LoadPosition();
                    end,
                    isPercent = false,
                    order = 2,
                },

                castBarFontSize = {
                    type = 'range',
                    name = L['Font Size'],
                    desc = '',
                    min = 4,
                    max = 32,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.castBarFontSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.castBarFontSize = newValue; 

                        ImpUI_CastBar:StyleFrame();
                    end,
                    isPercent = false,
                    order = 3,
                },

                castBarPlayerTimer = {
                    type = 'toggle',
                    name = L['Player Cast Timer'],
                    desc = L['Displays a Timer on the Players Cast Bar.'],
                    get = function ()
                        return ImpUI.db.char.castBarPlayerTimer;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.castBarPlayerTimer = newValue;

                        ImpUI_CastBar:StyleFrame();
                    end,
                    order = 4,
                },

                -- Buff Bar Section
                buffBarHeader = {
                    type = 'header',
                    name = L['Buffs & Debuffs'],
                    order = 7,
                },

                buffsScale = {
                    type = 'range',
                    name = L['Scale'],
                    desc = '',
                    min = 0.1,
                    max = 4.0,
                    step = 0.1,
                    get = function ()
                        return ImpUI.db.char.buffsScale;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.buffsScale = newValue; 

                        ImpUI_Buffs:LoadPosition();
                    end,
                    isPercent = false,
                    order = 8,
                },
            }
        },

        -- Tooltips
        tooltips = {
            name = L['Tooltips'],
            desc = L['Tooltips'],
            type = 'group',
            order = 3,
            args = {
                anchorMouse = {
                    type = 'toggle',
                    name = L['Anchor To Mouse'],
                    desc = L['The tooltip will always display at the mouse location.'],
                    get = function ()
                        return ImpUI.db.char.anchorMouse;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.anchorMouse = newValue;
                    end,
                    order = 1,
                },

                styleTooltips = {
                    type = 'toggle',
                    name = L['Style Tooltips'],
                    desc = L['Adjusts the information and style of the default tooltips.'],
                    get = function ()
                        return ImpUI.db.char.styleTooltips;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.styleTooltips = newValue;
                        ImpUI_Tooltips:ResetStyle();
                    end,
                    order = 2,
                },

                tooltipGuildColour = {
                    type = 'color',
                    name = L['Guild Colour'],
                    desc = L['The colour of the guild name display in tooltips.'],
                    get = function ()
                        return Helpers.colour_unpack(ImpUI.db.char.tooltipGuildColour);
                    end,
                    set = function (_, r, g, b, a)
                        ImpUI.db.char.tooltipGuildColour = Helpers.colour_pack(r, g, b, a);
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleTooltips == false;
                    end,
                    hasAlpha = false,
                    order = 3,
                },

                tooltipHostileBorder = {
                    type = 'toggle',
                    name = L['Hostile Border'],
                    desc = L['Colours the border of the tooltip based on the hostility of the target.'],
                    get = function ()
                        return ImpUI.db.char.tooltipHostileBorder;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.tooltipHostileBorder = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleTooltips == false;
                    end,
                    order = 4,
                },

                tooltipNameClassColours = {
                    type = 'toggle',
                    name = L['Class Coloured Name'],
                    desc = L['Colours the name of the target to match their Class.'],
                    get = function ()
                        return ImpUI.db.char.tooltipNameClassColours;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.tooltipNameClassColours = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleTooltips == false;
                    end,
                    order = 5,
                },

                tooltipToT = {
                    type = 'toggle',
                    name = L['Show Target of Target'],
                    desc = L['Displays who / what the unit is targeting. Coloured by Class.'],
                    get = function ()
                        return ImpUI.db.char.tooltipToT;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.tooltipToT = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleTooltips == false;
                    end,
                    order = 6,
                },

                tooltipHealthClassColours = {
                    type = 'toggle',
                    name = L['Class Colour Health Bar'],
                    desc = L['Colours the Tooltip Health Bar by Class.'],
                    get = function ()
                        return ImpUI.db.char.tooltipHealthClassColours;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.tooltipHealthClassColours = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleTooltips == false;
                    end,
                    order = 6,
                },

                tooltipItemRarity = {
                    type = 'toggle',
                    name = L['Item Rarity Border'],
                    desc = L['Colours the tooltip border by the rarity of the item you are inspecting.'],
                    get = function ()
                        return ImpUI.db.char.tooltipItemRarity;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.tooltipItemRarity = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleTooltips == false;
                    end,
                    order = 7,
                },
            }
        },

        -- Combat
        combat = {
            name = L['Combat'],
            desc = L['Combat'],
            type = 'group',
            order = 4,
            args = {
                -- Health Warning Section
                healthHeader = {
                    type = 'header',
                    name = L['Health Warning'],
                    order = 1,
                },

                healthWarnings = {
                    type = 'toggle',
                    name = L['Health Warnings'],
                    desc = L['Displays a five second warning when Player Health is less than 50% and 25%.'],
                    get = function ()
                        return ImpUI.db.char.healthWarnings;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.healthWarnings = newValue;
                    end,
                    order = 2,
                },

                healthWarningHalfColour = {
                    type = 'color',
                    name = L['50% Colour'],
                    desc = L['The colour of the warning that displays at 50% health.'],
                    get = function ()
                        return Helpers.colour_unpack(ImpUI.db.char.healthWarningHalfColour);
                    end,
                    set = function (_, r, g, b, a)
                        ImpUI.db.char.healthWarningHalfColour = Helpers.colour_pack(r, g, b, a);
                    end,
                    disabled = function () 
                        return ImpUI.db.char.healthWarnings == false;
                    end,
                    hasAlpha = false,
                    order = 3,
                },

                healthWarningQuarterColour = {
                    type = 'color',
                    name = L['25% Colour'],
                    desc = L['The colour of the warning that displays at 25% health.'],
                    get = function ()
                        return Helpers.colour_unpack(ImpUI.db.char.healthWarningQuarterColour);
                    end,
                    set = function (_, r, g, b, a)
                        ImpUI.db.char.healthWarningQuarterColour = Helpers.colour_pack(r, g, b, a);
                    end,
                    disabled = function () 
                        return ImpUI.db.char.healthWarnings == false;
                    end,
                    hasAlpha = false,
                    order = 4,
                },

                healthWarningSize = {
                    type = 'range',
                    name = L['Health Warning Size'],
                    desc = L['The size of the Health Warning Display.'],
                    min = 8,
                    max = 104,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.healthWarningSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.healthWarningSize = newValue; 
                    end,
                    disabled = function () 
                        return ImpUI.db.char.healthWarnings == false;
                    end,
                    isPercent = false,
                    order = 5,
                },

                healthWarningFont = {
                    type = 'select',
                    name = L['Health Warning Font'],
                    desc = L['The font used by the Health Warning On Screen Display Message'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.healthWarningFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.healthWarningFont = newValue; 
                    end,
                    disabled = function () 
                        return ImpUI.db.char.healthWarnings == false;
                    end,
                    order = 6,
                },

                -- Interrupts Section
                interruptHeader = {
                    type = 'header',
                    name = L['Interrupts'],
                    order = 7,
                },

                announceInterrupts = {
                    type = 'toggle',
                    name = L['Announce Interrupts'],
                    desc = L['When you interrupt a target your character announces this to an appropriate sound channel.'],
                    get = function ()
                        return ImpUI.db.char.announceInterrupts;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.announceInterrupts = newValue; 
                    end,
                    order = 8,
                },

                interruptChannel = {
                    type = 'select',
                    name = L['Chat Channel'],
                    desc = L['The Channel that should be used when announcing an interrupt. Auto intelligently chooses based on situation.'],
                    get = function ()
                        return ImpUI.db.char.interruptChannel;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.interruptChannel = newValue; 
                    end,
                    style = 'dropdown',
                    values = {
                        'Auto',
                        'Say',
                        'Yell',
                    },
                    disabled = function () 
                        return ImpUI.db.char.announceInterrupts == false;
                    end,
                    order = 9,
                },

                -- Killing Blows Section
                killingBlowsHeader = {
                    type = 'header',
                    name = L['Killing Blows'],
                    order = 10,
                },

                killingBlows = {
                    type = 'toggle',
                    name = L['Highlight Killing Blows'],
                    desc = L['When you get a Killing Blow this will be displayed prominently in the center of the screen.'],
                    get = function ()
                        return ImpUI.db.char.killingBlows;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlows = newValue; 
                    end,
                    order = 11,
                },

                killingBlowMessage = {
                    type = 'input',
                    name = L['Killing Blow Message'],
                    desc = L['The message that is displayed in the center of the screen.'],
                    get = function ()
                        return ImpUI.db.char.killingBlowMessage;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlowMessage = newValue; 
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    order = 12,
                },

                killingBlowColour = {
                    type = 'color',
                    name = L['Colour'],
                    desc = L['The colour of the Killing Blow notification.'],
                    get = function ()
                        return Helpers.colour_unpack(ImpUI.db.char.killingBlowColour);
                    end,
                    set = function (_, r, g, b, a)
                        ImpUI.db.char.killingBlowColour = Helpers.colour_pack(r, g, b, a);
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    hasAlpha = false,
                    order = 13,
                },

                killingBlowSize = {
                    type = 'range',
                    name = L['Killing Blow Size'],
                    desc = L['The size of the Killing Blow notification'],
                    min = 8,
                    max = 104,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.killingBlowSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlowSize = newValue; 
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    isPercent = false,
                    order = 14,
                },

                killingBlowFont = {
                    type = 'select',
                    name = L['Killing Blow Font'],
                    desc = L['The font used by the Killing Blow Notification.'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.killingBlowFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlowFont = newValue; 
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    order = 15,
                },

                killingBlowInWorld = {
                    type = 'toggle',
                    name = L['In World'],
                    desc = L['Notification will display in World content.'],
                    get = function ()
                        return ImpUI.db.char.killingBlowInWorld;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlowInWorld = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    order = 16,
                },

                killingBlowInPvP = {
                    type = 'toggle',
                    name = L['In PvP'],
                    desc = L['Notification will display in PvP content.'],
                    get = function ()
                        return ImpUI.db.char.killingBlowInPvP;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlowInPvP = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    order = 17,
                },

                killingBlowInInstance = {
                    type = 'toggle',
                    name = L['In Instance'],
                    desc = L['Notification will display in 5 Man instanced content.'],
                    get = function ()
                        return ImpUI.db.char.killingBlowInInstance;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlowInInstance = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    order = 18,
                },

                killingBlowInRaid = {
                    type = 'toggle',
                    name = L['In Raid'],
                    desc = L['Notification will display in instanced raid content.'],
                    get = function ()
                        return ImpUI.db.char.killingBlowInRaid;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killingBlowInRaid = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killingBlows == false;
                    end,
                    order = 19,
                },

                -- Automatic Ressurection Section
                autoRelHeader = {
                    type = 'header',
                    name = L['Automatic Release'],
                    order = 20,
                },

                autoRel = {
                    type = 'toggle',
                    name = L['Automatic Release'],
                    desc = L['Automatically release your spirit when you die.'] ,
                    get = function ()
                        return ImpUI.db.char.autoRel;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.autoRel = newValue;
                    end,
                    order = 21,
                },

                autoRelInWorld = {
                    type = 'toggle',
                    name = L['In World'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.autoRelInWorld;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.autoRelInWorld = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.autoRel == false;
                    end,
                    order = 22,
                },

                autoRelInInstance = {
                    type = 'toggle',
                    name = L['In Instance'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.autoRelInInstance;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.autoRelInInstance = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.autoRel == false;
                    end,
                    order = 23,
                },

                autoRelInPvP = {
                    type = 'toggle',
                    name = L['In PvP'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.autoRelInPvP;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.autoRelInPvP = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.autoRel == false;
                    end,
                    order = 23,
                },

                autoRelInRaid = {
                    type = 'toggle',
                    name = L['In Raid'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.autoRelInRaid;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.autoRelInRaid = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.autoRel == false;
                    end,
                    order = 24,
                }
            }
        },

        -- Maps
        maps = {
            name = L['Maps'],
            desc = L['Maps'],
            type = 'group',
            order = 5,
            args = {
                -- Minimap Section
                minimap = {
                    type = 'header',
                    name = L['Mini Map'],
                    order = 1,
                },

                showCoords = {
                    type = 'toggle',
                    name = L['Player Co-ordinates'],
                    desc = L['Adds a frame to the Mini Map showing the players location in the world. Does not work in Dungeons.'],
                    get = function ()
                        return ImpUI.db.char.showCoords;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.showCoords = newValue;
                    end,
                    order = 2,
                },

                minimapCoordsFont = {
                    type = 'select',
                    name = L['Co-ordinates Font'],
                    desc = L['The font used by the Minimap Co-ordinates Display.'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.minimapCoordsFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.minimapCoordsFont = newValue;
                        ImpUI_MiniMap:StyleCoords();
                    end,
                    disabled = function () 
                        return ImpUI.db.char.showCoords == false;
                    end,
                    order = 3,
                },

                minimapCoordsColour = {
                    type = 'color',
                    name = L['Colour'],
                    desc = L['The colour of the Minimap Co-ordinates Display.'],
                    get = function ()
                        return Helpers.colour_unpack(ImpUI.db.char.minimapCoordsColour);
                    end,
                    set = function (_, r, g, b, a)
                        ImpUI.db.char.minimapCoordsColour = Helpers.colour_pack(r, g, b, a);
                        ImpUI_MiniMap:StyleCoords();
                    end,
                    disabled = function () 
                        return ImpUI.db.char.showCoords == false;
                    end,
                    hasAlpha = false,
                    order = 4,
                },

                minimapCoordsSize = {
                    type = 'range',
                    name = L['Co-ordinates Size'],
                    desc = L['The size of the Minimap Co-ordinates Display.'],
                    min = 8,
                    max = 26,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.minimapCoordsSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.minimapCoordsSize = newValue;
                        ImpUI_MiniMap:StyleCoords();
                    end,
                    disabled = function () 
                        return ImpUI.db.char.showCoords == false;
                    end,
                    isPercent = false,
                    order = 5,
                },

                minimapZoneTextFont = {
                    type = 'select',
                    name = L['Zone Text Font'],
                    desc = L['The font used by the Minimap Zone Display'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.minimapZoneTextFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.minimapZoneTextFont = newValue;
                        ImpUI_MiniMap:StyleMap();
                    end,
                    order = 6,
                },

                minimapZoneTextSize = {
                    type = 'range',
                    name = L['Zone Text Size'],
                    desc = L['The size of the Minimap Zone Text Display.'],
                    min = 8,
                    max = 26,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.minimapZoneTextSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.minimapZoneTextSize = newValue;
                        ImpUI_MiniMap:StyleMap();
                    end,
                    isPercent = false,
                    order = 7,
                },

                minimapClockFont = {
                    type = 'select',
                    name = L['Clock Font'],
                    desc = L['The font used by the Minimap Clock Display'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.minimapClockFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.minimapClockFont = newValue;
                        ImpUI_MiniMap:StyleClock();
                    end,
                    order = 8,
                },

                minimapClockSize = {
                    type = 'range',
                    name = L['Clock Text Size'],
                    desc = L['The size of the Minimap Clock Display.'],
                    min = 4,
                    max = 22,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.minimapClockSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.minimapClockSize = newValue;
                        ImpUI_MiniMap:StyleClock();
                    end,
                    isPercent = false,
                    order = 9,
                },

                -- World Map Section
                worldmap = {
                    type = 'header',
                    name = L['World Map'],
                    order = 10,
                },
            }
        },

        -- Miscellaneous
        misc = {
            name = L['Miscellaneous'],
            desc = L['Miscellaneous'],
            type = 'group',
            order = 6,
            args = {
                afkMode = {
                    type = 'toggle',
                    name = L['Enable AFK Mode'],
                    desc = L['After you go AFK the interface will fade away, pan your camera and display your Character in all their glory.'],
                    get = function ()
                        return ImpUI.db.char.afkMode;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.afkMode = newValue;
                    end,
                    order = 1,
                },
                autoRepair = {
                    type = 'toggle',
                    name = L['Auto Repair'],
                    desc = L['Automatically repairs your armour when you visit a merchant that can repair.'],
                    get = function ()
                        return ImpUI.db.char.autoRepair;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.autoRepair = newValue;
                    end,
                    order = 2,
                },
                autoSell = {
                    type = 'toggle',
                    name = L['Auto Sell Trash'],
                    desc = L['Automatically sells any grey items that are in your inventory.'],
                    get = function ()
                        return ImpUI.db.char.autoSell;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.autoSell = newValue;
                    end,
                    order = 4,
                },

                -- Chat Section
                chatHeader = {
                    type = 'header',
                    name = L['Chat'],
                    order = 6,
                },

                
                hideChatButtons = {
                    type = 'toggle',
                    name = L['Hide Chat Buttons'],
                    desc = L['Hide the buttons on the side of the chat box such as the up and down arrows, and the social tab button.'],
                    get = function ()
                        return ImpUI.db.char.hideChatButtons;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.hideChatButtons = newValue;

                        if (newValue == true) then
                            ImpUI_Chat:HideChatButtons();
                        else
                            ImpUI_Chat:ResetChatButtons();
                        end
                    end,
                    order = 7,
                },

                minifyStrings = {
                    type = 'toggle',
                    name = L['Minify Blizzard Strings'],
                    desc = L['Shortens chat messages such as Loot Received, Exp Gain, Skill Gain and Chat Channels.'],
                    get = function ()
                        return ImpUI.db.char.minifyStrings;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.minifyStrings = newValue;

                        if (newValue == true) then
                            ImpUI_Chat:RestoreStrings();
                            ImpUI_Chat:OverrideStrings();
                        else
                            ImpUI_Chat:RestoreStrings();
                        end
                    end,
                    order = 8,
                },

                styleChat = {
                    type = 'toggle',
                    name = L['Style Chat'],
                    desc = L['Styles the Blizzard Chat frame to better match the rest of the UI.'],
                    get = function ()
                        return ImpUI.db.char.styleChat;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.styleChat = newValue;

                        if (newValue == true) then
                            ImpUI_Chat:StyleChat();
                        else
                            ImpUI_Chat:ResetChat();
                        end
                    end,
                    order = 9,
                },

                chatFont = {
                    type = 'select',
                    name = L['Chat Font'],
                    desc = L['Sets the font used for the chat window, tabs etc.'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.chatFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.chatFont = newValue;
                        ImpUI_Chat:StyleChat();
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleChat == false;
                    end,
                    order = 10,
                },

                outlineChat = {
                    type = 'toggle',
                    name = L['Outline Font'],
                    desc = L['Applies a thin outline to text rendered in the chat windows.'],
                    get = function ()
                        return ImpUI.db.char.outlineChat;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.outlineChat = newValue;
                        ImpUI_Chat:StyleChat();
                    end,
                    disabled = function () 
                        return ImpUI.db.char.styleChat == false;
                    end,
                    order = 10,
                },

                primaryInterfaceFontHeader = {
                    type = 'header',
                    name = L['Primary Interface Font'],
                    order = 12,
                },

                primaryInterfaceFont = {
                    type = 'select',
                    name = L['Primary Interface Font'],
                    desc = L['Replaces almost every font in the Blizzard UI to this selection. This is a broad pass.'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.primaryInterfaceFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.primaryInterfaceFont = newValue;
                        ImpUI_Fonts:PrimaryFontUpdated();
                        ImpUI_Performance:StylePerformanceFrame();
                        ImpUI_Player:StyleFrame();
                        ImpUI_OrderHall:StyleFrame();
                        ImpUI_CastBar:StyleFrame();
                    end,
                    order = 13,
                },

                performanceHeader = {
                    type = 'header',
                    name = L['System Statistics'],
                    order = 14,
                },

                performanceFrame = {
                    type = 'toggle',
                    name = L['Display System Statistics'],
                    desc = L['Displays FPS and Latency above the Mini Map.'],
                    get = function ()
                        return ImpUI.db.char.performanceFrame;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.performanceFrame = newValue;
                        ImpUI_MiniMap:StyleMap();
                    end,
                    order = 15,
                },

                performanceFrameSize = {
                    type = 'range',
                    name = L['System Statistics Size'],
                    desc = L['The size of the system statistics display.'],
                    min = 4,
                    max = 23,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.performanceFrameSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.performanceFrameSize = newValue;
                        ImpUI_Performance:StylePerformanceFrame();
                    end,
                    isPercent = false,
                    order = 16,
                },

                killFeedHeader = {
                    type = 'header',
                    name = L['Kill Feed'],
                    order = 17,
                },

                killFeed = {
                    type = 'toggle',
                    name = L['Enable Kill Feed'],
                    desc = L['Displays a feed of the last 5 kills that occur around you.'],
                    get = function ()
                        return ImpUI.db.char.killFeed;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeed = newValue;
                    end,
                    order = 18,
                },

                killFeedFont = {
                    type = 'select',
                    name = L['Kill Feed Font'],
                    desc = L['The font used for the Kill Feed.'],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable( LSM.MediaType.FONT ),
                    get = function ()
                        return ImpUI.db.char.killFeedFont;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedFont = newValue;
                        ImpUI_Killfeed:StyleKillFeed();
                    end,
                    disabled = function ()
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 19,
                },

                killFeedSize = {
                    type = 'range',
                    name = L['Text Size'],
                    desc = L['The font size used for the Kill Feed.'],
                    min = 4,
                    max = 52,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.killFeedSize;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedSize = newValue;
                        ImpUI_Killfeed:StyleKillFeed();
                    end,
                    disabled = function ()
                        return ImpUI.db.char.killFeed == false;
                    end,
                    isPercent = false,
                    order = 20,
                },

                killFeedSpacing = {
                    type = 'range',
                    name = L['Spacing'],
                    desc = L['The vertical spacing between each row of the Kill Feed.'],
                    min = 4,
                    max = 52,
                    step = 1,
                    get = function ()
                        return ImpUI.db.char.killFeedSpacing;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedSpacing = newValue;
                        ImpUI_Killfeed:StyleKillFeed();
                    end,
                    disabled = function ()
                        return ImpUI.db.char.killFeed == false;
                    end,
                    isPercent = false,
                    order = 21,
                },

                killFeedShowSpell = {
                    type = 'toggle',
                    name = L['Show Casted Spell'],
                    desc = L['Show the Spell that caused a death.'],
                    get = function ()
                        return ImpUI.db.char.killFeedShowSpell;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedShowSpell = newValue;
                    end,
                    disabled = function ()
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 22,
                },

                killFeedShowDamage = {
                    type = 'toggle',
                    name = L['Show Damage'],
                    desc = L['Show how much damage the Creature or Player took.'],
                    get = function ()
                        return ImpUI.db.char.killFeedShowDamage;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedShowDamage = newValue;
                    end,
                    disabled = function ()
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 23,
                },

                killFeedFadeInactive = {
                    type = 'toggle',
                    name = L['Hide When Inactive'],
                    desc = L['Hides the Kill Feed after no new events have occured for a short period.'],
                    get = function ()
                        return ImpUI.db.char.killFeedFadeInactive;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedFadeInactive = newValue;
                    end,
                    disabled = function ()
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 24,
                },

                killFeedInWorld = {
                    type = 'toggle',
                    name = L['In World'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.killFeedInWorld;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedInWorld = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 25,
                },

                killFeedInInstance = {
                    type = 'toggle',
                    name = L['In Instance'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.killFeedInInstance;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedInInstance = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 26,
                },

                killFeedInPvP = {
                    type = 'toggle',
                    name = L['In PvP'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.killFeedInPvP;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedInPvP = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 27,
                },

                killFeedInRaid = {
                    type = 'toggle',
                    name = L['In Raid'],
                    desc = '',
                    get = function ()
                        return ImpUI.db.char.killFeedInRaid;
                    end,
                    set = function (info, newValue)
                        ImpUI.db.char.killFeedInRaid = newValue;
                    end,
                    disabled = function () 
                        return ImpUI.db.char.killFeed == false;
                    end,
                    order = 28,
                }
            }
        },
    }
};