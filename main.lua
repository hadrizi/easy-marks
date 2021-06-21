local buttons = {}
local main_frame_w = 1
local main_frame_h = 40

local btn_w = 30
local btn_h = 30

local function create_main_frame()
    local f = CreateFrame("Frame", "MainFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    -- The code below makes the frame visible, and is not necessary to enable dragging.
    f:SetPoint("TOP")
    f:SetSize(main_frame_w, main_frame_h)
    f:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    f:SetBackdropColor(0, 0, 0, 255)

    return f
end

-- Macros:
-- Skull - /script SetRaidTarget("target", 8)
-- X - /script SetRaidTarget("target", 7)
-- Square - /script SetRaidTarget("target", 6)
-- Moon - /script SetRaidTarget("target", 5)
-- Triangle - /script SetRaidTarget("target", 4)
-- Diamond - /script SetRaidTarget("target", 3)
-- Circle - /script SetRaidTarget("target", 2)
-- Star - /script SetRaidTarget("target", 1)
local function add_raid_button_to_frame(frame)
    local n = table.getn(buttons)
    
    local btn = CreateFrame("Button", 
        "btn_" .. tostring(n+1), 
        frame, 
        "UIPanelButtonTemplate" and BackdropTemplateMixin and "BackdropTemplate", 
        0
    )
    btn:SetSize(btn_w, btn_h)

    btn:SetPoint("LEFT", btn:GetParent(), "LEFT", frame:GetWidth(), 0)
    btn:SetBackdrop({
        bgFile = "Interface/TARGETINGFRAME/UI-RaidTargetingIcon_" .. tostring(n+1),
        -- edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })

    btn:SetBackdropBorderColor(.5, .5, .5)
    -- btn:SetHighlightTexture("Interface/Buttons/UI-Panel-Button-Highlight2")
    btn:RegisterForClicks("AnyUp")
    btn:SetScript("OnClick", function (self, button, down)
        SetRaidTarget("target", n+1)
    end)

    -- btn:SetNormalTexture("Interface/TARGETINGFRAME/UI-RaidTargetingIcon_" .. tostring(n+1))
    local new_frame_width = frame:GetWidth() + btn:GetWidth() + main_frame_w
    frame:SetWidth(new_frame_width)
    buttons[n+1] = btn
end

local function add_remove_button_to_frame(frame)
    local n = table.getn(buttons)
    
    local btn = CreateFrame(
        "Button", 
        "btn_" .. tostring(n+1), 
        frame, 
        "UIPanelButtonTemplate",
        0
    )
    -- btn:SetAllPoints()
    btn:SetSize(btn_w, btn_h)

    btn:SetPoint("LEFT", btn:GetParent(), "LEFT", frame:GetWidth(), 0)
    -- btn:SetBackdrop({
    --     bgFile = "Interface/Buttons/CancelButton-Up",
    --     -- edgeFile = "Interface/Buttons/UI-Button-Borders",
    --     edgeSize = 16,
    --     insets = { left = 4, right = 4, top = 4, bottom = 4 },
    -- })
    -- btn:SetPushedTexture("Interface/Buttons/CancelButton-Down")
    -- btn:SetHighlightTexture("Interface/Buttons/CancelButton-Highlight")
    -- btn:SetNormalTexture("Interface/Buttons/CancelButton-Up")
    btn:SetText("R")
    btn:RegisterForClicks("AnyUp")
    btn:SetScript("OnClick", function (self, button, down)
        SetRaidTarget("target", 0)
    end)

    local new_frame_width = frame:GetWidth() + btn:GetWidth() + main_frame_w
    frame:SetWidth(new_frame_width)
    buttons[n+1] = btn
end

local function add_clean_button_to_frame(frame)
    local n = table.getn(buttons)
    
    local btn = CreateFrame("Button", "btn_" .. tostring(n+1), frame, "UIPanelButtonTemplate", 0)
    btn:SetSize(btn_w, btn_h)

    btn:SetPoint("LEFT", btn:GetParent(), "LEFT", frame:GetWidth(), 0)
    -- btn:SetBackdrop({
    --     bgFile = "Interface/Buttons/Arrow-Up-Down",
    --     edgeFile = "Interface/Buttons/UI-Button-Borders",
    --     edgeSize = 16,
    --     insets = { left = 4, right = 4, top = 4, bottom = 4 },
    -- })

    btn:SetText("С")
    btn:RegisterForClicks("AnyUp")
    btn:SetScript("OnClick", function (self, button, down)
        for i=n,0,-1 do
            SetRaidTarget("player", i)
        end
    end)

    local new_frame_width = frame:GetWidth() + btn:GetWidth() + main_frame_w
    frame:SetWidth(new_frame_width)
    buttons[n+1] = btn
end

local main_frame = create_main_frame()

local n = 8
for i=1,n,1 do
    add_raid_button_to_frame(main_frame)
end
add_remove_button_to_frame(main_frame)
add_clean_button_to_frame(main_frame)
