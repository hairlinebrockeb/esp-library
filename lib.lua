setthreadidentity(7)
-- insert troll face, memcorruptv2
local library = { 
	flags = { }, 
	items = { },
    configurations = {},
    __configurations = {};
} -- im black, i only like music with 808s or if its not rhymetic / memorable

setmetatable(library.configurations, {
    __index = function(table, key)
        --print(':@')
        --print(key)
        --print(library.__configurations[key], 'w')
        -- print(library.__configurations[key].value, 'r')
        if not library.__configurations[key] then 
            print('@configurations, no key associated')
            return
        end
        return library.__configurations[key].value
    end;
})  -- if library.configurations.
--[[
    setmetatable(library.configurations, library.__configurations)

    library.__configurations.__index = function(table, key)
        print(':@')
        print(key)
        print(__configurations[key], 'w')
        print(__configurations[key].value, 'r')
        if not __configurations[key] then 
            print('@configurations, no key associated')
            return
        end
        return __configurations[key].value
    end
]]
--[[
    :addtoggle('new toggle')
    if library.configurations.new_toggle then 

    else
        return print('toggle off')
    end 
]]
--local library = getgenv().library



local GAMENAME = nil;
pcall(function()
    GAMENAME = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)
--print('try gamename')
if not GAMENAME then 
    local repeatTried = tick()
    repeat 
        task.wait()
        pcall(function()
            GAMENAME = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        end)
    until GAMENAME or tick() - repeatTried >= 4
    if not GAMENAME and tick() - repeatTried >= 4 then 
        GAMENAME = 'UNABLE TO LOAD GAMENAME'
    end;
    --print(string.rep('gamename',1))
end

-- Services
local players = cloneref(game:GetService("Players"))
local uis = cloneref(game:GetService("UserInputService"))
local runservice = cloneref(game:GetService("RunService"))
local tweenservice = cloneref(game:GetService("TweenService"))
local marketplaceservice = cloneref(game:GetService("MarketplaceService"))
local textservice = cloneref(game:GetService("TextService"))
local coregui = cloneref(game:GetService("CoreGui"))
local httpservice = cloneref(game:GetService("HttpService"))

local player = cloneref(players.LocalPlayer)
local mouse = cloneref(player:GetMouse())
local camera = cloneref(game.Workspace.CurrentCamera)
-- if getgenv().disablefeatures then 
--     getgenv().disablelibrarything(); -- = true;
-- end
-- getgenv().unloadwindows = {running = true, trigger = false};
-- getgenv().unloadwindows.changed = function()
--     getgenv().unloadwindows.running = not getgenv().unloadwindows.running --b
-- end
local windowHash = httpservice:GenerateGUID(false)
getgenv().currentHash = windowHash; --unloadfunction = windowHash;
getgenv().disablefeatures =false
library.theme = {
    fontsize = 15,
    titlesize = 18,
    font = Enum.Font.Code,
    background = "rbxassetid://5553946656", -- rbxassetid://2454009026 5553946656
    tilesize = 500, -- 30
    cursor = false,
    cursorimg = "https://t0.rbxcdn.com/42f66da98c40252ee151326a82aab51f",
    backgroundcolor = Color3.fromRGB(20, 20, 20),
    tabstextcolor = Color3.fromRGB(240, 240, 240),
    bordercolor = Color3.fromRGB(60, 60, 60),
    accentcolor = Color3.fromRGB(28, 56, 139),
    accentcolor2 = Color3.fromRGB(16, 31, 78),
    outlinecolor = Color3.fromRGB(60, 60, 60),
    outlinecolor2 = Color3.fromRGB(0, 0, 0),
    sectorcolor = Color3.fromRGB(30, 30, 30),
    toptextcolor = Color3.fromRGB(255, 255, 255),
    topheight = 48,
    topcolor = Color3.fromRGB(30, 30, 30),
    topcolor2 = Color3.fromRGB(30, 30, 30),
    buttoncolor = Color3.fromRGB(49, 49, 49),
    buttoncolor2 = Color3.fromRGB(39, 39, 39),
    itemscolor = Color3.fromRGB(200, 200, 200),
    itemscolor2 = Color3.fromRGB(210, 210, 210)
}
library.defaulttheme = {
    fontsize = 15,
    titlesize = 18,
    font = Enum.Font.Code,
    background = "rbxassetid://5553946656", -- rbxassetid://2454009026 5553946656
    tilesize = 500, -- 30
    cursor = false,
    cursorimg = "https://t0.rbxcdn.com/42f66da98c40252ee151326a82aab51f",
    backgroundcolor = Color3.fromRGB(20, 20, 20),
    tabstextcolor = Color3.fromRGB(240, 240, 240),
    bordercolor = Color3.fromRGB(60, 60, 60),
    accentcolor = Color3.fromRGB(28, 56, 139),
    accentcolor2 = Color3.fromRGB(16, 31, 78),
    outlinecolor = Color3.fromRGB(60, 60, 60),
    outlinecolor2 = Color3.fromRGB(0, 0, 0),
    sectorcolor = Color3.fromRGB(30, 30, 30),
    toptextcolor = Color3.fromRGB(255, 255, 255),
    topheight = 48,
    topcolor = Color3.fromRGB(30, 30, 30),
    topcolor2 = Color3.fromRGB(30, 30, 30),
    buttoncolor = Color3.fromRGB(49, 49, 49),
    buttoncolor2 = Color3.fromRGB(39, 39, 39),
    itemscolor = Color3.fromRGB(200, 200, 200),
    itemscolor2 = Color3.fromRGB(210, 210, 210)
}

if library.theme.cursor and Drawing then
    local success = pcall(function() 
        library.cursor = Drawing.new("Image")
        library.cursor.Data = game:HttpGet(library.theme.cursorimg)
        library.cursor.Size = Vector2.new(64, 64)
        library.cursor.Visible = uis.MouseEnabled
        library.cursor.Rounding = 0
        library.cursor.Position = Vector2.new(mouse.X - 32, mouse.Y + 6)
    end)
    if success and library.cursor then
        uis.InputChanged:Connect(function(input)
            if uis.MouseEnabled then
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    library.cursor.Position = Vector2.new(input.Position.X - 32, input.Position.Y + 7)
                end
            end
        end)
        
        game:GetService("RunService").RenderStepped:Connect(function()
            uis.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
            library.cursor.Visible = uis.MouseEnabled and (uis.MouseIconEnabled or game:GetService("GuiService").MenuIsOpen)
        end)
    elseif not success and library.cursor then
        library.cursor:Remove()
    end
end

-- function library:OnUnload(toDisconnect)
--     -- :OnUnload = function
--     -- could run function
-- end
-- -- library.unloaded = function()
-- --     return 
-- -- end;
-- library.unloaded = {stablefunctions = {}};
-- hookfunction(getgenv().newchanged,function(...)
--     if b == true then 
--         for _, funct in next, library.unloaded.stablefunctions do 
--             task.spawn(funct); -- to
--         end
--     end
-- end)
-- library.unloaded.connect = function(to)
--     table.insert(library.unloaded.stablefunctions)
-- end;
-- library.unloaded.connect(function()
--     print('disabled','loop','unloaded')
-- end)
-- getgenv().unloadwindows = false;

-- library.OnUnload:Connect(function() toBreak = true; end)
--getgenv().disablelibrarything = library.OnUnload

function library:CheckForPermission(info)
    getgenv().disablefeatures = true
    local window = library.currentwindow
    local tab = nil;
    for i,v in pairs(window.Tabs) do
        if v.Left.Visible then
            tab = v
        end
    end
    if not window then return  end -- print('no window')
    local text = type(info) == 'string' and info or info and info.ask
    --print(text)
    if not text then return  end; -- print('no next given, '..tostring(text))
    local yesI = type(info) == 'table' and info and info.accept or 'Yes'
    local noI = type(info) == 'table' and info and info.reject or 'No'
    --print('asked')

    local cover = Instance.new('Frame')	
    --cover.Size = window.Frame.Size	
    cover.Size = UDim2.fromOffset(window.size.X.Offset, window.size.Y.Offset)
    if window.Frame:FindFirstChild('extraside') and window.Frame:FindFirstChild('extraside').Visible == true then 
        local xAddition = window.Frame:FindFirstChild('extraside').Size.X.Offset + 6
        cover.Size += UDim2.fromOffset(xAddition,0)
    end
    cover.Parent = window.Frame
    cover.Transparency = 0.2	
    cover.BackgroundColor3= Color3.fromRGB(10,10,10)	
    cover.ZIndex = 100


    local LinesNeededtoCreateNew = math.floor(window.Frame.Size.X.Offset / 2)--	15

    local function SubstitutionText()
        local text = info.ask
        for i=1,string.len(text) do 
            if i%LinesNeededtoCreateNew == 0 then 
                --info.ask = info.ask:sub() i wanted to get it and make a new line
                -- gonna have to find the 11th letter and make a new line there
                for x = 1,string.len(text) do 
                    if x == i then 
                        local restofit = text:sub(x+1,string.len(text))
                        text = text:sub(1,x)
                        text = text..'\n'
                        text = text..restofit
                    end
                end
            end
        end
        return text
    end
    local function perTextaddSpace()
    end

    -- print(typeof(tab.SectorsLeft))
    local changedstuff = {}

    local function changeTransparencies(info)
        if info.s == 'change' then 
            --print('change')
            local function dosamefor(ul)
                for _,v in next, ul do 
                    for itemI,item in next, v['Main']:GetChildren() do 
                        -- local hasBackgroundTransparency = false
                        -- hasBackgroundTransparency =  pcall(function() return item.BackgroundTransparency end)  
                        -- if hasBackgroundTransparency and item.BackgroundTransparency == 0 then 
                        --     print(item.Name)
                        --     table.insert(changedstuff,{
                        --         r = item;
                        --         previous = item.BackgroundTransparency
                        --     })
                        --     task.wait(.01)
                        --     item.BackgroundTransparency = .4
                        -- end
                       --item.Visible = false
                    end
                end
            end

            dosamefor(tab.SectorsLeft)
            dosamefor(tab.SectorsRight)
        elseif info.s == 'revert' then 
            local function dosamefor(ul)
                for _,v in next, ul do 
                    for itemI,item in next, v['Main']:GetChildren() do 
                        -- local hasBackgroundTransparency = false
                        -- hasBackgroundTransparency =  pcall(function() return item.BackgroundTransparency end)  
                        -- if hasBackgroundTransparency and item.BackgroundTransparency == 0 then 
                        --     print(item.Name)
                        --     table.insert(changedstuff,{
                        --         r = item;
                        --         previous = item.BackgroundTransparency
                        --     })
                        --     task.wait(.01)
                        --     item.BackgroundTransparency = .4
                        -- end
                        --item.Visible = true
                    end
                end
            end
            for i,v in next, library.items do 
                if v.Main and v.Main.Name == 'textbox' then 
                    v.Main.TextEditable = true;
                end
            end
            dosamefor(tab.SectorsLeft)
            dosamefor(tab.SectorsRight)
            -- for _Index,itemTable in next, changedstuff do 

            --     itemTable['r'].BackgroundTransparency = itemTable['previous']

            --     table.remove(changedstuff,_Index)
            -- end
        end 
    end

    for i,v in next, library.items do 
        if v.Main and v.Main.Name == 'textbox' then 
            v.Main.TextEditable = false;
        end
    end -- if getgenv().disablefeatures == true then return end
    changeTransparencies{s = 'change'}
    
    local label = {}
    label.Main = Instance.new("TextLabel", cover)
    label.Main.Name = "AskingLabel"
    label.Main.BackgroundTransparency = 1
    label.Main.Position = UDim2.new(0,cover.Size.X.Offset/2,0,cover.Size.Y.Offset/2-50)         -- 185   
    label.Main.ZIndex = 200
    label.Main.Font = window.theme.font
    label.Main.Text = text; --info.ask
    label.Main.TextColor3 = Color3.new(255, 255, 255)-- window.theme.itemscolor
    label.Main.TextSize = 15
    label.Main.TextStrokeTransparency = 1
    label.Main.TextXAlignment = Enum.TextXAlignment.Center


    local YesDelay = 25;
    local NoDelay = 100;
    if not window.Frame:FindFirstChild('extraside') or window.Frame:FindFirstChild('extraside') and window.Frame:FindFirstChild('extraside').Visible == false then 
        NoDelay = -5;
        YesDelay = -75
    end 

    local yes = {}	
    yes.Main = Instance.new("TextButton", cover)
    yes.Main.BorderSizePixel = 0
    yes.Main.Text = yesI; --info.accept
    yes.Main.AutoButtonColor = false
    yes.Main.Name = 'yes'
    yes.Main.TextColor3 = Color3.fromRGB(255,255,255)
    yes.Main.ZIndex = 200
    yes.Main.Size = UDim2.new(0,75,0,25)                
    yes.Main.Position = UDim2.fromOffset(LinesNeededtoCreateNew + YesDelay, cover.Size.Y.Offset/2); --UDim2.new(0,cover.Size.X.Offset/3.1,0,cover.Size.Y.Offset/2) -- cover.Position.X.Offset to 160            
    -- yes.Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    -- yes.Gradient = Instance.new("UIGradient", yes.Main)
    -- yes.Gradient.Rotation = 90
    -- yes.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.buttoncolor), ColorSequenceKeypoint.new(1.00, window.theme.buttoncolor2) })
    
    yes.Main.BackgroundTransparency = 0.6
    yes.Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

    local no ={}
    no.Main = Instance.new("TextButton", cover)
    no.Main.BorderSizePixel = 0
    no.Main.Text = noI; --info.reject
    no.Main.AutoButtonColor = false
    no.Main.Name = 'no'
    no.Main.TextColor3 = Color3.fromRGB(255,255,255)
    no.Main.ZIndex = 200
    no.Main.Size = UDim2.new(0,75,0,25)                
    no.Main.Position = UDim2.fromOffset(LinesNeededtoCreateNew + NoDelay , cover.Size.Y.Offset/2); --UDim2.new(0,yes.Main.Position.X.Offset+100,0,cover.Size.Y.Offset/2)             
    -- no.Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    -- no.Gradient = Instance.new("UIGradient", no.Main)
    -- no.Gradient.Rotation = 90
    -- no.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.buttoncolor), ColorSequenceKeypoint.new(1.00, window.theme.buttoncolor2) })
    no.Main.BackgroundTransparency = 0.6
    no.Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

    local b = nil

    yes.Main.MouseButton1Down:Connect(function()
        getgenv().disablefeatures =false
        --button.callback()
        cover:Destroy()
        changeTransparencies{s = 'revert'}
        b = true
        --print('dd yes')
    end)
    no.Main.MouseButton1Down:Connect(function()
        getgenv().disablefeatures = false
        cover:Destroy()
        changeTransparencies{s = 'revert'}
        b = false;
        --print('did no')
    end)
    repeat task.wait() until b ~= nil
    --print('returned')
    return b
end

function library:CreateWatermark(name, position)
    local gamename = GAMENAME ; --marketplaceservice:GetProductInfo(game.PlaceId).Name
    local watermark = { }
    watermark.Visible = true
    watermark.text = " " .. name:gsub("{game}", gamename):gsub("{fps}", "0 FPS") .. " "

    watermark.main = Instance.new("ScreenGui", coregui)
    watermark.main.Name = "Watermark"
    if syn then
        syn.protect_gui(watermark.main)
    end

    if getgenv().watermark then
        getgenv().watermark:Remove()
    end
    getgenv().watermarktable = watermark
    getgenv().watermark = watermark.main
    
    watermark.mainbar = Instance.new("Frame", watermark.main)
    watermark.mainbar.Name = "Main"
    watermark.mainbar.BorderColor3 = Color3.fromRGB(80, 80, 80)
    watermark.mainbar.Visible = watermark.Visible
    watermark.mainbar.BorderSizePixel = 0
    watermark.mainbar.ZIndex = 5
    watermark.mainbar.Position = UDim2.new(0, position and position.X or 10, 0, position and position.Y or 10)
    watermark.mainbar.Size = UDim2.new(0, 0, 0, 25)

    watermark.Gradient = Instance.new("UIGradient", watermark.mainbar)
    watermark.Gradient.Rotation = 90
    watermark.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 10)) })

    watermark.Outline = Instance.new("Frame", watermark.mainbar)
    watermark.Outline.Name = "outline"
    watermark.Outline.ZIndex = 4
    watermark.Outline.BorderSizePixel = 0
    watermark.Outline.Visible = watermark.Visible
    watermark.Outline.BackgroundColor3 = library.theme.outlinecolor
    watermark.Outline.Position = UDim2.fromOffset(-1, -1)

    watermark.BlackOutline = Instance.new("Frame", watermark.mainbar)
    watermark.BlackOutline.Name = "blackline"
    watermark.BlackOutline.ZIndex = 3
    watermark.BlackOutline.BorderSizePixel = 0
    watermark.BlackOutline.BackgroundColor3 = library.theme.outlinecolor2
    watermark.BlackOutline.Visible = watermark.Visible
    watermark.BlackOutline.Position = UDim2.fromOffset(-2, -2)

    watermark.label = Instance.new("TextLabel", watermark.mainbar)
    watermark.label.Name = "FPSLabel"
    watermark.label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    watermark.label.BackgroundTransparency = 1.000
    watermark.label.Position = UDim2.new(0, 0, 0, 0)
    watermark.label.Size = UDim2.new(0, 238, 0, 25)
    watermark.label.Font = library.theme.font
    watermark.label.ZIndex = 6
    watermark.label.Visible = watermark.Visible
    watermark.label.Text = watermark.text
    watermark.label.TextColor3 = Color3.fromRGB(255, 255, 255)
    watermark.label.TextSize = 15
    watermark.label.TextStrokeTransparency = 0.000
    watermark.label.TextXAlignment = Enum.TextXAlignment.Left
    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
    
    watermark.topbar = Instance.new("Frame", watermark.mainbar)
    watermark.topbar.Name = "TopBar"
    watermark.topbar.ZIndex = 6
    watermark.topbar.BackgroundColor3 = library.theme.accentcolor
    watermark.topbar.BorderSizePixel = 0
    watermark.topbar.Visible = watermark.Visible
    watermark.topbar.Size = UDim2.new(0, 0, 0, 1)

    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 25)
    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)    
    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)
    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

    local startTime, counter, oldfps = os.clock(), 0, nil
    runservice.Heartbeat:Connect(function()
        watermark.label.Visible = watermark.Visible
        watermark.mainbar.Visible = watermark.Visible
        watermark.topbar.Visible = watermark.Visible
        watermark.Outline.Visible = watermark.Visible
        watermark.BlackOutline.Visible = watermark.Visible

        if not name:find("{fps}") then
            watermark.label.Text = " " .. name:gsub("{game}", gamename):gsub("{fps}", "0 FPS") .. " "
        end

        if name:find("{fps}") then
            local currentTime = os.clock()
            counter = counter + 1
            if currentTime - startTime >= 1 then 
                local fps = math.floor(counter / (currentTime - startTime))
                counter = 0
                startTime = currentTime

                if fps ~= oldfps then
                    watermark.label.Text = " " .. name:gsub("{game}", gamename):gsub("{fps}", fps .. " FPS") .. " "
        
                    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
                    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 25)
                    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 1)

                    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
                    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)
                end
                oldfps = fps
            end
        end
    end)

    watermark.mainbar.MouseEnter:Connect(function()
        tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
    end)
    
    watermark.mainbar.MouseLeave:Connect(function()
        tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
    end)

    function watermark:SetState(state)
        if state == 'Active' then 
            --watermark.Visible = true 
            watermark.main.Enabled = true

        elseif state == 'Disable' then 
            watermark.main.Enabled = false
        else
            warn('Unrecognised paramater, "'..state..'". Did nothing.')
        end
    end

    function watermark:UpdateTheme(theme)
        theme = theme or library.theme
        watermark.Outline.BackgroundColor3 = theme.outlinecolor
        watermark.BlackOutline.BackgroundColor3 = theme.outlinecolor2
        watermark.label.Font = theme.font
        watermark.topbar.BackgroundColor3 = theme.accentcolor
    end

    return watermark
end

function library:CreateWindow(name, size, hidebutton)
    setthreadidentity(8);
    local window = { }

    window.name = name or ""
    window.size = UDim2.fromOffset(size.X, size.Y) or UDim2.fromOffset(492, 598)
    window.hidebutton = hidebutton or Enum.KeyCode.RightShift
    window.theme = library.theme

    

    local updateevent = Instance.new("BindableEvent")
    local configevent = Instance.new("BindableEvent")
    function window:UpdateTheme(theme)
        --print('firied')
        updateevent:Fire(theme or library.theme)
        window.theme = (theme or library.theme)
    end

    window.Main = Instance.new("ScreenGui", coregui)
    window.Main.Name = name
    window.Main.DisplayOrder = 15
    if syn then
        syn.protect_gui(window.Main)
        --print('protectedui')
    end
    window.storeobjects = Instance.new('Folder',window.Main); window.storeobjects.Name = 'storeobjects'
    if getgenv().uilib then
        getgenv().uilib:Remove()
    end
    getgenv().uilib = window.Main
    getgenv().getwindow = window

    local dragging, dragInput, dragStart, startPos
    uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            window.Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local dragstart = function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end

    local dragend = function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end

    window.Frame = Instance.new("TextButton", window.Main)
    window.Frame.Name = "main"
    window.Frame.Position = UDim2.fromScale(0.05,0.3) --UDim2.fromScale(0.5, 0.5)
    window.Frame.BorderSizePixel = 0
    window.Frame.Size = window.size
    window.Frame.AutoButtonColor = false
    window.Frame.Text = ""
    window.Frame.BackgroundColor3 = window.theme.backgroundcolor
    window.Frame.AnchorPoint = Vector2.new(0.05,0.3) --Vector2.new(0.5, 0.5)
    updateevent.Event:Connect(function(theme)
        window.Frame.BackgroundColor3 = theme.backgroundcolor
    end)

    uis.InputBegan:Connect(function(key)
        if key.KeyCode == window.hidebutton then
            window.Frame.Visible = not window.Frame.Visible
        end
        --warn(key.KeyCode)
    end)

    local function checkIfGuiInFront(Pos)
        local objects = coregui:GetGuiObjectsAtPosition(Pos.X, Pos.Y)
        for i,v in pairs(objects) do 
            if not string.find(v:GetFullName(), window.name) then 
                table.remove(objects, i)
            end 
        end
        return (#objects ~= 0 and objects[1].AbsolutePosition ~= Pos)
    end

    window.BlackOutline = Instance.new("Frame", window.Frame)
    window.BlackOutline.Name = "outline"
    window.BlackOutline.ZIndex = 1
    window.BlackOutline.Size = window.size + UDim2.fromOffset(2, 2)
    window.BlackOutline.BorderSizePixel = 0
    window.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
    window.BlackOutline.Position = UDim2.fromOffset(-1, -1)
    updateevent.Event:Connect(function(theme)
        window.BlackOutline.BackgroundColor3 = theme.outlinecolor2
    end)

    window.Outline = Instance.new("Frame", window.Frame)
    window.Outline.Name = "outline"
    window.Outline.ZIndex = 0
    window.Outline.Size = window.size + UDim2.fromOffset(4, 4)
    window.Outline.BorderSizePixel = 0
    window.Outline.BackgroundColor3 = window.theme.outlinecolor
    window.Outline.Position = UDim2.fromOffset(-2, -2)
    updateevent.Event:Connect(function(theme)
        window.Outline.BackgroundColor3 = theme.outlinecolor
    end)

    window.BlackOutline2 = Instance.new("Frame", window.Frame)
    window.BlackOutline2.Name = "outline"
    window.BlackOutline2.ZIndex = -1
    window.BlackOutline2.Size = window.size + UDim2.fromOffset(6, 6)
    window.BlackOutline2.BorderSizePixel = 0
    window.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
    window.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
    updateevent.Event:Connect(function(theme)
        window.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
    end)

    window.TopBar = Instance.new("Frame", window.Frame)
    window.TopBar.Name = "top"
    window.TopBar.Size = UDim2.fromOffset(window.size.X.Offset, window.theme.topheight)
    window.TopBar.BorderSizePixel = 0
    window.TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    window.TopBar.InputBegan:Connect(dragstart)
    window.TopBar.InputChanged:Connect(dragend)
    updateevent.Event:Connect(function(theme)
        window.TopBar.Size = UDim2.fromOffset(window.size.X.Offset, theme.topheight)
        if window.Frame:FindFirstChild('extraside') and window.Frame:FindFirstChild('extraside').Visible == true then 
            local xAddition = window.Frame:FindFirstChild('extraside').Size.X.Offset + 6
            window.TopBar.Size += UDim2.fromOffset(xAddition,0)
        end
    end)

    window.TopGradient = Instance.new("UIGradient", window.TopBar)
    window.TopGradient.Rotation = 90
    window.TopGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22,22,22)), ColorSequenceKeypoint.new(1, Color3.fromRGB(15,15,15)) })--ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.topcolor), ColorSequenceKeypoint.new(1.00, window.theme.topcolor2) })
    updateevent.Event:Connect(function(theme)
        --window.TopGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.topcolor), ColorSequenceKeypoint.new(1.00, theme.topcolor2) })
    end)

    window.NameLabel = Instance.new("TextLabel", window.TopBar)
    window.NameLabel.TextColor3 = window.theme.toptextcolor
    window.NameLabel.Text = window.name
    window.NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.NameLabel.Font = window.theme.font
    window.NameLabel.Name = "title"
    window.NameLabel.Position = UDim2.fromOffset(4, -2)
    window.NameLabel.BackgroundTransparency = 1
    window.NameLabel.Size = UDim2.fromOffset(190, window.TopBar.AbsoluteSize.Y / 2 - 2)
    window.NameLabel.TextSize = window.theme.titlesize
    updateevent.Event:Connect(function(theme)
        window.NameLabel.TextColor3 = theme.toptextcolor
        window.NameLabel.Font = theme.font
        window.NameLabel.TextSize = theme.titlesize
    end)

    window.Line2 = Instance.new("Frame", window.TopBar)
    window.Line2.Name = "line"
    window.Line2.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y / 2.1)
    window.Line2.Size = UDim2.fromOffset(window.size.X.Offset, 1)
    window.Line2.BorderSizePixel = 0
    window.Line2.BackgroundColor3 = window.theme.accentcolor
    updateevent.Event:Connect(function(theme)
        window.Line2.BackgroundColor3 = theme.accentcolor
    end)

    window.TabList = Instance.new("Frame", window.TopBar)
    window.TabList.Name = "tablist"
    window.TabList.BackgroundTransparency = 1
    window.TabList.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y / 2 + 1)
    window.TabList.Size = UDim2.fromOffset(window.size.X.Offset, window.TopBar.AbsoluteSize.Y / 2)
    window.TabList.BorderSizePixel = 0
    window.TabList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    window.TabList.InputBegan:Connect(dragstart)
    window.TabList.InputChanged:Connect(dragend)

    window.BlackLine = Instance.new("Frame", window.Frame)
    window.BlackLine.Name = "blackline"
    window.BlackLine.Size = UDim2.fromOffset(window.size.X.Offset, 1)
    window.BlackLine.BorderSizePixel = 0
    window.BlackLine.ZIndex = 9
    window.BlackLine.BackgroundColor3 = window.theme.outlinecolor2
    window.BlackLine.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y)
    updateevent.Event:Connect(function(theme)
        window.BlackLine.BackgroundColor3 = theme.outlinecolor2
    end)

    window.BackgroundImage = Instance.new("ImageLabel", window.Frame)
    window.BackgroundImage.Name = "background"
    window.BackgroundImage.BorderSizePixel = 0
    window.BackgroundImage.ScaleType = Enum.ScaleType.Tile
    window.BackgroundImage.Position = window.BlackLine.Position + UDim2.fromOffset(0, 1)
    window.BackgroundImage.Size = UDim2.fromOffset(window.size.X.Offset, window.size.Y.Offset - window.TopBar.AbsoluteSize.Y - 1)
    window.BackgroundImage.Image = window.theme.background or ""
    window.BackgroundImage.ImageTransparency = window.BackgroundImage.Image ~= "" and 0 or 1
    window.BackgroundImage.ImageColor3 = Color3.new() 
    window.BackgroundImage.BackgroundColor3 = window.theme.backgroundcolor
    window.BackgroundImage.TileSize = UDim2.new(0, window.theme.tilesize, 0, window.theme.tilesize)
    updateevent.Event:Connect(function(theme)
        window.BackgroundImage.Image = theme.background or ""
        window.BackgroundImage.ImageTransparency = window.BackgroundImage.Image ~= "" and 0 or 1
        window.BackgroundImage.BackgroundColor3 = theme.backgroundcolor
        window.BackgroundImage.TileSize = UDim2.new(0, theme.tilesize, 0, theme.tilesize)
    end)

    window.Line = Instance.new("Frame", window.Frame)
    window.Line.Name = "line"
    window.Line.Position = UDim2.fromOffset(0, 0)
    window.Line.Size = UDim2.fromOffset(60, 1)
    window.Line.BorderSizePixel = 0
    window.Line.BackgroundColor3 = window.theme.accentcolor
    updateevent.Event:Connect(function(theme)
        window.Line.BackgroundColor3 = theme.accentcolor
    end)

    window.ListLayout = Instance.new("UIListLayout", window.TabList)
    window.ListLayout.FillDirection = Enum.FillDirection.Horizontal
    window.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder


    window.BackgroundGradient = Instance.new('UIGradient')
    window.BackgroundGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.topcolor), ColorSequenceKeypoint.new(1.00, window.theme.topcolor2) }) -- ColorSequence.new({0,0.45098,0.45098,0.45098,0,1,1,1,1,0}) -- backgrg
    window.BackgroundGradient.Parent = window.TopBar
    updateevent.Event:Connect(function(theme)
        window.BackgroundGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.topcolor), ColorSequenceKeypoint.new(1.00, theme.topcolor2) })
    end)

    window.OpenedColorPickers = { }
    window.Tabs = { }
    local xAddition;
    local offsetWas ;



    function window:CreateTab(name)
        local tab = { }
        tab.name = name or ""

        local textservice = game:GetService("TextService")
        local size = textservice:GetTextSize(tab.name, window.theme.fontsize, window.theme.font, Vector2.new(200,300))

        tab.TabButton = Instance.new("TextButton", window.TabList)
        tab.TabButton.TextColor3 = window.theme.tabstextcolor
        tab.TabButton.Text = tab.name
        tab.TabButton.AutoButtonColor = false
        tab.TabButton.Font = window.theme.font
        tab.TabButton.TextYAlignment = Enum.TextYAlignment.Center
        tab.TabButton.BackgroundTransparency = 1
        tab.TabButton.BorderSizePixel = 0
        tab.TabButton.Size = UDim2.fromOffset(size.X + 15, window.TabList.AbsoluteSize.Y - 1)
        tab.TabButton.Name = tab.name
        tab.TabButton.TextSize = window.theme.fontsize
        updateevent.Event:Connect(function(theme)
            local size = textservice:GetTextSize(tab.name, theme.fontsize, theme.font, Vector2.new(200,300))
            tab.TabButton.TextColor3 = tab.TabButton.Name == "SelectedTab" and theme.accentcolor or theme.tabstextcolor
            tab.TabButton.Font = theme.font
            tab.TabButton.Size = UDim2.fromOffset(size.X + 15, window.TabList.AbsoluteSize.Y - 1)
            tab.TabButton.TextSize = theme.fontsize
        end)

        tab.Left = Instance.new("ScrollingFrame", window.Frame) 
        tab.Left.Name = "leftside"
        tab.Left.BorderSizePixel = 0
        tab.Left.Size = UDim2.fromOffset(window.size.X.Offset / 2, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
        tab.Left.BackgroundTransparency = 1
        tab.Left.Visible = false
        tab.Left.ScrollBarThickness = 0
        tab.Left.ScrollingDirection = "Y"
        tab.Left.Position = window.BlackLine.Position + UDim2.fromOffset(0, 1)

        tab.LeftListLayout = Instance.new("UIListLayout", tab.Left)
        tab.LeftListLayout.FillDirection = Enum.FillDirection.Vertical
        tab.LeftListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tab.LeftListLayout.Padding = UDim.new(0, 12)

        tab.LeftListPadding = Instance.new("UIPadding", tab.Left)
        tab.LeftListPadding.PaddingTop = UDim.new(0, 12)
        tab.LeftListPadding.PaddingLeft = UDim.new(0, 12)
        tab.LeftListPadding.PaddingRight = UDim.new(0, 12)

        tab.Right = Instance.new("ScrollingFrame", window.Frame) 
        tab.Right.Name = "rightside"
        tab.Right.ScrollBarThickness = 0
        tab.Right.ScrollingDirection = "Y"
        tab.Right.Visible = false
        tab.Right.BorderSizePixel = 0
        tab.Right.Size = UDim2.fromOffset(window.size.X.Offset / 2, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
        tab.Right.BackgroundTransparency = 1
        tab.Right.Position = tab.Left.Position + UDim2.fromOffset(tab.Left.AbsoluteSize.X, 0)

        tab.RightListLayout = Instance.new("UIListLayout", tab.Right)
        tab.RightListLayout.FillDirection = Enum.FillDirection.Vertical
        tab.RightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tab.RightListLayout.Padding = UDim.new(0, 12)

        tab.RightListPadding = Instance.new("UIPadding", tab.Right)
        tab.RightListPadding.PaddingTop = UDim.new(0, 12)
        tab.RightListPadding.PaddingLeft = UDim.new(0, 6)
        tab.RightListPadding.PaddingRight = UDim.new(0, 12)

        local function createExtra(n)
            --print(`removing status {n} and {xAddition}`)
            local isActive = tab.TabButton.Name == 'SelectedTab' -- or tab.Left == true
            --if tab.
            if not tab.Extra and window.Frame:FindFirstChild('extraside') and window.Frame:FindFirstChild('extraside').Visible == true then 
                n = 'remove'
            end
            if n == 'remove' and xAddition and window.Frame:FindFirstChild('extraside') and window.Frame:FindFirstChild('extraside').Visible == true then 
                window.Frame:FindFirstChild('extraside').Visible = false
                --print('added, '..tostring(xAddition))
                xAddition = -xAddition
                --print('removing, '..tostring(xAddition))
                window.Frame.Size -= UDim2.fromOffset(offsetWas,0)
                --xAddition = tab.Extra.Size.X.Offset - 6
                window.Frame.top.Size += UDim2.fromOffset(xAddition,0)
                window.Frame.top.line.Size += UDim2.fromOffset(xAddition,0)
                window.Frame.blackline.Size += UDim2.fromOffset(xAddition,0)
                for _,v in next, window.Frame:GetChildren() do 
                    if v.Name == 'outline' then 
                        if _==1 then 
                            v.Size += UDim2.fromOffset(xAddition, 0) --1 rest are 1s
                        elseif _ ==2 then 
                            v.Size += UDim2.fromOffset(xAddition, 0) --2
                        elseif _== 3 then 
                            v.Size += UDim2.fromOffset(xAddition, 0) --1
                        end 
                    end 
                end 
                window.Frame.background.Size += UDim2.fromOffset(xAddition,0)
                return
            elseif n == 'remove' then 

                return
            end
            if window.Frame:FindFirstChild('extraside') and window.Frame:FindFirstChild('extraside').Visible == true then return end
            if not window.Frame:FindFirstChild('extraside') then 
                --print('new exter')
                tab.Extra = Instance.new("ScrollingFrame", window.Frame)  -- make var for extra then set tab.Extra to the var
                tab.Extra.Name = "extraside"
                tab.Extra.ScrollBarThickness = 0
                tab.Extra.ScrollingDirection = "Y"
                tab.Extra.Visible = false
                tab.Extra.BorderSizePixel = 0
                -- tab.Left.Size = UDim2.fromOffset(window.size.X.Offset / 3, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
                -- tab.Right.Size = UDim2.fromOffset(window.size.X.Offset / 3, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
                 --UDim2.new(0.152,0,0,0) -- UDim2.fromOffset()--
                -- window.size = UDim2.fromOffset(size.X+500, size.Y)
                -- window.BlackOutline.Size = window.size + UDim2.fromOffset(2, 2)
                -- window.Outline.Size = window.size + UDim2.fromOffset(4, 4)
                -- window.BlackOutline2.Size = window.size + UDim2.fromOffset(6, 6)
                -- window.TopBar.Size = UDim2.fromOffset(window.size.X.Offset, window.theme.topheight)
                -- window.Line2.Size = UDim2.fromOffset(window.size.X.Offset, 1)
                -- window.TabList.Size = UDim2.fromOffset(window.size.X.Offset, window.TopBar.AbsoluteSize.Y / 2)
                -- window.BlackLine.Size = UDim2.fromOffset(window.size.X.Offset, 1)
                -- window.BackgroundImage.Size = UDim2.fromOffset(window.size.X.Offset, window.size.Y.Offset - window.TopBar.AbsoluteSize.Y - 1)
                -- window.Line.Size = UDim2.fromOffset(60, 1)
    
    
                -- tab.Left.Size = UDim2.fromOffset(window.size.X.Offset / 3, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
                -- for _,v in next, tab.Left:GetChildren() do 
                --     for kc,unewv in next, v:GetChildren() do 
                --         if unewv.Name == 'items' then 
                --             unewv.Size = tab.Left.Size
                --         end 
                --     end 
                -- end 
                -- tab.Right.Size = UDim2.fromOffset(window.size.X.Offset / 3, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
    
    
    
    
                tab.Extra.Size = UDim2.fromOffset(window.size.X.Offset / 2, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
                tab.Extra.BackgroundTransparency = 1
                tab.Extra.Position = tab.Right.Position + UDim2.fromOffset(tab.Right.AbsoluteSize.X-2, 0)--tab.Right.Position + UDim2.fromOffset(10, 0)
        
                tab.ExtraListLayout = Instance.new("UIListLayout", tab.Extra)
                tab.ExtraListLayout.FillDirection = Enum.FillDirection.Vertical
                tab.ExtraListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                tab.ExtraListLayout.Padding = UDim.new(0, 12)
        
                tab.ExtraListPadding = Instance.new("UIPadding", tab.Extra)
                tab.ExtraListPadding.PaddingTop = UDim.new(0, 12)
                tab.ExtraListPadding.PaddingLeft = UDim.new(0, 6)
                tab.ExtraListPadding.PaddingRight = UDim.new(0, 12)
            end

            if isActive == true and tab.Extra then 
                offsetWas = tab.Extra.Size.X.Offset/3
                window.Frame.Size += UDim2.fromOffset(tab.Extra.Size.X.Offset/3,0)
                xAddition = tab.Extra.Size.X.Offset + 6
                window.Frame.top.Size += UDim2.fromOffset(xAddition,0)
                window.Frame.top.line.Size += UDim2.fromOffset(xAddition,0)
                window.Frame.blackline.Size += UDim2.fromOffset(xAddition,0)
                for _,v in next, window.Frame:GetChildren() do 
                    if v.Name == 'outline' then 
                        if _==1 then 
                            v.Size += UDim2.fromOffset(xAddition, 0)-- 1
                        elseif _ ==2 then 
                            v.Size += UDim2.fromOffset(xAddition, 0) -- 2
                        elseif _== 3 then 
                            v.Size += UDim2.fromOffset(xAddition, 0)--1
                        end 
                    end 
                end 
                window.Frame.background.Size += UDim2.fromOffset(xAddition,0)
            end
            --

            --local isActive = tab.TabButton == 'SelectedTab' -- or tab.Left == true


            if tab.Extra then 
                tab.Extra.Visible = isActive
            end
            -- task.delay(2,function()
            --     --window.TopBar.Size += UDim2.fromOffset(xAddition, window.theme.topheight)
            -- end)





            --tab.Extra.Visible = true






            return tab.Extra
        end 

        -- would load the end tab cuz select tab wasnt called after it so it wouldnt say to make the frame invis
        -- taks for anotgher day, maye multiple tabs that can support extra


        local block = false
        function tab:SelectTab()
            repeat 
                wait()
            until block == false

            block = true
            for i,v in pairs(window.Tabs) do
                if v ~= tab then
                    v.TabButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                    v.TabButton.Name = "Tab"
                    v.Left.Visible = false
                    v.Right.Visible = false
                    if v.Extra then 
                      --  createExtra(); --v.Extra.Visible = false
                    end
                    --(v.Extra and v.Extra.Visible = false)
                    createExtra('remove')
                end
            end

            tab.TabButton.TextColor3 = window.theme.accentcolor
            tab.TabButton.Name = "SelectedTab"
            tab.Right.Visible = true
            tab.Left.Visible = true
            if tab.Extra then 
                createExtra()
                --tab.Extra.Visible = true
            else
                --print('SUPPOSED TO REMOVE')
                createExtra('remove')
            end 
            window.Line:TweenSizeAndPosition(UDim2.fromOffset(size.X + 15, 1), UDim2.new(0, (tab.TabButton.AbsolutePosition.X - window.Frame.AbsolutePosition.X), 0, 0) + (window.BlackLine.Position - UDim2.fromOffset(0, 1)), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15)
            wait(0.2)
            block = false
        end
    
        if #window.Tabs == 0 then
            tab:SelectTab()
        end

        tab.TabButton.MouseButton1Down:Connect(function()
            tab:SelectTab()
        end)

        tab.SectorsLeft = { }
        tab.SectorsRight = { }
        tab.SectorsExtra = { }

        function tab:CreateSector(name,side)
            setthreadidentity(7)
            local sector = { }
            sector.name = name or ""
            sector.side = side:lower() or "left"
            
            --print(side:lower())
            --local selectedSector = tab.Left
            --if sector.side == 'left' then selectedSector = tab.Left elseif sector.side == 'right' then selectedSector = tab.Right elseif sector.side == 'extra' then selectedSector = tab.Extra end
            --sector.Main = Instance.new("Frame", selectedSector) 
            local tabg = sector.side
            if tabg == 'right' then tabg = tab.Right; end
            if tabg == 'extra' then 
                if tab.Extra  == nil then 
                    createExtra()
                end 
                tab.needsextra = true;
                tabg = tab.Extra; 
        
            end
            if tabg == sector.side then tabg = tab.Left; end
            
            sector.Main = Instance.new("Frame", tabg)  -- sector.side == "left" and tab.Left or tab.Right or tab.Extra
            sector.Main.Name = sector.name:gsub(" ", "") .. "Sector"
            sector.Main.BorderSizePixel = 0
            sector.Main.ZIndex = 4
            sector.Main.Size = UDim2.fromOffset(window.size.X.Offset / 2 - 17, 20)
            sector.Main.BackgroundColor3 = window.theme.sectorcolor
            --sector.Main.Position = sector.side == "left" and UDim2.new(0, 11, 0, 12) or UDim2.new(0, window.size.X.Offset - sector.Main.AbsoluteSize.X - 11, 0, 12)
            updateevent.Event:Connect(function(theme)
                sector.Main.BackgroundColor3 = theme.sectorcolor
            end)

            sector.Line = Instance.new("Frame", sector.Main)
            sector.Line.Name = "line"
            sector.Line.ZIndex = 4
            sector.Line.Size = UDim2.fromOffset(sector.Main.Size.X.Offset + 4, 1)
            sector.Line.BorderSizePixel = 0
            sector.Line.Position = UDim2.fromOffset(-2, -2)
            sector.Line.BackgroundColor3 = window.theme.accentcolor
            updateevent.Event:Connect(function(theme)
                sector.Line.BackgroundColor3 = theme.accentcolor
            end)

            sector.BlackOutline = Instance.new("Frame", sector.Main)
            sector.BlackOutline.Name = "outline"
            sector.BlackOutline.ZIndex = 3
            sector.BlackOutline.Size = sector.Main.Size + UDim2.fromOffset(2, 2)
            sector.BlackOutline.BorderSizePixel = 0
            sector.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
            sector.BlackOutline.Position = UDim2.fromOffset(-1, -1)
            sector.Main:GetPropertyChangedSignal("Size"):Connect(function()
                sector.BlackOutline.Size = sector.Main.Size + UDim2.fromOffset(2, 2)
            end)
            updateevent.Event:Connect(function(theme)
                sector.BlackOutline.BackgroundColor3 = theme.outlinecolor2
            end)


            sector.Outline = Instance.new("Frame", sector.Main)
            sector.Outline.Name = "outline"
            sector.Outline.ZIndex = 2
            sector.Outline.Size = sector.Main.Size + UDim2.fromOffset(4, 4)
            sector.Outline.BorderSizePixel = 0
            sector.Outline.BackgroundColor3 = window.theme.outlinecolor
            sector.Outline.Position = UDim2.fromOffset(-2, -2)
            sector.Main:GetPropertyChangedSignal("Size"):Connect(function()
                sector.Outline.Size = sector.Main.Size + UDim2.fromOffset(4, 4)
            end)
            updateevent.Event:Connect(function(theme)
                sector.Outline.BackgroundColor3 = theme.outlinecolor
            end)

            sector.BlackOutline2 = Instance.new("Frame", sector.Main)
            sector.BlackOutline2.Name = "outline"
            sector.BlackOutline2.ZIndex = 1
            sector.BlackOutline2.Size = sector.Main.Size + UDim2.fromOffset(6, 6)
            sector.BlackOutline2.BorderSizePixel = 0
            sector.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
            sector.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
            sector.Main:GetPropertyChangedSignal("Size"):Connect(function()
                sector.BlackOutline2.Size = sector.Main.Size + UDim2.fromOffset(6, 6)
            end)
            updateevent.Event:Connect(function(theme)
                sector.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
            end)

            local size = textservice:GetTextSize(sector.name, 15, window.theme.font, Vector2.new(2000, 2000))
            sector.Label = Instance.new("TextLabel", sector.Main)
            sector.Label.AnchorPoint = Vector2.new(0,0.5)
            sector.Label.Position = UDim2.fromOffset(12, -1)
            sector.Label.Size = UDim2.fromOffset(math.clamp(textservice:GetTextSize(sector.name, 15, window.theme.font, Vector2.new(200,300)).X + 13, 0, sector.Main.Size.X.Offset), size.Y)
            sector.Label.BackgroundTransparency = 1
            sector.Label.BorderSizePixel = 0
            sector.Label.ZIndex = 6
            sector.Label.Text = sector.name
            sector.Label.TextColor3 = Color3.new(1,1,2552/255)
            sector.Label.TextStrokeTransparency = 1
            sector.Label.Font = window.theme.font
            sector.Label.TextSize = 15
            updateevent.Event:Connect(function(theme)
                local size = textservice:GetTextSize(sector.name, 15, theme.font, Vector2.new(2000, 2000))
		        -- print(sector.Main.Size.X.Offset or nil)
		        -- print(textservice:GetTextSize(sector.name, 15, theme.font, Vector2.new(200,300)).X + 13)
                sector.Label.Size = UDim2.fromOffset(math.clamp(textservice:GetTextSize(sector.name, 15, theme.font, Vector2.new(200,300)).X + 13, 0, sector.Main.Size.X.Offset), size.Y)
                sector.Label.Font = theme.font
            end)

            sector.LabelBackFrame = Instance.new("Frame", sector.Main)
            sector.LabelBackFrame.Name = "labelframe"
            sector.LabelBackFrame.ZIndex = 5
            sector.LabelBackFrame.Size = UDim2.fromOffset(sector.Label.Size.X.Offset, 10)
            sector.LabelBackFrame.BorderSizePixel = 0
            sector.LabelBackFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            sector.LabelBackFrame.Position = UDim2.fromOffset(sector.Label.Position.X.Offset, sector.BlackOutline2.Position.Y.Offset)

            sector.Items = Instance.new("Frame", sector.Main) 
            sector.Items.Name = "items"
            sector.Items.ZIndex = 2
            sector.Items.BackgroundTransparency = 1
            sector.Items.Size = UDim2.fromOffset(170, 140)
            sector.Items.AutomaticSize = Enum.AutomaticSize.Y
            sector.Items.BorderSizePixel = 0

            sector.ListLayout = Instance.new("UIListLayout", sector.Items)
            sector.ListLayout.FillDirection = Enum.FillDirection.Vertical
            sector.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sector.ListLayout.Padding = UDim.new(0, 12)

            sector.ListPadding = Instance.new("UIPadding", sector.Items)
            sector.ListPadding.PaddingTop = UDim.new(0, 15)
            sector.ListPadding.PaddingLeft = UDim.new(0, 6)
            sector.ListPadding.PaddingRight = UDim.new(0, 6)

            table.insert(sector.side:lower() == "left" and tab.SectorsLeft or sector.side:lower() == "right" and tab.SectorsRight or sector.side:lower() == "extra" and tab.SectorsExtra, sector)

            function sector:CreateHintOnItem(itemto, hint)  -- sector:CreateHintOnItem(itemto, hint) 
                itemto.hint = true;
                itemto.knowledgemessage = hint;
                function itemto:ActivateKnowledge()
                    itemto.hint = true 
                end
                function itemto:DeactivateKnowledge()
                    itemto.hint = false 
                end
                function itemto:AddKnowledge(text)
                    -- 
                    itemto.knowledgemessage = text
                end
                function itemto:AddKnowledgeButton()
                    local knowledge = { }
                    knowledge.Visible = true
                
                    knowledge.main = Instance.new("ScreenGui", window.storeobjects); --window.storeobjects
                    knowledge.main.Name = "knowledge"
                    -- if syn then
                    --     syn.protect_gui(knowledge.main)
                    -- end
                    -- knowledge.holdframe = Instance.new("Frame", window.Frame)
                
                    local dividedy = (game.Players.LocalPlayer:GetMouse().Y / workspace.CurrentCamera.ViewportSize.Y)
                    local dividedx = (game.Players.LocalPlayer:GetMouse().X / workspace.CurrentCamera.ViewportSize.X)
                    --knowledge.main.Position = UDim2.fromOffset(dividedx,dividedy)
                    local screenSize = knowledge.main.AbsoluteSize
                    knowledge.mainbar = Instance.new("Frame", window.Main) -- knowledge.main -- knowledge.main
                    knowledge.mainbar.Name = "KnowledgeFrame"
                    knowledge.mainbar.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    knowledge.mainbar.Visible = knowledge.Visible
                    knowledge.mainbar.BorderSizePixel = 0
                    knowledge.mainbar.ZIndex = 100
                    knowledge.AnchorPoint = Vector2.new(0.5,0.5)

                    knowledge.mainbar.Position = UDim2.new(0, dividedx , 0, dividedy )--UDim2.new(dividedx,0,dividedy,0)--button.Main.Position + UDim2.fromOffset(,1)-- UDim2.new(0, position and position.X or 10, 0, position and position.Y or 10)
                    knowledge.mainbar.Size = UDim2.new(0, 8, 0, 25)
                
                    knowledge.Gradient = Instance.new("UIGradient", knowledge.mainbar)
                    knowledge.Gradient.Rotation = 90
                    knowledge.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 10)) })
                
                    knowledge.Outline = Instance.new("Frame", knowledge.mainbar)
                    knowledge.Outline.Name = "outline"
                    knowledge.Outline.ZIndex = 4
                    knowledge.Outline.BorderSizePixel = 0
                    knowledge.Outline.Visible = knowledge.Visible
                    knowledge.Outline.BackgroundColor3 = library.theme.outlinecolor
                    knowledge.Outline.Position = UDim2.fromOffset(-1, -1)
                
                    knowledge.BlackOutline = Instance.new("Frame", knowledge.mainbar)
                    knowledge.BlackOutline.Name = "blackline"
                    knowledge.BlackOutline.ZIndex = 3
                    knowledge.BlackOutline.BorderSizePixel = 0
                    knowledge.BlackOutline.BackgroundColor3 = library.theme.outlinecolor2
                    knowledge.BlackOutline.Visible = knowledge.Visible
                    knowledge.BlackOutline.Position = UDim2.fromOffset(-2, -2)
                
                    knowledge.label = Instance.new("TextLabel", knowledge.mainbar)
                    knowledge.label.Name = "textlabel"
                    knowledge.label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    knowledge.label.BackgroundTransparency = 1.000
                    knowledge.label.Position = UDim2.new(0, 0, 0, 0)
                    knowledge.label.Size = UDim2.new(0, 238, 0, 25)
                    knowledge.label.Font = library.theme.font
                    knowledge.label.ZIndex = 6
                    knowledge.label.Visible = knowledge.Visible
                    knowledge.label.Text = itemto.knowledgemessage
                    knowledge.label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    knowledge.label.TextSize = 15
                    knowledge.label.TextStrokeTransparency = 0.000
                    knowledge.label.TextXAlignment = Enum.TextXAlignment.Left
                    knowledge.label.Size = UDim2.new(0, knowledge.label.TextBounds.X+10, 0, 25)
                    
                    knowledge.topbar = Instance.new("Frame", knowledge.mainbar)
                    knowledge.topbar.Name = "TopBar"
                    knowledge.topbar.ZIndex = 6
                    knowledge.topbar.BackgroundColor3 = library.theme.accentcolor
                    knowledge.topbar.BorderSizePixel = 0
                    knowledge.topbar.Visible = knowledge.Visible
                    knowledge.topbar.Size = UDim2.new(0, 0, 0, 1)
                
                    knowledge.mainbar.Size = UDim2.new(0, knowledge.label.TextBounds.X, 0, 25)
                    knowledge.topbar.Size = UDim2.new(0, knowledge.label.TextBounds.X+6, 0, 1)
                    knowledge.Outline.Size = knowledge.mainbar.Size + UDim2.fromOffset(2, 2)
                    knowledge.BlackOutline.Size = knowledge.mainbar.Size + UDim2.fromOffset(4, 4)
                
                    knowledge.mainbar.Size = UDim2.new(0, knowledge.label.TextBounds.X+4, 0, 25)    
                    knowledge.label.Size = UDim2.new(0, knowledge.label.TextBounds.X+4, 0, 25)
                    knowledge.topbar.Size = UDim2.new(0, knowledge.label.TextBounds.X+6, 0, 1)
                    knowledge.Outline.Size = knowledge.mainbar.Size + UDim2.fromOffset(2, 2)
                    knowledge.BlackOutline.Size = knowledge.mainbar.Size + UDim2.fromOffset(4, 4)
                    knowledge.label.ZIndex = 1000
                    knowledge.Outline.ZIndex = 1000
                    knowledge.mainbar.ZIndex = 1000
                    knowledge.BlackOutline.ZIndex = 1000
                    knowledge.topbar.ZIndex = 1000
                    local connection = game.Players.LocalPlayer:GetMouse().Move:Connect(function()
                        if knowledge.mainbar then 
                            local dividedy = (game.Players.LocalPlayer:GetMouse().Y / workspace.CurrentCamera.ViewportSize.Y)
                            local dividedx = (game.Players.LocalPlayer:GetMouse().X / workspace.CurrentCamera.ViewportSize.X)
                            --local udim = UDim2.new(0, mouse.X-script.Parent.Parent.AbsolutePosition.X, 0, mouse.Y-script.Parent.Parent.AbsolutePosition.Y) -- UDim2.new(0,game.Players.LocalPlayer:GetMouse().X + 20,0,game.Players.LocalPlayer:GetMouse().Y + 50) --
                            knowledge.mainbar.Position = UDim2.new(0,mouse.X-10,0,mouse.Y - 25) --UDim2.new(0, mouse.X - 100, 0, mouse.Y - 200) -- UDim2.new(0, mouse.X-button.Main.AbsolutePosition.X+100, 0, mouse.Y-button.Main.AbsolutePosition.Y) -- +20
                        else
                            connection:Disconnect()
                        end
                    end)
                    
                    return knowledge
                end
                local function removeknowledges()
                    for i,v in next, window.Main:GetChildren() do 
                        if v.Name == 'KnowledgeFrame' then 
                            v:Destroy()
                        end
                    end;
                end;
                itemto.BlackOutline2.MouseEnter:Connect(function()
                    if getgenv().disablefeatures == true then return end
                    itemto.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    -- HINT
                    if itemto.hint == true then 
                        --print('added hint')
                        removeknowledges()
                        knowledge = itemto:AddKnowledgeButton()
                        knowledge.label.Text = itemto.knowledgemessage
                    end
                end)

                itemto.BlackOutline2.MouseLeave:Connect(function()
                    -- if getgenv().disablefeatures == true then return end
                    itemto.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    if itemto.hint == true then 
                        if window.Main:FindFirstChild('KnowledgeFrame') then -- button.Main
                            --print('removed hint')
                            removeknowledges()
                            --window.Main:FindFirstChild('KnowledgeFrame'):Destroy()
                        end
                    end
                end)
            end;

            function sector:FixSize()
                sector.Main.Size = UDim2.fromOffset(window.size.X.Offset / 2 - 17, sector.ListLayout.AbsoluteContentSize.Y + 22)
                local sizeleft, sizeright = 0, 0
                for i,v in pairs(tab.SectorsLeft) do
                    sizeleft = sizeleft + v.Main.AbsoluteSize.Y
                end
                for i,v in pairs(tab.SectorsRight) do
                    sizeright = sizeright + v.Main.AbsoluteSize.Y
                end

                tab.Left.CanvasSize = UDim2.fromOffset(tab.Left.AbsoluteSize.X, sizeleft + ((#tab.SectorsLeft - 1) * tab.LeftListPadding.PaddingTop.Offset) + 20)
                tab.Right.CanvasSize = UDim2.fromOffset(tab.Right.AbsoluteSize.X, sizeright + ((#tab.SectorsRight - 1) * tab.RightListPadding.PaddingTop.Offset) + 20)
            end

            function sector:AddButton(text, callback,info)
                local button = { }
                button.hint = false;
                button.knowledgemessage = '';
                button.text = text or ""
                button.callback = callback or function() end

                button.Main = Instance.new("TextButton", sector.Items)
                button.Main.BorderSizePixel = 0
                button.Main.Text = ""
                button.Main.AutoButtonColor = false
                button.Main.Name = "button"
                button.Main.ZIndex = 5
                button.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 14)
                button.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

                button.Gradient = Instance.new("UIGradient", button.Main)
                button.Gradient.Rotation = 90
                button.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.buttoncolor), ColorSequenceKeypoint.new(1.00, window.theme.buttoncolor2) })
                
		
		
		        updateevent.Event:Connect(function(theme)
                    button.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.buttoncolor), ColorSequenceKeypoint.new(1.00, theme.buttoncolor2) })
                end)

                button.BlackOutline2 = Instance.new("Frame", button.Main)
                button.BlackOutline2.Name = "blackline"
                button.BlackOutline2.ZIndex = 4
                button.BlackOutline2.Size = button.Main.Size + UDim2.fromOffset(6, 6)
                button.BlackOutline2.BorderSizePixel = 0
                button.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                button.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                updateevent.Event:Connect(function(theme)
                    button.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                end)

                button.Outline = Instance.new("Frame", button.Main)
                button.Outline.Name = "blackline"
                button.Outline.ZIndex = 4
                button.Outline.Size = button.Main.Size + UDim2.fromOffset(4, 4)
                button.Outline.BorderSizePixel = 0
                button.Outline.BackgroundColor3 = window.theme.outlinecolor
                button.Outline.Position = UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    button.Outline.BackgroundColor3 = theme.outlinecolor
                end)

                button.BlackOutline = Instance.new("Frame", button.Main)
                button.BlackOutline.Name = "blackline"
                button.BlackOutline.ZIndex = 4
                button.BlackOutline.Size = button.Main.Size + UDim2.fromOffset(2, 2)
                button.BlackOutline.BorderSizePixel = 0
                button.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                button.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                updateevent.Event:Connect(function(theme)
                    button.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                end)

                button.Label = Instance.new("TextLabel", button.Main)
                button.Label.Name = "Label"
                button.Label.BackgroundTransparency = 1
                button.Label.Position = UDim2.new(0, -1, 0, 0)
                button.Label.ZIndex = 5
                button.Label.Size = button.Main.Size
                button.Label.Font = window.theme.font
                button.Label.Text = button.text
                button.Label.TextColor3 = window.theme.itemscolor2
                button.Label.TextSize = 15
                button.Label.TextStrokeTransparency = 1
                button.Label.TextXAlignment = Enum.TextXAlignment.Center -- 765

                button.Main.MouseButton1Down:Connect(function()         
                    if getgenv().disablefeatures == true then return end -- print('no go no show')
                    if info and info.shouldcheck then -- text
                        if library:CheckForPermission({ask = info.ask}) == true  then 
                            button.callback()
                        end
                    else
                        button.callback()
                    end
                end)
                    -- could do mousebutton1down and check if info then do
                    -- or check info and then check for the button pressed and add the cover stuff
                updateevent.Event:Connect(function(theme)
                    button.Label.Font = theme.font
                    button.Label.TextColor3 = theme.itemscolor
                end)
                function button:ActivateKnowledge()
                    button.hint = true 
                end
                function button:DeactivateKnowledge()
                    button.hint = false 
                end
                function button:AddKnowledge(text)
                    -- 
                    button.knowledgemessage = text
                end
                function button:AddKnowledgeButton()
                    local knowledge = { }
                    knowledge.Visible = true
                
                    knowledge.main = Instance.new("ScreenGui", window.storeobjects)
                    knowledge.main.Name = "knowledge"
                    -- if syn then
                    --     syn.protect_gui(knowledge.main)
                    -- end
                
                    local dividedy = (game.Players.LocalPlayer:GetMouse().Y / workspace.CurrentCamera.ViewportSize.Y)
                    local dividedx = (game.Players.LocalPlayer:GetMouse().X / workspace.CurrentCamera.ViewportSize.X)
                    --knowledge.main.Position = UDim2.fromOffset(dividedx,dividedy)
                    local screenSize = knowledge.main.AbsoluteSize
                    knowledge.mainbar = Instance.new("Frame", window.BackgroundImage)
                    knowledge.mainbar.Name = "KnowledgeFrame"
                    knowledge.mainbar.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    knowledge.mainbar.Visible = knowledge.Visible
                    knowledge.mainbar.BorderSizePixel = 0
                    knowledge.mainbar.ZIndex = 5
                    knowledge.AnchorPoint = Vector2.new(0.5,0.5)

                    knowledge.mainbar.Position = UDim2.new(0, dividedx , 0, dividedy )--UDim2.new(dividedx,0,dividedy,0)--button.Main.Position + UDim2.fromOffset(,1)-- UDim2.new(0, position and position.X or 10, 0, position and position.Y or 10)
                    knowledge.mainbar.Size = UDim2.new(0, 8, 0, 25)
                
                    knowledge.Gradient = Instance.new("UIGradient", knowledge.mainbar)
                    knowledge.Gradient.Rotation = 90
                    knowledge.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 10)) })
                
                    knowledge.Outline = Instance.new("Frame", knowledge.mainbar)
                    knowledge.Outline.Name = "outline"
                    knowledge.Outline.ZIndex = 4
                    knowledge.Outline.BorderSizePixel = 0
                    knowledge.Outline.Visible = knowledge.Visible
                    knowledge.Outline.BackgroundColor3 = library.theme.outlinecolor
                    knowledge.Outline.Position = UDim2.fromOffset(-1, -1)
                
                    knowledge.BlackOutline = Instance.new("Frame", knowledge.mainbar)
                    knowledge.BlackOutline.Name = "blackline"
                    knowledge.BlackOutline.ZIndex = 3
                    knowledge.BlackOutline.BorderSizePixel = 0
                    knowledge.BlackOutline.BackgroundColor3 = library.theme.outlinecolor2
                    knowledge.BlackOutline.Visible = knowledge.Visible
                    knowledge.BlackOutline.Position = UDim2.fromOffset(-2, -2)
                
                    knowledge.label = Instance.new("TextLabel", knowledge.mainbar)
                    knowledge.label.Name = "textlabel"
                    knowledge.label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    knowledge.label.BackgroundTransparency = 1.000
                    knowledge.label.Position = UDim2.new(0, 0, 0, 0)
                    knowledge.label.Size = UDim2.new(0, 238, 0, 25)
                    knowledge.label.Font = library.theme.font
                    knowledge.label.ZIndex = 6
                    knowledge.label.Visible = knowledge.Visible
                    knowledge.label.Text = button.knowledgemessage
                    knowledge.label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    knowledge.label.TextSize = 15
                    knowledge.label.TextStrokeTransparency = 0.000
                    knowledge.label.TextXAlignment = Enum.TextXAlignment.Left
                    knowledge.label.Size = UDim2.new(0, knowledge.label.TextBounds.X+10, 0, 25)
                    
                    knowledge.topbar = Instance.new("Frame", knowledge.mainbar)
                    knowledge.topbar.Name = "TopBar"
                    knowledge.topbar.ZIndex = 6
                    knowledge.topbar.BackgroundColor3 = library.theme.accentcolor
                    knowledge.topbar.BorderSizePixel = 0
                    knowledge.topbar.Visible = knowledge.Visible
                    knowledge.topbar.Size = UDim2.new(0, 0, 0, 1)
                
                    knowledge.mainbar.Size = UDim2.new(0, knowledge.label.TextBounds.X, 0, 25)
                    knowledge.topbar.Size = UDim2.new(0, knowledge.label.TextBounds.X+6, 0, 1)
                    knowledge.Outline.Size = knowledge.mainbar.Size + UDim2.fromOffset(2, 2)
                    knowledge.BlackOutline.Size = knowledge.mainbar.Size + UDim2.fromOffset(4, 4)
                
                    knowledge.mainbar.Size = UDim2.new(0, knowledge.label.TextBounds.X+4, 0, 25)    
                    knowledge.label.Size = UDim2.new(0, knowledge.label.TextBounds.X+4, 0, 25)
                    knowledge.topbar.Size = UDim2.new(0, knowledge.label.TextBounds.X+6, 0, 1)
                    knowledge.Outline.Size = knowledge.mainbar.Size + UDim2.fromOffset(2, 2)
                    knowledge.BlackOutline.Size = knowledge.mainbar.Size + UDim2.fromOffset(4, 4)
                    knowledge.label.ZIndex = 1000
                    knowledge.Outline.ZIndex = 1000
                    knowledge.mainbar.ZIndex = 1000
                    knowledge.BlackOutline.ZIndex = 1000
                    knowledge.topbar.ZIndex = 1000
                    local connection = game.Players.LocalPlayer:GetMouse().Move:Connect(function()
                        if knowledge.mainbar then 
                            local dividedy = (game.Players.LocalPlayer:GetMouse().Y / workspace.CurrentCamera.ViewportSize.Y)
                            local dividedx = (game.Players.LocalPlayer:GetMouse().X / workspace.CurrentCamera.ViewportSize.X)
                            --local udim = UDim2.new(0, mouse.X-script.Parent.Parent.AbsolutePosition.X, 0, mouse.Y-script.Parent.Parent.AbsolutePosition.Y) -- UDim2.new(0,game.Players.LocalPlayer:GetMouse().X + 20,0,game.Players.LocalPlayer:GetMouse().Y + 50) --
                            knowledge.mainbar.Position =  UDim2.new(0, mouse.X - 100, 0, mouse.Y - 200) -- UDim2.new(0, mouse.X-button.Main.AbsolutePosition.X+100, 0, mouse.Y-button.Main.AbsolutePosition.Y) -- +20
                        else
                            connection:Disconnect()
                        end
                    end)
                    
                    return knowledge
                end
                button.BlackOutline2.MouseEnter:Connect(function()
                    if getgenv().disablefeatures == true then return end
                    button.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    -- HINT
                    if button.hint == true then 
                        --print('added hint')
                        knowledge = button:AddKnowledgeButton()
                        knowledge.label.Text = button.knowledgemessage
                    end
                end)

                button.BlackOutline2.MouseLeave:Connect(function()
                    -- if getgenv().disablefeatures == true then return end
                    button.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    if button.hint == true then 
                        if window.BackgroundImage:FindFirstChild('KnowledgeFrame') then -- button.Main
                            --print('removed hint')
                            window.BackgroundImage:FindFirstChild('KnowledgeFrame'):Destroy()
                        end
                    end
                end)


                sector:FixSize()
                return button
            end

            function sector:AddLabel(text)
                local label = { }

                label.Main = Instance.new("TextLabel", sector.Items)
                label.Main.Name = "Label"
                label.Main.BackgroundTransparency = 1
                label.Main.Position = UDim2.new(0, -1, 0, 0)
                label.Main.ZIndex = 4
                label.Main.AutomaticSize = Enum.AutomaticSize.XY
                label.Main.Font = window.theme.font
                label.Main.Text = text
                label.Main.TextColor3 = window.theme.itemscolor
                label.Main.TextSize = 15
                label.Main.TextStrokeTransparency = 1
                label.Main.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    label.Main.Font = theme.font
                    label.Main.TextColor3 = theme.itemscolor
                end)

                function label:Set(value)
                    label.Main.Text = value
                end

                sector:FixSize()
                return label
            end
            
            function sector:AddToggle(text, default, callback, flag, properties)
                local toggle = { }
                toggle.text = text or ""
                toggle.default = default or false
                toggle.callback = callback or function(value) end
                toggle.flag = flag ~= nil and flag or text or ""; --flag or text or ""
                --print(toggle.flag)
                if properties then 
                    if properties.properties then 
                        for i,v in next, properties.properties do 
                            toggle[i] = v;
                        end
                    end
                end

                local convertedconfigtext = toggle.text;
                -- for i=1, string.len(convertedconfigtext) do 
                --     if convertedconfigtext:sub(i,i) == ' ' then -- Too Tact
                --         convertedconfigtext = convertedconfigtext:sub(1,i-1)..'_'convertedconfigtext:sub(i+1,string.len(convertedconfigtext))
                --     end
                -- end
                convertedconfigtext = string.gsub(convertedconfigtext,' ','_')
                -- print(convertedconfigtext, 'e')
                library.__configurations[convertedconfigtext] = toggle
                
                toggle.value = toggle.default

                toggle.Main = Instance.new("TextButton", sector.Items)
                toggle.Main.Name = "toggle"
                toggle.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggle.Main.BorderColor3 = window.theme.outlinecolor
                toggle.Main.BorderSizePixel = 0
                toggle.Main.Size = UDim2.fromOffset(8, 8)
                toggle.Main.AutoButtonColor = false
                toggle.Main.ZIndex = 5
                toggle.Main.Font = Enum.Font.SourceSans
                toggle.Main.Text = ""
                toggle.Main.TextColor3 = Color3.fromRGB(0, 0, 0)
                toggle.Main.TextSize = 15
                updateevent.Event:Connect(function(theme)
                    toggle.Main.BorderColor3 = theme.outlinecolor
                end)

                toggle.BlackOutline2 = Instance.new("Frame", toggle.Main)
                toggle.BlackOutline2.Name = "blackline"
                toggle.BlackOutline2.ZIndex = 4
                toggle.BlackOutline2.Size = toggle.Main.Size + UDim2.fromOffset(6, 6)
                toggle.BlackOutline2.BorderSizePixel = 0
                toggle.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                toggle.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                updateevent.Event:Connect(function(theme)
                    toggle.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                end)
                
                toggle.Outline = Instance.new("Frame", toggle.Main)
                toggle.Outline.Name = "blackline"
                toggle.Outline.ZIndex = 4
                toggle.Outline.Size = toggle.Main.Size + UDim2.fromOffset(4, 4)
                toggle.Outline.BorderSizePixel = 0
                toggle.Outline.BackgroundColor3 = window.theme.outlinecolor
                toggle.Outline.Position = UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    toggle.Outline.BackgroundColor3 = theme.outlinecolor
                end)

                toggle.BlackOutline = Instance.new("Frame", toggle.Main)
                toggle.BlackOutline.Name = "blackline"
                toggle.BlackOutline.ZIndex = 4
                toggle.BlackOutline.Size = toggle.Main.Size + UDim2.fromOffset(2, 2)
                toggle.BlackOutline.BorderSizePixel = 0
                toggle.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                toggle.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                updateevent.Event:Connect(function(theme)
                    toggle.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                end)

                toggle.Gradient = Instance.new("UIGradient", toggle.Main)
                toggle.Gradient.Rotation = (22.5 * 13)
                toggle.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(45, 45, 45)) })

                toggle.Label = Instance.new("TextButton", toggle.Main)
                toggle.Label.Name = "Label"
                toggle.Label.AutoButtonColor = false
                toggle.Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggle.Label.BackgroundTransparency = 1
                toggle.Label.Position = UDim2.fromOffset(toggle.Main.AbsoluteSize.X + 10, -2)
                toggle.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 71, toggle.BlackOutline.Size.Y.Offset)
                toggle.Label.Font = window.theme.font
                toggle.Label.ZIndex = 5
                toggle.Label.Text = toggle.text
                toggle.Label.TextColor3 = window.theme.itemscolor
                toggle.Label.TextSize = 15
                toggle.Label.TextStrokeTransparency = 1
                toggle.Label.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    toggle.Label.Font = theme.font
                    toggle.Label.TextColor3 = toggle.value and window.theme.itemscolor2 or theme.itemscolor
                end)

                toggle.CheckedFrame = Instance.new("Frame", toggle.Main)
                toggle.CheckedFrame.ZIndex = 5
                toggle.CheckedFrame.BorderSizePixel = 0
                toggle.CheckedFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Color3.fromRGB(204, 0, 102)
                toggle.CheckedFrame.Size = toggle.Main.Size

                toggle.Gradient2 = Instance.new("UIGradient", toggle.CheckedFrame)
                toggle.Gradient2.Rotation = (22.5 * 13)
                toggle.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor2), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor) })
                updateevent.Event:Connect(function(theme)
                    toggle.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor2), ColorSequenceKeypoint.new(1.00, theme.accentcolor) })
                end)

                toggle.Items = Instance.new("Frame", toggle.Main)
                toggle.Items.Name = "\n"
                toggle.Items.ZIndex = 4
                toggle.Items.Size = UDim2.fromOffset(60, toggle.BlackOutline.AbsoluteSize.Y)
                toggle.Items.BorderSizePixel = 0
                toggle.Items.BackgroundTransparency = 1
                toggle.Items.BackgroundColor3 = Color3.new(0, 0, 0)
                toggle.Items.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 71, 0)

                toggle.ListLayout = Instance.new("UIListLayout", toggle.Items)
                toggle.ListLayout.FillDirection = Enum.FillDirection.Horizontal
                toggle.ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                toggle.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                toggle.ListLayout.Padding = UDim.new(0.04, 6)

                if properties then 
                    if properties.hint then 
                        sector:CreateHintOnItem(toggle, properties.hint)
                    end;
                end;

                if toggle.flag and toggle.flag ~= "" then
                    library.flags[toggle.flag] = toggle.default or false
                end
                local visiblestuff = {}
                function toggle:MakeActiveToValue() 
                    value = toggle.value
                    if value then
                        for _,v in next, visiblestuff do 
                            for i,obj in next, window.storeobjects:GetChildren() do 
                                -- if obj == v then 
                                --     v.Main.Parent = sector.Items
                                -- end
                            end
                            --v.Main.Parent =sector.Items
                            --v.Main.Visible = true
                            local isdropdown = false
                            local isnotbutton = false
                            if v.Main and v.Main.Parent and v.Main.Parent.Name == 'backlabel'  then 
                                isnotbutton = true;
                                v.Main.Parent.Visible = true
                                -- for j,x in next, v.Main.Parent:GetChildren() do -- v.MainGetChildren()
                                --     if x:IsA('TextLabel') then 
                                --         x.Visible = false;
                                --     end
                                --     x.Visible = false;
                                --     --sector.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset,sector.Main.Size.Y.Offset - (v.Main.Parent.Size.Y.Offset*2))
                                --     isdropdown = true;
                                --     -- return
                                -- end
                            elseif v.Main and v.Main.Parent and v.Main.Parent.Name ==  'holder'  then  
                                isnotbutton = true;
                                --print(v.Main.Name)
                                v.Main.Parent.Visible = true;
                                local foundObj = false;
                                local ourobjindex = 0;
                                for u,parentobj in next, v.Main.Parent.Parent:GetChildren() do 
                                    for y,obj in next, v.Main.Parent.Parent:GetChildren() do   
                                        if obj == v.Main.Parent then foundObj = true; ourobjindex = y; end
                                    end
                                    
                                    if parentobj:IsA('TextButton') then 
                                        if v.Main.Parent:FindFirstChild('textbox').PlaceholderText == parentobj.Text and u==ourobjindex-1 then 
                                            parentobj.Visible = true
                                            break
                                        end
                                    end
                                end
                            elseif v.Main and v.Main.Parent and v.Main.Parent.Name == 'MainBack' then 
                                isnotbutton = true;
                                v.Main.Parent.Visible = true;
                            else
                                v.Main.Visible = true
                            end
                            if isnotbutton == false then 
                                sector.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset,sector.Main.Size.Y.Offset + (v.Main.Size.Y.Offset*2))
                            elseif isnotbutton == true then 
                                sector.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset,sector.Main.Size.Y.Offset + (v.Main.Parent.Size.Y.Offset*2))
                            end
                            --sector.Items.Size = UDim2.fromOffset(sector.Items.Size.X.Offset,sector.Items.Size.Y.Offset + (v.Main.Size.Y.Offset*3))
                        end
                        toggle.Label.TextColor3 = window.theme.itemscolor2
                    else
                        for _,v in next, visiblestuff do 
                            --v.Main.Parent = window.storeobjects
                            --v.Main.Visible = false
                            --local isdropdown = false
                            local isnotbutton = false
                            if v.Main and v.Main.Parent and v.Main.Parent.Name == 'backlabel'  then 
                                isnotbutton = true;
                                v.Main.Parent.Visible = false
                                -- for j,x in next, v.Main.Parent:GetChildren() do -- v.MainGetChildren()
                                --     if x:IsA('TextLabel') then 
                                --         x.Visible = false;
                                --     end
                                --     x.Visible = false;
                                --     --sector.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset,sector.Main.Size.Y.Offset - (v.Main.Parent.Size.Y.Offset*2))
                                --     isdropdown = true;
                                --     -- return
                                -- end
                            elseif v.Main and v.Main.Parent and v.Main.Parent.Name ==  'holder'  then  
                                isnotbutton = true;
                                --print(v.Main.Name)
                                v.Main.Parent.Visible = false;
                                local foundObj = false;
                                local ourobjindex = 0;
                                for u,parentobj in next, v.Main.Parent.Parent:GetChildren() do 
                                    for y,obj in next, v.Main.Parent.Parent:GetChildren() do   
                                        if obj == v.Main.Parent then foundObj = true; ourobjindex = y;  end -- print('Obj found. Index: '..ourobjindex)
                                    end
                                    
                                    if parentobj:IsA('TextButton') then 
                                        --print('is label: '..parentobj.Name)
                                        if v.Main.Parent:FindFirstChild('textbox').PlaceholderText == parentobj.Text and u==ourobjindex-1 then 
                                            parentobj.Visible = false
                                            break
                                        end
                                    end
                                end
                            elseif v.Main and v.Main.Parent and v.Main.Parent.Name == 'MainBack' then 
                                isnotbutton = true;
                                v.Main.Parent.Visible = false;
                            else
                                v.Main.Visible = false
                            end
                            --print(v.Main.Size)
                            --print('prev size '..tostring(sector.Main.Size))
                            -- 
                            if isnotbutton == false then 
                                sector.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset,sector.Main.Size.Y.Offset - (v.Main.Size.Y.Offset*2))
                            elseif isnotbutton == true then 
                                sector.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset,sector.Main.Size.Y.Offset - (v.Main.Parent.Size.Y.Offset*2))
                            end
                            
                            --sector.Items.Size = UDim2.fromOffset(sector.Items.Size.X.Offset,sector.Items.Size.Y.Offset - (v.Main.Size.Y.Offset*3))
                            --print('new size '..tostring(sector.Main.Size))
                            --print(v.Main.Size.Y.Offset)
                        end
                        toggle.Label.TextColor3 = window.theme.itemscolor
                    end
                end
                function toggle:MakeVisibleIfActive(makevisible)
                    table.insert(visiblestuff,makevisible)
                    toggle:MakeActiveToValue() 
                    -- task.spawn(function()
                    --     task.wait(1)
                    --     if toggle.value == true then 
                    --         for _,v in next, visiblestuff do 
                    --             v.Main.Visible = true
                    --         end
                    --     elseif toggle.value == false then
                    --         for _,v in next, visiblestuff do 
                    --             v.Main.Visible = false
                    --         end
                    --     end
                    -- end)

                end
                function toggle:RemoveVisibleWhenActive(makevisible)
                    for _,v in next, visiblestuff do 
                        if v == makevisible then 
                            table.remove(visiblestuff,_)
                        end
                    end
                    makevisible.Main.Visible = true;
                    -- table.insert(visiblestuff,makevisible)
                end
                function toggle:Set(value, wasclicked) 
                    local prevValue  = toggle.value -- valye 
                    local info = toggle.info -- ifno
                    if wasclicked and value == true and info then 
                        if info.shouldcheck ~= nil then  -- check
                            if library:CheckForPermission({ask = info.ask}) == false  then 
                                return
                            end
                        end
                    end
                    toggle.value = value
                    toggle.CheckedFrame.Visible = value
                    if toggle.flag and toggle.flag ~= "" then
                        library.flags[toggle.flag] = toggle.value
                    end
                    if prevValue ~= value then 
                        toggle:MakeActiveToValue() 
                    end
                    --print('was clicked '..tostring(wasclicked))
                    pcall(toggle.callback, value, wasclicked) -- wasclciked
                end
                function toggle:revert(value)
                    toggle.CheckedFrame.Visible = value
                end;
                function toggle:Get() 
                    return toggle.value
                end
                toggle:Set(toggle.default)


                function toggle:AddKeybind(default, flag)
                    local keybind = { }

                    keybind.default = default or "None"
                    keybind.value = keybind.default
                    keybind.flag = flag or ( (toggle.text or "") .. tostring(#toggle.Items:GetChildren()))

                    local shorter_keycodes = {
                        ["LeftShift"] = "LSHIFT",
                        ["RightShift"] = "RSHIFT",
                        ["LeftControl"] = "LCTRL",
                        ["RightControl"] = "RCTRL",
                        ["LeftAlt"] = "LALT",
                        ["RightAlt"] = "RALT"
                    }

                    local text = keybind.default == "None" and "[None]" or "[" .. (shorter_keycodes[keybind.default.Name] or keybind.default.Name) .. "]"
                    local size = textservice:GetTextSize(text, 15, window.theme.font, Vector2.new(2000, 2000))

                    keybind.Main = Instance.new("TextButton", toggle.Items)
                    keybind.Main.Name = "keybind"
                    keybind.Main.BackgroundTransparency = 1
                    keybind.Main.BorderSizePixel = 0
                    keybind.Main.ZIndex = 5
                    keybind.Main.Size = UDim2.fromOffset(size.X + 2, size.Y - 7)
                    keybind.Main.Text = text
                    keybind.Main.Font = window.theme.font
                    keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                    keybind.Main.TextSize = 15
                    keybind.Main.TextXAlignment = Enum.TextXAlignment.Right
                    keybind.Main.MouseButton1Down:Connect(function()
                        keybind.Main.Text = "[...]"
                        keybind.Main.TextColor3 = window.theme.accentcolor
                    end)
                    updateevent.Event:Connect(function(theme)
                        keybind.Main.Font = theme.font
                        if keybind.Main.Text == "[...]" then
                            keybind.Main.TextColor3 = theme.accentcolor
                        else
                            keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                        end
                    end)

                    if keybind.flag and keybind.flag ~= "" then
                        library.flags[keybind.flag] = keybind.default
                    end
                    function keybind:Set(key)
                        if key == "None" then
                            keybind.Main.Text = "[" .. key .. "]"
                            keybind.value = key
                            if keybind.flag and keybind.flag ~= "" then
                                library.flags[keybind.flag] = key
                            end
                        end
                        keybind.Main.Text = "[" .. (shorter_keycodes[key.Name] or key.Name) .. "]"
                        keybind.value = key
                        if keybind.flag and keybind.flag ~= "" then
                            library.flags[keybind.flag] = keybind.value
                        end
                    end

                    function keybind:Get()
                        return keybind.value
                    end
                    function keybind:Unbind()
                        keybind.Main.Text = "[" .. 'None' .. "]"
                        keybind.value = 'None'
                        if keybind.flag and keybind.flag ~= "" then
                            library.flags[keybind.flag] = key
                        end
                        keybind:Set("None")
                    end
                    uis.InputBegan:Connect(function(input, gameProcessed)
                        if not gameProcessed then
                            if keybind.Main.Text == "[...]" then
                                keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                                if input.UserInputType == Enum.UserInputType.Keyboard then
                                    keybind:Set(input.KeyCode)
                                else
                                    keybind:Set("None")
                                end
                            else
                                if keybind.value ~= "None" and input.KeyCode == keybind.value then
                                    toggle:Set(not toggle.CheckedFrame.Visible)
                                end
                            end
                        end
                    end)

                    table.insert(library.items, keybind)
                    return keybind
                end

                function toggle:AddDropdown(items, default, multichoice, callback, flag)
                    local dropdown = { }

                    dropdown.defaultitems = items or { }
                    dropdown.default = default
                    dropdown.callback = callback or function() end
                    dropdown.multichoice = multichoice or false
                    dropdown.values = { }
                    dropdown.flag = flag or ( (toggle.text or "") .. tostring(#(sector.Items:GetChildren())) .. "a")
    
                    dropdown.Main = Instance.new("TextButton", sector.Items)
                    dropdown.Main.Name = "dropdown"
                    dropdown.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.Main.BorderSizePixel = 0
                    dropdown.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 16)
                    dropdown.Main.Position = UDim2.fromOffset(0, 0)
                    dropdown.Main.ZIndex = 5
                    dropdown.Main.AutoButtonColor = false
                    dropdown.Main.Font = window.theme.font
                    dropdown.Main.Text = ""
                    dropdown.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.Main.TextSize = 15
                    dropdown.Main.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        dropdown.Main.Font = theme.font
                    end)
    
                    dropdown.Gradient = Instance.new("UIGradient", dropdown.Main)
                    dropdown.Gradient.Rotation = 90
                    dropdown.Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39))}
    
                    dropdown.SelectedLabel = Instance.new("TextLabel", dropdown.Main)
                    dropdown.SelectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.SelectedLabel.BackgroundTransparency = 1
                    dropdown.SelectedLabel.Position = UDim2.fromOffset(5, 2)
                    dropdown.SelectedLabel.Size = UDim2.fromOffset(130, 13)
                    dropdown.SelectedLabel.Font = window.theme.font
                    dropdown.SelectedLabel.Text = toggle.text
                    dropdown.SelectedLabel.ZIndex = 5
                    dropdown.SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.SelectedLabel.TextSize = 15
                    dropdown.SelectedLabel.TextStrokeTransparency = 1
                    dropdown.SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        dropdown.SelectedLabel.Font = theme.font
                    end)  

                    dropdown.Nav = Instance.new("ImageButton", dropdown.Main)
                    dropdown.Nav.Name = "navigation"
                    dropdown.Nav.BackgroundTransparency = 1
                    dropdown.Nav.LayoutOrder = 10
                    dropdown.Nav.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 5)
                    dropdown.Nav.Rotation = 90
                    dropdown.Nav.ZIndex = 5
                    dropdown.Nav.Size = UDim2.fromOffset(8, 8)
                    dropdown.Nav.Image = "rbxassetid://4918373417"
                    dropdown.Nav.ImageColor3 = Color3.fromRGB(210, 210, 210)
    
                    dropdown.BlackOutline2 = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline2.Name = "blackline"
                    dropdown.BlackOutline2.ZIndex = 4
                    dropdown.BlackOutline2.Size = dropdown.Main.Size + UDim2.fromOffset(6, 6)
                    dropdown.BlackOutline2.BorderSizePixel = 0
                    dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    dropdown.Outline = Instance.new("Frame", dropdown.Main)
                    dropdown.Outline.Name = "blackline"
                    dropdown.Outline.ZIndex = 4
                    dropdown.Outline.Size = dropdown.Main.Size + UDim2.fromOffset(4, 4)
                    dropdown.Outline.BorderSizePixel = 0
                    dropdown.Outline.BackgroundColor3 = window.theme.outlinecolor
                    dropdown.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        dropdown.Outline.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    dropdown.BlackOutline = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline.Name = "blackline444"
                    dropdown.BlackOutline.ZIndex = 4
                    dropdown.BlackOutline.Size = dropdown.Main.Size + UDim2.fromOffset(2, 2)
                    dropdown.BlackOutline.BorderSizePixel = 0
                    dropdown.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    dropdown.ItemsFrame = Instance.new("ScrollingFrame", dropdown.Main)
                    dropdown.ItemsFrame.Name = "itemsframe"
                    dropdown.ItemsFrame.BorderSizePixel = 0
                    dropdown.ItemsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    dropdown.ItemsFrame.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                    dropdown.ItemsFrame.ScrollBarThickness = 2
                    dropdown.ItemsFrame.ZIndex = 8
                    dropdown.ItemsFrame.ScrollingDirection = "Y"
                    dropdown.ItemsFrame.Visible = false
                    dropdown.ItemsFrame.Size = UDim2.new(0, 0, 0, 0)
                    dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.Main.AbsoluteSize.X, 0)
    
                    dropdown.ListLayout = Instance.new("UIListLayout", dropdown.ItemsFrame)
                    dropdown.ListLayout.FillDirection = Enum.FillDirection.Vertical
                    dropdown.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
                    dropdown.ListPadding = Instance.new("UIPadding", dropdown.ItemsFrame)
                    dropdown.ListPadding.PaddingTop = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingBottom = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingLeft = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingRight = UDim.new(0, 2)
    
                    dropdown.BlackOutline2Items = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline2Items.Name = "blackline3"
                    dropdown.BlackOutline2Items.ZIndex = 7
                    dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                    dropdown.BlackOutline2Items.BorderSizePixel = 0
                    dropdown.BlackOutline2Items.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline2Items.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-3, -3)
                    dropdown.BlackOutline2Items.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline2Items.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    dropdown.OutlineItems = Instance.new("Frame", dropdown.Main)
                    dropdown.OutlineItems.Name = "blackline8"
                    dropdown.OutlineItems.ZIndex = 7
                    dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                    dropdown.OutlineItems.BorderSizePixel = 0
                    dropdown.OutlineItems.BackgroundColor3 = window.theme.outlinecolor
                    dropdown.OutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-2, -2)
                    dropdown.OutlineItems.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.OutlineItems.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    dropdown.BlackOutlineItems = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutlineItems.Name = "blackline3"
                    dropdown.BlackOutlineItems.ZIndex = 7
                    dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(-2, -2)
                    dropdown.BlackOutlineItems.BorderSizePixel = 0
                    dropdown.BlackOutlineItems.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-1, -1)
                    dropdown.BlackOutlineItems.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutlineItems.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    dropdown.IgnoreBackButtons = Instance.new("TextButton", dropdown.Main)
                    dropdown.IgnoreBackButtons.BackgroundTransparency = 1
                    dropdown.IgnoreBackButtons.BorderSizePixel = 0
                    dropdown.IgnoreBackButtons.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                    dropdown.IgnoreBackButtons.Size = UDim2.new(0, 0, 0, 0)
                    dropdown.IgnoreBackButtons.ZIndex = 7
                    dropdown.IgnoreBackButtons.Text = ""
                    dropdown.IgnoreBackButtons.Visible = false
                    dropdown.IgnoreBackButtons.AutoButtonColor = false

                    if dropdown.flag and dropdown.flag ~= "" then
                        library.flags[dropdown.flag] = dropdown.multichoice and { dropdown.default or dropdown.defaultitems[1] or "" } or (dropdown.default or dropdown.defaultitems[1] or "")
                    end

                    function dropdown:isSelected(item)
                        for i, v in pairs(dropdown.values) do
                            if v == item then
                                return true
                            end
                        end
                        return false
                    end
    
                    function dropdown:updateText(text)
                        if #text >= 27 then
                            text = text:sub(1, 25) .. ".."
                        end
                        dropdown.SelectedLabel.Text = text
                    end
    
                    dropdown.Changed = Instance.new("BindableEvent")
                    function dropdown:Set(value)
                        if type(value) == "table" then
                            dropdown.values = value
                            dropdown:updateText(table.concat(value, ", "))
                            pcall(dropdown.callback, value)
                        else
                            dropdown:updateText(value)
                            dropdown.values = { value }
                            pcall(dropdown.callback, value)
                        end
                        
                        dropdown.Changed:Fire(value)
                        if dropdown.flag and dropdown.flag ~= "" then
                            library.flags[dropdown.flag] = dropdown.multichoice and dropdown.values or dropdown.values[1]
                        end
                    end
    
                    function dropdown:Get()
                        return dropdown.multichoice and dropdown.values or dropdown.values[1]
                    end
    
                    dropdown.items = { }
                    function dropdown:Add(v)
                        local Item = Instance.new("TextButton", dropdown.ItemsFrame)
                        Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Item.BorderSizePixel = 0
                        Item.Position = UDim2.fromOffset(0, 0)
                        Item.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset - 4, 20)
                        Item.ZIndex = 9
                        Item.Text = v
                        Item.Name = v
                        Item.AutoButtonColor = false
                        Item.Font = window.theme.font
                        Item.TextSize = 15
                        Item.TextXAlignment = Enum.TextXAlignment.Left
                        Item.TextStrokeTransparency = 1
                        dropdown.ItemsFrame.CanvasSize = dropdown.ItemsFrame.CanvasSize + UDim2.fromOffset(0, Item.AbsoluteSize.Y)
    
                        Item.MouseButton1Down:Connect(function()
                            if dropdown.multichoice then
                                if dropdown:isSelected(v) then
                                    for i2, v2 in pairs(dropdown.values) do
                                        if v2 == v then
                                            table.remove(dropdown.values, i2)
                                        end
                                    end
                                    dropdown:Set(dropdown.values)
                                else
                                    table.insert(dropdown.values, v)
                                    dropdown:Set(dropdown.values)
                                end
    
                                return
                            else
                                dropdown.Nav.Rotation = 90
                                dropdown.ItemsFrame.Visible = false
                                dropdown.ItemsFrame.Active = false
                                dropdown.OutlineItems.Visible = false
                                dropdown.BlackOutlineItems.Visible = false
                                dropdown.BlackOutline2Items.Visible = false
                                dropdown.IgnoreBackButtons.Visible = false
                                dropdown.IgnoreBackButtons.Active = false
                            end
    
                            dropdown:Set(v)
                            return
                        end)
    
                        runservice.RenderStepped:Connect(function()
                            if dropdown.multichoice and dropdown:isSelected(v) or dropdown.values[1] == v then
                                Item.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
                                Item.TextColor3 = window.theme.accentcolor
                                Item.Text = " " .. v
                            else
                                Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Item.Text = v
                            end
                        end)
    
                        table.insert(dropdown.items, v)
                        dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * Item.AbsoluteSize.Y, 20, 156) + 4)
                        dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * Item.AbsoluteSize.Y) + 4)
    
                        dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                        dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                        dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                        dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
                    end
    
                    function dropdown:Remove(value)
                        local item = dropdown.ItemsFrame:FindFirstChild(value)
                        if item then
                            for i,v in pairs(dropdown.items) do
                                if v == value then
                                    table.remove(dropdown.items, i)
                                end
                            end
    
                            dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * item.AbsoluteSize.Y, 20, 156) + 4)
                            dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * item.AbsoluteSize.Y) + 4)
        
                            dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                            dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                            dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                            dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
    
                            item:Remove()
                        end
                    end 
    
                    for i,v in pairs(dropdown.defaultitems) do
                        dropdown:Add(v)
                    end
    
                    if dropdown.default then
                        dropdown:Set(dropdown.default)
                    end
    
                    local MouseButton1Down = function()
                        if dropdown.Nav.Rotation == 90 then
                            tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = -90 }):Play()
                            if dropdown.items and #dropdown.items ~= 0 then
                                dropdown.ItemsFrame.ScrollingEnabled = true
                                sector.Main.Parent.ScrollingEnabled = false
                                dropdown.ItemsFrame.Visible = true
                                dropdown.ItemsFrame.Active = true
                                dropdown.IgnoreBackButtons.Visible = true
                                dropdown.IgnoreBackButtons.Active = true
                                dropdown.OutlineItems.Visible = true
                                dropdown.BlackOutlineItems.Visible = true
                                dropdown.BlackOutline2Items.Visible = true
                            end
                        else
                            tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 90 }):Play()
                            dropdown.ItemsFrame.ScrollingEnabled = false
                            sector.Main.Parent.ScrollingEnabled = true
                            dropdown.ItemsFrame.Visible = false
                            dropdown.ItemsFrame.Active = false
                            dropdown.IgnoreBackButtons.Visible = false
                            dropdown.IgnoreBackButtons.Active = false
                            dropdown.OutlineItems.Visible = false
                            dropdown.BlackOutlineItems.Visible = false
                            dropdown.BlackOutline2Items.Visible = false
                        end
                    end
    
                    dropdown.Main.MouseButton1Down:Connect(MouseButton1Down)
                    dropdown.Nav.MouseButton1Down:Connect(MouseButton1Down)
    
                    dropdown.BlackOutline2.MouseEnter:Connect(function()
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    dropdown.BlackOutline2.MouseLeave:Connect(function()
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)
    
                    sector:FixSize()
                    table.insert(library.items, dropdown)
                    return dropdown
                end

                function toggle:AddTextbox(default, callback, flag)
                    local textbox = { }
                    textbox.callback = callback or function() end
                    textbox.default = default
                    textbox.value = ""
                    textbox.flag = flag or ( (toggle.text or "") .. tostring(#(sector.Items:GetChildren())) .. "a")
    
                    textbox.Holder = Instance.new("Frame", sector.Items)
                    textbox.Holder.Name = "holder"
                    textbox.Holder.ZIndex = 5
                    textbox.Holder.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 14)
                    textbox.Holder.BorderSizePixel = 0
                    textbox.Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
                    textbox.Gradient = Instance.new("UIGradient", textbox.Holder)
                    textbox.Gradient.Rotation = 90
                    textbox.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39)) })
    
                    textbox.Main = Instance.new("TextBox", textbox.Holder)
                    textbox.Main.PlaceholderText = ""
                    textbox.Main.Text = ""
                    textbox.Main.BackgroundTransparency = 1
                    textbox.Main.Font = window.theme.font
                    textbox.Main.Name = "textbox"
                    textbox.Main.MultiLine = false
                    textbox.Main.ClearTextOnFocus = false
                    textbox.Main.ZIndex = 5
                    textbox.Main.TextScaled = true
                    textbox.Main.Size = textbox.Holder.Size
                    textbox.Main.TextSize = 15
                    textbox.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textbox.Main.BorderSizePixel = 0
                    textbox.Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    textbox.Main.TextXAlignment = Enum.TextXAlignment.Left
    
                    if textbox.flag and textbox.flag ~= "" then
                        library.flags[textbox.flag] = textbox.default or ""
                    end

                    function textbox:Set(text)
                        textbox.value = text
                        textbox.Main.Text = text
                        if textbox.flag and textbox.flag ~= "" then
                            library.flags[textbox.flag] = text
                        end
                        pcall(textbox.callback, text)
                    end
                    updateevent.Event:Connect(function(theme)
                        textbox.Main.Font = theme.font
                    end)
    
                    function textbox:Get()
                        return textbox.value
                    end
    
                    if textbox.default then 
                        textbox:Set(textbox.default)
                    end
    
                    textbox.Main.FocusLost:Connect(function()
                        textbox:Set(textbox.Main.Text)
                    end)
    
                    textbox.BlackOutline2 = Instance.new("Frame", textbox.Main)
                    textbox.BlackOutline2.Name = "blackline"
                    textbox.BlackOutline2.ZIndex = 4
                    textbox.BlackOutline2.Size = textbox.Main.Size + UDim2.fromOffset(6, 6)
                    textbox.BlackOutline2.BorderSizePixel = 0
                    textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    textbox.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        textbox.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    textbox.Outline = Instance.new("Frame", textbox.Main)
                    textbox.Outline.Name = "blackline"
                    textbox.Outline.ZIndex = 4
                    textbox.Outline.Size = textbox.Main.Size + UDim2.fromOffset(4, 4)
                    textbox.Outline.BorderSizePixel = 0
                    textbox.Outline.BackgroundColor3 = window.theme.outlinecolor
                    textbox.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        textbox.Outline.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    textbox.BlackOutline = Instance.new("Frame", textbox.Main)
                    textbox.BlackOutline.Name = "blackline"
                    textbox.BlackOutline.ZIndex = 4
                    textbox.BlackOutline.Size = textbox.Main.Size + UDim2.fromOffset(2, 2)
                    textbox.BlackOutline.BorderSizePixel = 0
                    textbox.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    textbox.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        textbox.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    textbox.BlackOutline2.MouseEnter:Connect(function()
                        textbox.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    textbox.BlackOutline2.MouseLeave:Connect(function()
                        textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)
    
                    sector:FixSize()
                    table.insert(library.items, textbox)
                    return textbox
                end

                function toggle:AddColorpicker(default, callback, flag)
                    local colorpicker = { }

                    colorpicker.iscolorpicker = true;
                    colorpicker.callback = callback or function() end
                    colorpicker.default = default or Color3.fromRGB(255, 255, 255)
                    colorpicker.value = colorpicker.default
                    colorpicker.flag = flag or ( (toggle.text or "") .. tostring(#toggle.Items:GetChildren()))

                    colorpicker.Main = Instance.new("Frame", toggle.Items)
                    colorpicker.Main.ZIndex = 6
                    colorpicker.Main.BorderSizePixel = 0
                    colorpicker.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    colorpicker.Main.Size = UDim2.fromOffset(16, 10)

                    colorpicker.Gradient = Instance.new("UIGradient", colorpicker.Main)
                    colorpicker.Gradient.Rotation = 90

                    local clr = Color3.new(math.clamp(colorpicker.value.R / 1.7, 0, 1), math.clamp(colorpicker.value.G / 1.7, 0, 1), math.clamp(colorpicker.value.B / 1.7, 0, 1))
                    colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, colorpicker.value), ColorSequenceKeypoint.new(1.00, clr) })

                    colorpicker.BlackOutline2 = Instance.new("Frame", colorpicker.Main)
                    colorpicker.BlackOutline2.Name = "blackline"
                    colorpicker.BlackOutline2.ZIndex = 4
                    colorpicker.BlackOutline2.Size = colorpicker.Main.Size + UDim2.fromOffset(6, 6)
                    colorpicker.BlackOutline2.BorderSizePixel = 0
                    colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        if window.OpenedColorPickers[colorpicker.MainPicker] then
                            colorpicker.BlackOutline2.BackgroundColor3 = theme.accentcolor
                        else
                            colorpicker.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                        end
                    end)
                    
                    colorpicker.Outline = Instance.new("Frame", colorpicker.Main)
                    colorpicker.Outline.Name = "blackline"
                    colorpicker.Outline.ZIndex = 4
                    colorpicker.Outline.Size = colorpicker.Main.Size + UDim2.fromOffset(4, 4)
                    colorpicker.Outline.BorderSizePixel = 0
                    colorpicker.Outline.BackgroundColor3 = window.theme.outlinecolor
                    colorpicker.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.Outline.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    colorpicker.BlackOutline = Instance.new("Frame", colorpicker.Main)
                    colorpicker.BlackOutline.Name = "blackline"
                    colorpicker.BlackOutline.ZIndex = 4
                    colorpicker.BlackOutline.Size = colorpicker.Main.Size + UDim2.fromOffset(2, 2)
                    colorpicker.BlackOutline.BorderSizePixel = 0
                    colorpicker.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    colorpicker.BlackOutline2.MouseEnter:Connect(function()
                        colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)

                    colorpicker.BlackOutline2.MouseLeave:Connect(function()
                        if not window.OpenedColorPickers[colorpicker.MainPicker] then
                            colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        end
                    end)

                    colorpicker.MainPicker = Instance.new("TextButton", colorpicker.Main)
                    colorpicker.MainPicker.Name = "picker"
                    colorpicker.MainPicker.ZIndex = 100
                    colorpicker.MainPicker.Visible = false
                    colorpicker.MainPicker.AutoButtonColor = false
                    colorpicker.MainPicker.Text = ""
                    window.OpenedColorPickers[colorpicker.MainPicker] = false
                    colorpicker.MainPicker.Size = UDim2.fromOffset(180, 196)
                    colorpicker.MainPicker.BorderSizePixel = 0
                    colorpicker.MainPicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    colorpicker.MainPicker.Rotation = 0.000000000000001
                    colorpicker.MainPicker.Position = UDim2.fromOffset(-colorpicker.MainPicker.AbsoluteSize.X + colorpicker.Main.AbsoluteSize.X, 17)

                    colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                    colorpicker.BlackOutline3.Name = "blackline"
                    colorpicker.BlackOutline3.ZIndex = 98
                    colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(6, 6)
                    colorpicker.BlackOutline3.BorderSizePixel = 0
                    colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline3.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    colorpicker.Outline2 = Instance.new("Frame", colorpicker.MainPicker)
                    colorpicker.Outline2.Name = "blackline"
                    colorpicker.Outline2.ZIndex = 98
                    colorpicker.Outline2.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(4, 4)
                    colorpicker.Outline2.BorderSizePixel = 0
                    colorpicker.Outline2.BackgroundColor3 = window.theme.outlinecolor
                    colorpicker.Outline2.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.Outline2.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                    colorpicker.BlackOutline3.Name = "blackline"
                    colorpicker.BlackOutline3.ZIndex = 98
                    colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(2, 2)
                    colorpicker.BlackOutline3.BorderSizePixel = 0
                    colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline3.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                    end)

                    colorpicker.hue = Instance.new("ImageLabel", colorpicker.MainPicker)
                    colorpicker.hue.ZIndex = 101
                    colorpicker.hue.Position = UDim2.new(0,3,0,3)
                    colorpicker.hue.Size = UDim2.new(0,172,0,172)
                    colorpicker.hue.Image = "rbxassetid://4155801252"
                    colorpicker.hue.ScaleType = Enum.ScaleType.Stretch
                    colorpicker.hue.BackgroundColor3 = Color3.new(1,0,0)
                    colorpicker.hue.BorderColor3 = window.theme.outlinecolor2
                    updateevent.Event:Connect(function(theme)
                        colorpicker.hue.BorderColor3 = theme.outlinecolor2
                    end)

                    colorpicker.hueselectorpointer = Instance.new("ImageLabel", colorpicker.MainPicker)
                    colorpicker.hueselectorpointer.ZIndex = 101
                    colorpicker.hueselectorpointer.BackgroundTransparency = 1
                    colorpicker.hueselectorpointer.BorderSizePixel = 0
                    colorpicker.hueselectorpointer.Position = UDim2.new(0, 0, 0, 0)
                    colorpicker.hueselectorpointer.Size = UDim2.new(0, 7, 0, 7)
                    colorpicker.hueselectorpointer.Image = "rbxassetid://6885856475"

                    colorpicker.selector = Instance.new("TextLabel", colorpicker.MainPicker)
                    colorpicker.selector.ZIndex = 100
                    colorpicker.selector.Position = UDim2.new(0,3,0,181)
                    colorpicker.selector.Size = UDim2.new(0,173,0,10)
                    colorpicker.selector.BackgroundColor3 = Color3.fromRGB(255,255,255)
                    colorpicker.selector.BorderColor3 = window.theme.outlinecolor2
                    colorpicker.selector.Text = ""
                    updateevent.Event:Connect(function(theme)
                        colorpicker.selector.BorderColor3 = theme.outlinecolor2
                    end)
        
                    colorpicker.gradient = Instance.new("UIGradient", colorpicker.selector)
                    colorpicker.gradient.Color = ColorSequence.new({ 
                        ColorSequenceKeypoint.new(0, Color3.new(1,0,0)), 
                        ColorSequenceKeypoint.new(0.17, Color3.new(1,0,1)), 
                        ColorSequenceKeypoint.new(0.33,Color3.new(0,0,1)), 
                        ColorSequenceKeypoint.new(0.5,Color3.new(0,1,1)), 
                        ColorSequenceKeypoint.new(0.67, Color3.new(0,1,0)), 
                        ColorSequenceKeypoint.new(0.83, Color3.new(1,1,0)), 
                        ColorSequenceKeypoint.new(1, Color3.new(1,0,0))
                    })

                    colorpicker.pointer = Instance.new("Frame", colorpicker.selector)
                    colorpicker.pointer.ZIndex = 101
                    colorpicker.pointer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    colorpicker.pointer.Position = UDim2.new(0,0,0,0)
                    colorpicker.pointer.Size = UDim2.new(0,2,0,10)
                    colorpicker.pointer.BorderColor3 = Color3.fromRGB(255, 255, 255)

                    if colorpicker.flag and colorpicker.flag ~= "" then
                        library.flags[colorpicker.flag] = colorpicker.default
                    end

                    function colorpicker:RefreshHue()
                        local x = (mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X
                        local y = (mouse.Y - colorpicker.hue.AbsolutePosition.Y) / colorpicker.hue.AbsoluteSize.Y
                        colorpicker.hueselectorpointer:TweenPosition(UDim2.new(math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 0.952 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 0, math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 0.885 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 1 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 1 - (math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 1 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y)))
                    end

                    function colorpicker:RefreshSelector()
                        local pos = math.clamp((mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X, 0, 1)
                        colorpicker.color = 1 - pos
                        colorpicker.pointer:TweenPosition(UDim2.new(pos, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        colorpicker.hue.BackgroundColor3 = Color3.fromHSV(1 - pos, 1, 1)

                        local x = (colorpicker.hueselectorpointer.AbsolutePosition.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X
                        local y = (colorpicker.hueselectorpointer.AbsolutePosition.Y - colorpicker.hue.AbsolutePosition.Y) / colorpicker.hue.AbsoluteSize.Y
                        colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 1 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 1 - (math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 1 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y)))
                    end

                    function colorpicker:Set(value)
                        local color = Color3.new(math.clamp(value.r, 0, 1), math.clamp(value.g, 0, 1), math.clamp(value.b, 0, 1))
                        colorpicker.value = color
                        if colorpicker.flag and colorpicker.flag ~= "" then
                            library.flags[colorpicker.flag] = color
                        end
                        local clr = Color3.new(math.clamp(color.R / 1.7, 0, 1), math.clamp(color.G / 1.7, 0, 1), math.clamp(color.B / 1.7, 0, 1))
                        colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, color), ColorSequenceKeypoint.new(1.00, clr) })
                        pcall(colorpicker.callback, color)
                    end

                    function colorpicker:Get(value)
                        return colorpicker.value
                    end
                    colorpicker:Set(colorpicker.default)

                    local dragging_selector = false
                    local dragging_hue = false

                    colorpicker.selector.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_selector = true
                            colorpicker:RefreshSelector()
                        end
                    end)
    
                    colorpicker.selector.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_selector = false
                            colorpicker:RefreshSelector()
                        end
                    end)

                    colorpicker.hue.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_hue = true
                            colorpicker:RefreshHue()
                        end
                    end)
    
                    colorpicker.hue.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_hue = false
                            colorpicker:RefreshHue()
                        end
                    end)
    
                    uis.InputChanged:Connect(function(input)
                        if dragging_selector and input.UserInputType == Enum.UserInputType.MouseMovement then
                            colorpicker:RefreshSelector()
                        end
                        if dragging_hue and input.UserInputType == Enum.UserInputType.MouseMovement then
                            colorpicker:RefreshHue()
                        end
                    end)

                    local inputBegan = function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            for i,v in pairs(window.OpenedColorPickers) do
                                if v and i ~= colorpicker.MainPicker then
                                    i.Visible = false
                                    window.OpenedColorPickers[i] = false
                                end
                            end

                            colorpicker.MainPicker.Visible = not colorpicker.MainPicker.Visible
                            window.OpenedColorPickers[colorpicker.MainPicker] = colorpicker.MainPicker.Visible
                            if window.OpenedColorPickers[colorpicker.MainPicker] then
                                colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                            else
                                colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                            end
                        end
                    end

                    colorpicker.Main.InputBegan:Connect(inputBegan)
                    colorpicker.Outline.InputBegan:Connect(inputBegan)
                    colorpicker.BlackOutline2.InputBegan:Connect(inputBegan)
                    table.insert(library.items, colorpicker)
                    return colorpicker
                end

                function toggle:AddSlider(min, default, max, decimals, callback, flag)
                    local slider = { }
                    slider.text = text or ""
                    slider.callback = callback or function(value) end
                    slider.min = min or 0
                    slider.max = max or 100
                    slider.decimals = decimals or 1
                    slider.default = default or slider.min
                    slider.flag = flag or ( (toggle.text or "") .. tostring(#toggle.Items:GetChildren()))
    
                    slider.value = slider.default
                    local dragging = false
    
                    slider.Main = Instance.new("TextButton", sector.Items)
                    slider.Main.Name = "slider"
                    slider.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    slider.Main.Position = UDim2.fromOffset(0, 0)
                    slider.Main.BorderSizePixel = 0
                    slider.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 12)
                    slider.Main.AutoButtonColor = false
                    slider.Main.Text = ""
                    slider.Main.ZIndex = 7

                    slider.InputLabel = Instance.new("TextLabel", slider.Main)
                    slider.InputLabel.BackgroundTransparency = 1
                    slider.InputLabel.Size = slider.Main.Size
                    slider.InputLabel.Font = window.theme.font
                    slider.InputLabel.Text = "0"
                    slider.InputLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
                    slider.InputLabel.Position = slider.Main.Position
                    slider.InputLabel.Selectable = false
                    slider.InputLabel.TextSize = 15
                    slider.InputLabel.ZIndex = 9
                    slider.InputLabel.TextStrokeTransparency = 1
                    slider.InputLabel.TextXAlignment = Enum.TextXAlignment.Center
                    updateevent.Event:Connect(function(theme)
                        slider.InputLabel.Font = theme.font
                        slider.InputLabel.TextColor3 = theme.itemscolor
                    end)
    
                    slider.BlackOutline2 = Instance.new("Frame", slider.Main)
                    slider.BlackOutline2.Name = "blackline"
                    slider.BlackOutline2.ZIndex = 4
                    slider.BlackOutline2.Size = slider.Main.Size + UDim2.fromOffset(6, 6)
                    slider.BlackOutline2.BorderSizePixel = 0
                    slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    slider.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        slider.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    slider.Outline = Instance.new("Frame", slider.Main)
                    slider.Outline.Name = "blackline"
                    slider.Outline.ZIndex = 4
                    slider.Outline.Size = slider.Main.Size + UDim2.fromOffset(4, 4)
                    slider.Outline.BorderSizePixel = 0
                    slider.Outline.BackgroundColor3 = window.theme.outlinecolor
                    slider.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        slider.Outline.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    slider.BlackOutline = Instance.new("Frame", slider.Main)
                    slider.BlackOutline.Name = "blackline"
                    slider.BlackOutline.ZIndex = 4
                    slider.BlackOutline.Size = slider.Main.Size + UDim2.fromOffset(2, 2)
                    slider.BlackOutline.BorderSizePixel = 0
                    slider.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    slider.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        slider.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    slider.Gradient = Instance.new("UIGradient", slider.Main)
                    slider.Gradient.Rotation = 90
                    slider.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(41, 41, 41)) })
    
                    slider.SlideBar = Instance.new("Frame", slider.Main)
                    slider.SlideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) --Color3.fromRGB(204, 0, 102)
                    slider.SlideBar.ZIndex = 8
                    slider.SlideBar.BorderSizePixel = 0
                    slider.SlideBar.Size = UDim2.fromOffset(0, slider.Main.Size.Y.Offset)
    
                    slider.Gradient2 = Instance.new("UIGradient", slider.SlideBar)
                    slider.Gradient2.Rotation = 90
                    slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor2) })
                    updateevent.Event:Connect(function(theme)
                        slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor), ColorSequenceKeypoint.new(1.00, theme.accentcolor2) })
                    end)
    
                    slider.BlackOutline2.MouseEnter:Connect(function()
                        if getgenv().disablefeatures == true then return end
                        slider.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    slider.BlackOutline2.MouseLeave:Connect(function()
                        if getgenv().disablefeatures == true then return end
                        slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)
    
                    if slider.flag and slider.flag ~= "" then
                        library.flags[slider.flag] = slider.default or slider.min or 0
                    end

                    function slider:Get()
                        return slider.value
                    end
    
                    function slider:Set(value)
                        slider.value = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
                        local percent = 1 - ((slider.max - slider.value) / (slider.max - slider.min))
                        if slider.flag and slider.flag ~= "" then
                            library.flags[slider.flag] = slider.value
                        end
                        -- print(slider.value)
                        -- print('setting')
                        -- if slider.value < 0 then 
                        --     slider.SlideBar:TweenSize(UDim2.fromOffset(-(percent * slider.Main.AbsoluteSize.X), slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        -- else
                        --     slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        -- end
                        
                        slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        slider.InputLabel.Text = slider.value
                        pcall(slider.callback, slider.value)
                    end
                    slider:Set(slider.default)
    
                    function slider:Refresh()
                        local mousePos = camera:WorldToViewportPoint(mouse.Hit.p)
                        local percent = math.clamp(mousePos.X - slider.SlideBar.AbsolutePosition.X, 0, slider.Main.AbsoluteSize.X) / slider.Main.AbsoluteSize.X
                        local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                        value = math.clamp(value, slider.min, slider.max)
                        slider:Set(value)
                    end
    
                    slider.SlideBar.InputBegan:Connect(function(input)
                        if getgenv().disablefeatures == true then return end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            slider:Refresh()
                        end
                    end)
    
                    slider.SlideBar.InputEnded:Connect(function(input)
                        if getgenv().disablefeatures == true then return end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
    
                    slider.Main.InputBegan:Connect(function(input)
                        if getgenv().disablefeatures == true then return end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            slider:Refresh()
                        end
                    end)
    
                    slider.Main.InputEnded:Connect(function(input)
                        if getgenv().disablefeatures == true then return end
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
    
                    uis.InputChanged:Connect(function(input)
                        if getgenv().disablefeatures == true then return end
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            slider:Refresh()
                        end
                    end)
    
                    sector:FixSize()
                    table.insert(library.items, slider)
                    return slider
                end



                toggle.Main.MouseButton1Down:Connect(function()
                    if getgenv().disablefeatures == true then return end
                    --print('setting')
                    toggle:Set(not toggle.CheckedFrame.Visible, true)
                end)
                toggle.Label.InputBegan:Connect(function(input)
                    if getgenv().disablefeatures == true then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        toggle:Set(not toggle.CheckedFrame.Visible, true)
                    end
                end)

                local MouseEnter = function()
                    if getgenv().disablefeatures == true then return end
                    toggle.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                end
                local MouseLeave = function()
                    if getgenv().disablefeatures == true then return end
                    toggle.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                end

                toggle.Label.MouseEnter:Connect(MouseEnter)
                toggle.Label.MouseLeave:Connect(MouseLeave)
                toggle.BlackOutline2.MouseEnter:Connect(MouseEnter)
                toggle.BlackOutline2.MouseLeave:Connect(MouseLeave)

                sector:FixSize()
                table.insert(library.items, toggle)
                return toggle
            end
            function sector:AddKeybindAttachment(text, flag)
                local keybindattachment = { }
                -- 
                    keybindattachment.text = text or ""
                    keybindattachment.default = default or false
                    keybindattachment.callback = callback or function(value) end
                    keybindattachment.flag = flag or text or ""
                    
                    keybindattachment.value = keybindattachment.default

                    keybindattachment.Main = Instance.new("TextButton", sector.Items)
                    keybindattachment.Main.Name = "keybindattachment"
                    keybindattachment.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindattachment.Main.BorderColor3 = window.theme.outlinecolor
                    keybindattachment.Main.BorderSizePixel = 0
                    keybindattachment.Main.Size = UDim2.fromOffset(8, 8)
                    keybindattachment.Main.AutoButtonColor = false
                    keybindattachment.Main.ZIndex = 5
                    keybindattachment.Main.Font = Enum.Font.SourceSans
                    keybindattachment.Main.Text = ""
                    keybindattachment.Main.TextColor3 = Color3.fromRGB(0, 0, 0)
                    keybindattachment.Main.TextSize = 15
                    updateevent.Event:Connect(function(theme)
                        keybindattachment.Main.BorderColor3 = theme.outlinecolor
                    end)

                    keybindattachment.BlackOutline2 = Instance.new("Frame", keybindattachment.Main)
                    keybindattachment.BlackOutline2.Name = "blackline"
                    keybindattachment.BlackOutline2.ZIndex = 4
                    keybindattachment.BlackOutline2.Size = keybindattachment.Main.Size + UDim2.fromOffset(6, 6)
                    keybindattachment.BlackOutline2.BorderSizePixel = 0
                    keybindattachment.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    keybindattachment.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        keybindattachment.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
                    keybindattachment.BlackOutline2.BackgroundTransparency = 1
                    
                    keybindattachment.Outline = Instance.new("Frame", keybindattachment.Main)
                    keybindattachment.Outline.Name = "blackline"
                    keybindattachment.Outline.ZIndex = 4
                    keybindattachment.Outline.Size = keybindattachment.Main.Size + UDim2.fromOffset(4, 4)
                    keybindattachment.Outline.BorderSizePixel = 0
                    keybindattachment.Outline.BackgroundColor3 = window.theme.outlinecolor
                    keybindattachment.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        keybindattachment.Outline.BackgroundColor3 = theme.outlinecolor
                    end)
                    keybindattachment.Outline.BackgroundTransparency = 1

                    keybindattachment.BlackOutline = Instance.new("Frame", keybindattachment.Main)
                    keybindattachment.BlackOutline.Name = "blackline"
                    keybindattachment.BlackOutline.ZIndex = 4
                    keybindattachment.BlackOutline.Size = keybindattachment.Main.Size + UDim2.fromOffset(2, 2)
                    keybindattachment.BlackOutline.BorderSizePixel = 0
                    keybindattachment.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    keybindattachment.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        keybindattachment.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)
                    keybindattachment.BlackOutline.BackgroundTransparency = 1


                    keybindattachment.Gradient = Instance.new("UIGradient", keybindattachment.Main)
                    keybindattachment.Gradient.Rotation = (22.5 * 13)
                    keybindattachment.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255)) })

                    keybindattachment.Label = Instance.new("TextLabel", keybindattachment.Main)
                    keybindattachment.Label.Name = "Label"
                    -- keybindattachment.Label.AutoButtonColor = false
                    keybindattachment.Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindattachment.Label.BackgroundTransparency = 1
                    keybindattachment.Label.Position = UDim2.fromOffset(keybindattachment.Main.AbsoluteSize.X + 10, -2)
                    keybindattachment.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 71, keybindattachment.BlackOutline.Size.Y.Offset)
                    keybindattachment.Label.Font = window.theme.font
                    keybindattachment.Label.ZIndex = 5
                    keybindattachment.Label.Text = keybindattachment.text
                    keybindattachment.Label.TextColor3 = window.theme.itemscolor
                    keybindattachment.Label.TextSize = 15
                    keybindattachment.Label.TextStrokeTransparency = 1
                    keybindattachment.Label.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        keybindattachment.Label.Font = theme.font
                        keybindattachment.Label.TextColor3 = keybindattachment.value and window.theme.itemscolor2 or theme.itemscolor
                    end)

                    keybindattachment.CheckedFrame = Instance.new("Frame", keybindattachment.Main)
                    keybindattachment.CheckedFrame.ZIndex = 5
                    keybindattachment.CheckedFrame.BorderSizePixel = 0
                    keybindattachment.CheckedFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Color3.fromRGB(204, 0, 102)
                    keybindattachment.CheckedFrame.Size = keybindattachment.Main.Size
                    keybindattachment.BackgroundTransparency = 1


                    keybindattachment.Gradient2 = Instance.new("UIGradient", keybindattachment.CheckedFrame)
                    keybindattachment.Gradient2.Rotation = (22.5 * 13)
                    keybindattachment.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor2), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor) })
                    updateevent.Event:Connect(function(theme)
                        keybindattachment.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor2), ColorSequenceKeypoint.new(1.00, theme.accentcolor) })
                    end)

                    keybindattachment.Items = Instance.new("Frame", keybindattachment.Main)
                    keybindattachment.Items.Name = "\n"
                    keybindattachment.Items.ZIndex = 4
                    keybindattachment.Items.Size = UDim2.fromOffset(60, keybindattachment.BlackOutline.AbsoluteSize.Y)
                    keybindattachment.Items.BorderSizePixel = 0
                    keybindattachment.Items.BackgroundTransparency = 1
                    keybindattachment.Items.BackgroundColor3 = Color3.new(0, 0, 0)
                    keybindattachment.Items.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 71, 0)

                    keybindattachment.ListLayout = Instance.new("UIListLayout", keybindattachment.Items)
                    keybindattachment.ListLayout.FillDirection = Enum.FillDirection.Horizontal
                    keybindattachment.ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                    keybindattachment.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    keybindattachment.ListLayout.Padding = UDim.new(0.04, 6)


                    keybindattachment.keybind = 'None'
                    keybindattachment.keybindchanged = function()

                    end
                    function keybindattachment:GetKeybind()
                        return keybindattachment.keybind
                    end
                    function keybindattachment:keychangedmethod(f)
                        keybindattachment.keybindchanged = f
                        return nil
                    end

                    function keybindattachment:AddKeybind(default, flag)
                        local keybind = { }

                        keybind.default = default or "None"
                        keybind.value = keybind.default
                        keybindattachment.keybind = keybind.value
                        keybind.flag = flag or ( (keybindattachment.text or "") .. tostring(#keybindattachment.Items:GetChildren()))

                        local shorter_keycodes = {
                            ["LeftShift"] = "LSHIFT",
                            ["RightShift"] = "RSHIFT",
                            ["LeftControl"] = "LCTRL",
                            ["RightControl"] = "RCTRL",
                            ["LeftAlt"] = "LALT",
                            ["RightAlt"] = "RALT",
                            ['MouseButton1'] = 'MB1',
                            ['MouseButton2'] = 'MB2'
                        }

                        local text = keybind.default == "None" and "[None]" or "[" .. (shorter_keycodes[keybind.default.Name] or keybind.default.Name) .. "]"
                        local size = textservice:GetTextSize(text, 15, window.theme.font, Vector2.new(2000, 2000))

                        keybind.Main = Instance.new("TextButton", keybindattachment.Items)
                        keybind.Main.Name = "keybind"
                        keybind.Main.BackgroundTransparency = 1
                        keybind.Main.BorderSizePixel = 0
                        keybind.Main.ZIndex = 5
                        keybind.Main.Size = UDim2.fromOffset(size.X + 2, size.Y - 7)
                        keybind.Main.Text = text
                        keybind.Main.Font = window.theme.font
                        keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                        keybind.Main.TextSize = 15
                        keybind.Main.TextXAlignment = Enum.TextXAlignment.Right
                        keybind.Main.MouseButton1Down:Connect(function()
                            if getgenv().disablefeatures == true then return end
                            keybind.Main.Text = "[...]"
                            keybind.Main.TextColor3 = window.theme.accentcolor
                        end)
                        updateevent.Event:Connect(function(theme)
                            keybind.Main.Font = theme.font
                            if keybind.Main.Text == "[...]" then
                                keybind.Main.TextColor3 = theme.accentcolor
                            else
                                keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                            end
                        end)

                        if keybind.flag and keybind.flag ~= "" then
                            library.flags[keybind.flag] = keybind.default
                        end
                        function keybind:Set(key)
                            if key == "None" then
                                keybind.Main.Text = "[" .. key .. "]"
                                keybind.value = key
                                if keybind.flag and keybind.flag ~= "" then
                                    library.flags[keybind.flag] = key
                                end
                            else
                                keybindattachment.keybind = keybind.value
                            end
                            keybind.Main.Text = "[" .. (shorter_keycodes[key.Name] or key.Name) .. "]"
                            keybind.value = key
                            if keybind.flag and keybind.flag ~= "" then
                                library.flags[keybind.flag] = keybind.value
                                --print('setting '..keybind.flag..' to '..tostring(keybind.value))
                            end
                        end

                        function keybind:Get()
                            return keybind.value
                        end
                        keybindattachment.keybind = keybind.value
                        function keybind:IsPressed()
                            return keybind.ispressed
                        end
                        function keybind:SetPressed(set)
                            keybind.ispressed = set
                        end
                        function keybind:Unbind()
                            keybind.Main.Text = "[" .. 'None' .. "]"
                            keybind.value = 'None'
                            if keybind.flag and keybind.flag ~= "" then
                                library.flags[keybind.flag] = key
                            end
                        end
                        
                        uis.InputBegan:Connect(function(input, gameProcessed)
                            if not gameProcessed then
                                keybindattachment.keybind = input.KeyCode
                                if keybind.Main.Text == "[...]" then
                                    keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                                    --print(tostring(input.UserInputType)..' TS')
                                    if input.UserInputType == Enum.UserInputType.Keyboard then
                                        keybind:Set(input.KeyCode)
                                        keybindattachment.keybind = input.KeyCode
                                    elseif string.find(tostring(input.UserInputType),'MouseButton') then -- == Enum.UserInputType.MouseButton1 then 
                                        --print('M BUTTON'..string.split(tostring(input.UserInputType),'.')[3])
                                        keybind:Set(input.UserInputType)
                                    else
                                        keybind:Set('None')
                                    end
                                elseif input.KeyCode == keybind:Get() then 
                                   -- print('pressing key')
                                    keybindattachment.keybind = input.KeyCode
                                    keybind:SetPressed(true)
                                elseif input.UserInputType == keybind:Get() then 
                                    keybind:SetPressed(true)
                                end
                            end
                        end)
                        uis.InputEnded:Connect(function(input, gameProcessed)
                            if not gameProcessed then
                                if input.KeyCode == keybind:Get()  then 
                                   -- print('left key')
                                   if keybindattachment.keybindchanged then 
                                        keybindattachment.keybindchanged()
                                    end
                                    keybind:SetPressed(false)
                                elseif input.UserInputType == keybind:Get() then 
                                    keybind:SetPressed(false)
                                end
                            end
                        end)
                        table.insert(library.items, keybind)
                        return keybind
                    end
                    
                    -- local keybindgotten = keybindattachment:AddKeybind()
                    local MouseEnter = function()
                        keybindattachment.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end
                    local MouseLeave = function()
                        keybindattachment.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end

                -- keybindattachment.Label.MouseEnter:Connect(MouseEnter)
                -- keybindattachment.Label.MouseLeave:Connect(MouseLeave)
                -- keybindattachment.BlackOutline2.MouseEnter:Connect(MouseEnter)
                -- keybindattachment.BlackOutline2.MouseLeave:Connect(MouseLeave)
                -- local keybinds = nil
                -- if canreturnkeybind then 
                --     local keybinds = keybindattachment:AddKeybind('.')
                -- end
                sector:FixSize()
                table.insert(library.items, keybindattachment)
                return keybindattachment
            end
            function sector:AddTextbox(text, default, callback, flag,info)
                local textbox = { }
                textbox.text = text or ""
                textbox.callback = callback or function() end
                textbox.default = default
                textbox.value = ""
                textbox.flag = flag or text or ""

                textbox.Label = Instance.new("TextButton", sector.Items)
                textbox.Label.Name = "Label"
                textbox.Label.AutoButtonColor = false
                textbox.Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                textbox.Label.BackgroundTransparency = 1
                textbox.Label.Position = UDim2.fromOffset(sector.Main.Size.X.Offset, 0)
                textbox.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 0)
                textbox.Label.Font = window.theme.font
                textbox.Label.ZIndex = 5
                textbox.Label.Text = textbox.text
                textbox.Label.TextColor3 = window.theme.itemscolor
                textbox.Label.TextSize = 15
                textbox.Label.TextStrokeTransparency = 1
                textbox.Label.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    textbox.Label.Font = theme.font
                end)

                textbox.Holder = Instance.new("Frame", sector.Items)
                textbox.Holder.Name = "holder"
                textbox.Holder.ZIndex = 5
                textbox.Holder.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 14)
                textbox.Holder.BorderSizePixel = 0
                textbox.Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

                textbox.Gradient = Instance.new("UIGradient", textbox.Holder)
                textbox.Gradient.Rotation = 90
                textbox.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39)) })

                textbox.Main = Instance.new("TextBox", textbox.Holder)
                if info and info.useplaceholder and info.useplaceholder == true then 
                    textbox.Main.PlaceholderText = textbox.text
                end
                textbox.Main.PlaceholderColor3 = Color3.fromRGB(190, 190, 190)
                textbox.Main.Text = ""
                textbox.Main.BackgroundTransparency = 1
                textbox.Main.Font = window.theme.font
                textbox.Main.Name = "textbox"
                textbox.Main.MultiLine = false
                textbox.Main.ClearTextOnFocus = false
                textbox.Main.ZIndex = 5
                textbox.Main.TextScaled = true
                textbox.Main.Size = textbox.Holder.Size
                textbox.Main.TextSize = 15
                textbox.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                textbox.Main.BorderSizePixel = 0
                textbox.Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                textbox.Main.TextXAlignment = Enum.TextXAlignment.Left

                if textbox.flag and textbox.flag ~= "" then
                    library.flags[textbox.flag] = textbox.default or ""
                end

                function textbox:Set(text)
                    textbox.value = text
                    textbox.Main.Text = text
                    if textbox.flag and textbox.flag ~= "" then
                        library.flags[textbox.flag] = text
                    end
                    pcall(textbox.callback, text)
                end
                updateevent.Event:Connect(function(theme)
                    textbox.Main.Font = theme.font
                end)

                function textbox:Get()
                    return textbox.value
                end

                if textbox.default then 
                    textbox:Set(textbox.default)
                end

                textbox.Main.FocusLost:Connect(function()
                    textbox:Set(textbox.Main.Text)
                end)

                textbox.BlackOutline2 = Instance.new("Frame", textbox.Main)
                textbox.BlackOutline2.Name = "blackline"
                textbox.BlackOutline2.ZIndex = 4
                textbox.BlackOutline2.Size = textbox.Main.Size + UDim2.fromOffset(6, 6)
                textbox.BlackOutline2.BorderSizePixel = 0
                textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                textbox.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                updateevent.Event:Connect(function(theme)
                    textbox.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                end)
                
                textbox.Outline = Instance.new("Frame", textbox.Main)
                textbox.Outline.Name = "blackline"
                textbox.Outline.ZIndex = 4
                textbox.Outline.Size = textbox.Main.Size + UDim2.fromOffset(4, 4)
                textbox.Outline.BorderSizePixel = 0
                textbox.Outline.BackgroundColor3 = window.theme.outlinecolor
                textbox.Outline.Position = UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    textbox.Outline.BackgroundColor3 = theme.outlinecolor
                end)

                textbox.BlackOutline = Instance.new("Frame", textbox.Main)
                textbox.BlackOutline.Name = "blackline"
                textbox.BlackOutline.ZIndex = 4
                textbox.BlackOutline.Size = textbox.Main.Size + UDim2.fromOffset(2, 2)
                textbox.BlackOutline.BorderSizePixel = 0
                textbox.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                textbox.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                updateevent.Event:Connect(function(theme)
                    textbox.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                end)

                textbox.BlackOutline2.MouseEnter:Connect(function()
                    textbox.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                end)
                textbox.BlackOutline2.MouseLeave:Connect(function()
                    textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                end)

                sector:FixSize()
                table.insert(library.items, textbox)
                return textbox
            end
            
            function sector:AddSlider(text, min, default, max, decimals, callback, flag, info)
                local slider = { }
                slider.text = text or ""
                slider.callback = callback or function(value) end
                slider.min = min or 0
                slider.max = max or 100
                slider.decimals = decimals or 1
                slider.default = default or slider.min
                --print(flag, 'slider flag set 1')
                slider.flag = flag ~= nil and flag or text or ""; --flag or text or ""
                --print(slider.flag, 'slider flag set 2')
                if info and info.properties then 
                    for i,v in next, info.properties do 
                        slider[i] = v
                    end
                end

                slider.value = slider.default
                local dragging = false

                slider.MainBack = Instance.new("Frame", sector.Items)
                slider.MainBack.Name = "MainBack"
                slider.MainBack.ZIndex = 7
                slider.MainBack.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 25)
                slider.MainBack.BorderSizePixel = 0
                slider.MainBack.BackgroundTransparency = 1

                slider.Label = Instance.new("TextLabel", slider.MainBack)
                slider.Label.BackgroundTransparency = 1
                slider.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 6)
                slider.Label.Font = window.theme.font
                slider.Label.Text = slider.text .. ":"
                slider.Label.TextColor3 = window.theme.itemscolor
                slider.Label.Position = UDim2.fromOffset(0, 0)
                slider.Label.TextSize = 15
                slider.Label.ZIndex = 4
                slider.Label.TextStrokeTransparency = 1
                slider.Label.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    slider.Label.Font = theme.font
                    slider.Label.TextColor3 = theme.itemscolor
                end)

                local size = textservice:GetTextSize(slider.Label.Text, slider.Label.TextSize, slider.Label.Font, Vector2.new(200,300))
                slider.InputLabel = Instance.new("TextBox", slider.MainBack)
                slider.InputLabel.BackgroundTransparency = 1
                slider.InputLabel.ClearTextOnFocus = false
                slider.InputLabel.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - size.X - 15, 12)
                slider.InputLabel.Font = window.theme.font
                slider.InputLabel.Text = "0"
                slider.InputLabel.TextColor3 = window.theme.itemscolor
                slider.InputLabel.Position = UDim2.fromOffset(size.X + 3, -3)
                slider.InputLabel.TextSize = 15
                slider.InputLabel.ZIndex = 4
                slider.InputLabel.TextStrokeTransparency = 1
                slider.InputLabel.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    slider.InputLabel.Font = theme.font
                    slider.InputLabel.TextColor3 = theme.itemscolor

                    local size = textservice:GetTextSize(slider.Label.Text, slider.Label.TextSize, slider.Label.Font, Vector2.new(200,300))
                    slider.InputLabel.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - size.X - 15, 12)
                end)

                slider.Main = Instance.new("TextButton", slider.MainBack)
                slider.Main.Name = "slider"
                slider.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                slider.Main.Position = UDim2.fromOffset(0, 15)
                slider.Main.BorderSizePixel = 0
                slider.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 12)
                slider.Main.AutoButtonColor = false
                slider.Main.Text = ""
                slider.Main.ZIndex = 5

                slider.BlackOutline2 = Instance.new("Frame", slider.Main)
                slider.BlackOutline2.Name = "blackline"
                slider.BlackOutline2.ZIndex = 4
                slider.BlackOutline2.Size = slider.Main.Size + UDim2.fromOffset(6, 6)
                slider.BlackOutline2.BorderSizePixel = 0
                slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                slider.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                updateevent.Event:Connect(function(theme)
                    slider.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                end)
                
                slider.Outline = Instance.new("Frame", slider.Main)
                slider.Outline.Name = "blackline"
                slider.Outline.ZIndex = 4
                slider.Outline.Size = slider.Main.Size + UDim2.fromOffset(4, 4)
                slider.Outline.BorderSizePixel = 0
                slider.Outline.BackgroundColor3 = window.theme.outlinecolor
                slider.Outline.Position = UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    slider.Outline.BackgroundColor3 = theme.outlinecolor
                end)

                slider.BlackOutline = Instance.new("Frame", slider.Main)
                slider.BlackOutline.Name = "blackline"
                slider.BlackOutline.ZIndex = 4
                slider.BlackOutline.Size = slider.Main.Size + UDim2.fromOffset(2, 2)
                slider.BlackOutline.BorderSizePixel = 0
                slider.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                slider.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                updateevent.Event:Connect(function(theme)
                    slider.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                end)

                slider.Gradient = Instance.new("UIGradient", slider.Main)
                slider.Gradient.Rotation = 90
                slider.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(41, 41, 41)) })

                slider.SlideBar = Instance.new("Frame", slider.Main)
                slider.SlideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) --Color3.fromRGB(204, 0, 102)
                slider.SlideBar.ZIndex = 5
                slider.SlideBar.BorderSizePixel = 0
                slider.SlideBar.Size = UDim2.fromOffset(0, slider.Main.Size.Y.Offset)
                --slider.SlideBar.Position += UDim2.fromOffset(129, 0)

                -- if min < 0 then 
                --     slider.negativemain = slider.Main:Clone();
                --     slider.negativemain.Parent = slider.Main.Parent;

                --     slider.negativemain.Size =  UDim2.fromOffset(slider.Main.Size.X.Offset/2,slider.Main.Size.Y.Offset)
                --     slider.negativemain.BackgroundTransparency = 0

                --     slider.SlideBarNegative = Instance.new("Frame", slider.negativemain)
                --     slider.SlideBarNegative.BackgroundColor3 = Color3.fromRGB(255, 255, 255) --Color3.fromRGB(204, 0, 102)
                --     slider.SlideBarNegative.ZIndex = 5
                --     slider.SlideBarNegative.BorderSizePixel = 0
                --     slider.SlideBarNegative.Size = UDim2.fromOffset(0, slider.negativemain.Size.Y.Offset)
                --     slider.SlideBarNegative.Position += UDim2.fromOffset(129, 0)
                --     slider.Gradient2 = Instance.new("UIGradient", slider.SlideBarNegative)
                --     slider.Gradient2.Rotation = 90
                --     slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor2) })
                --     updateevent.Event:Connect(function(theme)
                --         slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor), ColorSequenceKeypoint.new(1.00, theme.accentcolor2) })
                --     end)

                -- end


                slider.Gradient2 = Instance.new("UIGradient", slider.SlideBar)
                slider.Gradient2.Rotation = 90
                slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor2) })
                updateevent.Event:Connect(function(theme)
                    slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor), ColorSequenceKeypoint.new(1.00, theme.accentcolor2) })
                end)

                slider.BlackOutline2.MouseEnter:Connect(function()
                    if getgenv().disablefeatures == true then return end
                    slider.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                end)
                slider.BlackOutline2.MouseLeave:Connect(function()
                    if getgenv().disablefeatures == true then return end
                    slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                end)

                if slider.flag and slider.flag ~= "" then
                    library.flags[slider.flag] = slider.default or slider.min or 0
                else
                    --print('no flag set',slider.flag)
                end

                function slider:Get()
                    return slider.value
                end

                -- function slider:Set(value)
                --     slider.value = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
                --     local percent = 1 - ((slider.max - slider.value) / (slider.max - slider.min))
                --     if slider.flag and slider.flag ~= "" then
                --         library.flags[slider.flag] = slider.value
                --     end
                --     -- print(slider.value)
                --     -- print('setting')
                --     --slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    
                --     slider.SlideBar:TweenSize(UDim2.fromOffset((slider.value/slider.max)*142, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    
                --     -- if slider.value < 0 then 
                --     --     slider.SlideBar.Visible = false
                --     --     slider.SlideBarNegative.Visible = true
                --     --     slider.SlideBarNegative:TweenSize(UDim2.fromOffset(-(percent * slider.Main.AbsoluteSize.X), slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    
                --     -- else
                --     --     slider.SlideBarNegative.Visible = false
                --     --     slider.SlideBar.Visible = true
                --     --     slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                --     -- end
				-- 	slider.InputLabel.Text = slider.value
				-- 	pcall(slider.callback, slider.value)
				-- end






                function slider:Set(value)
                    slider.value = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
                    local percent = 1 - ((slider.max - slider.value) / (slider.max - slider.min))
                    if slider.flag and slider.flag ~= "" then
                        library.flags[slider.flag] = slider.value
                        --print('new flag set ', slider.flag)
                    else
                        --print('no flagger set', slider.flag)
                    end
                    -- print(slider.value)
                    -- print('setting')
                    -- if slider.value < 0 then 
                    --     slider.SlideBar:TweenSize(UDim2.fromOffset(-(percent * slider.Main.AbsoluteSize.X), slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    -- else
                    --     slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    -- end
                    
                    slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    slider.InputLabel.Text = slider.value
                    pcall(slider.callback, slider.value)
                end
                slider:Set(slider.default)








                -- slider:Set(slider.default)

                slider.InputLabel.FocusLost:Connect(function(Return)
                    if not Return then 
                        return 
                    end
                    if (slider.InputLabel.Text:match("^%d+$")) then
                        slider:Set(tonumber(slider.InputLabel.Text))
                    else
                        slider.InputLabel.Text = tostring(slider.value)
                    end
                end)


                function slider:Refresh()
                    local mousePos = camera:WorldToViewportPoint(mouse.Hit.p)
                    local percent = math.clamp(mousePos.X - slider.SlideBar.AbsolutePosition.X, 0, slider.Main.AbsoluteSize.X) / slider.Main.AbsoluteSize.X
                    local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                    value = math.clamp(value, slider.min, slider.max)
                    slider:Set(value)
                end

                -- function slider:Refresh()
                --     local mousePos = camera:WorldToViewportPoint(mouse.Hit.p)
                --     local percent = math.clamp(mousePos.X - slider.SlideBar.AbsolutePosition.X, 0, slider.Main.AbsoluteSize.X) / slider.Main.AbsoluteSize.X
                --     -- mouse x smaller = negative
                --     local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                --     value = math.clamp(value, slider.min, slider.max)
                --     slider:Set(value)
                -- end
                -- function slider:Refresh()
                --     local mousePos = camera:WorldToViewportPoint(mouse.Hit.p)
                --     local closesttonegative = true;
                --     local positivepos = (mousePos.X - slider.SlideBar.AbsolutePosition.X/2)
                --     local negativepos = (mousePos.X - slider.SlideBarNegative.AbsolutePosition.X/2)
                --     if negativepos>positivepos then closesttonegative = true end 

                --     if closesttonegative == true then 
                --         print('closer')
                --         local percent = math.clamp(math.abs(mousePos.X/2) - slider.SlideBarNegative.AbsolutePosition.X/2, 0, slider.Main.AbsoluteSize.X/2) / slider.Main.AbsoluteSize.X
                --         local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                --         value = math.clamp(value, slider.min, slider.max)
                --         slider:Set(value)
                --     else
                --         print('away')
                --         local percent = math.clamp(mousePos.X - slider.SlideBar.AbsolutePosition.X/2, 0, slider.Main.AbsoluteSize.X/2) / slider.Main.AbsoluteSize.X
                --         local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                --         value = math.clamp(value, slider.min, slider.max)
                --         slider:Set(value)
                --     end

                -- end
                -- function slider:NegativeRefresh()
                --     local mousePos = camera:WorldToViewportPoint(mouse.Hit.p)
                --     local percent = math.clamp(-mousePos.X - slider.SlideBarNegative.AbsolutePosition.X, 0, slider.negativemain.AbsoluteSize.X) / slider.negativemain.AbsoluteSize.X
                --     local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                --     value = math.clamp(value, slider.min, slider.max)
                --     slider:Set(value)
                -- end




                -- function slider:AddNegative()

                --     slider.MainNegative = Instance.new("TextButton", slider.MainBack)
                --     slider.MainNegative.Name = "slidernegative"
                --     slider.MainNegative.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     slider.MainNegative.Position = UDim2.fromOffset(0, 15)
                --     slider.MainNegative.BorderSizePixel = 0
                --     slider.MainNegative.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 12)
                --     slider.MainNegative.AutoButtonColor = false
                --     slider.MainNegative.Text = ""
                --     slider.MainNegative.ZIndex = 5
    
                --     slider.SlideBarNegative = Instance.new("Frame", slider.MainNegative)
                --     slider.SlideBarNegative.BackgroundColor3 = Color3.fromRGB(255, 255, 255) --Color3.fromRGB(204, 0, 102)
                --     slider.SlideBarNegative.ZIndex = 5
                --     slider.SlideBarNegative.BorderSizePixel = 0
                --     slider.SlideBarNegative.Size = UDim2.fromOffset(0, slider.MainNegative.Size.Y.Offset)
                --     slider.SlideBarNegative.Position += UDim2.fromOffset(129, 0)
                --     slider.Gradient2 = Instance.new("UIGradient", slider.SlideBarNegative)
                --     slider.Gradient2.Rotation = 90
                --     slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor2) })
                --     updateevent.Event:Connect(function(theme)
                --         slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor), ColorSequenceKeypoint.new(1.00, theme.accentcolor2) })
                --     end)




                -- end

                slider.SlideBar.InputBegan:Connect(function(input)
                    if getgenv().disablefeatures == true then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        slider:Refresh()
                    end
                end)
                -- if slider.SlideBarNegative ~= nil then 
                --     slider.SlideBarNegative.InputBegan:Connect(function(input)
                --         if input.UserInputType == Enum.UserInputType.MouseButton1 then
                --             dragging = true
                --             slider:NegativeRefresh()
                --         end
                --     end)
                --     slider.SlideBarNegative.InputEnded:Connect(function(input)
                --         if input.UserInputType == Enum.UserInputType.MouseButton1 then
                --             dragging = false
                --         end
                --     end)
                -- end

                slider.SlideBar.InputEnded:Connect(function(input)
                    if getgenv().disablefeatures == true then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                slider.Main.InputBegan:Connect(function(input)
                    if getgenv().disablefeatures == true then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        slider:Refresh()
                    end
                end)

                slider.Main.InputEnded:Connect(function(input)
                    if getgenv().disablefeatures == true then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

				uis.InputChanged:Connect(function(input)
                    if getgenv().disablefeatures == true then return end
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        slider:Refresh()
                        --slider:NegativeRefresh()
					end
				end)








                -- if slider.SlideBarNegative ~= nil then 
                --     slider.SlideBarNegative.InputBegan:Connect(function(input)
                --         if input.UserInputType == Enum.UserInputType.MouseButton1 then
                --             dragging = true
                --            -- slider:NegativeRefresh()
                --         end
                --     end)
                --     slider.SlideBarNegative.InputEnded:Connect(function(input)
                --         if input.UserInputType == Enum.UserInputType.MouseButton1 then
                --             dragging = false
                --         end
                --     end)
                --     slider.negativemain.InputBegan:Connect(function(input)
                --         if input.UserInputType == Enum.UserInputType.MouseButton1 then
                --             dragging = true
                --             --slider:NegativeRefresh()
                --         end
                --     end)
    
                --     slider.negativemain.InputEnded:Connect(function(input)
                --         if input.UserInputType == Enum.UserInputType.MouseButton1 then
                --             dragging = false
                --         end
                --     end)
                -- end





				uis.InputChanged:Connect(function(input)
                    if getgenv().disablefeatures == true then return end
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        slider:Refresh()
                        --slider:NegativeRefresh()
					end
				end)





                sector:FixSize()
                table.insert(library.items, slider)
                return slider
            end

            function sector:AddColorpicker(text, default, callback, flag, info)
                local colorpicker = { }

                colorpicker.iscolorpicker = true;
                colorpicker.text = text or ""
                colorpicker.callback = callback or function() end
                colorpicker.default = default or Color3.fromRGB(255, 255, 255)
                colorpicker.value = colorpicker.default
                colorpicker.flag = flag ~= nil and flag or text or ""
                if info and info.properties then 
                    for i,v in next, info.properties do 
                        colorpicker[i] = v
                    end
                end

                colorpicker.Label = Instance.new("TextLabel", sector.Items)
                colorpicker.Label.BackgroundTransparency = 1
                colorpicker.Label.Size = UDim2.fromOffset(156, 10)
                colorpicker.Label.ZIndex = 4
                colorpicker.Label.Font = window.theme.font
                colorpicker.Label.Text = colorpicker.text
                colorpicker.Label.TextColor3 = window.theme.itemscolor
                colorpicker.Label.TextSize = 15
                colorpicker.Label.TextStrokeTransparency = 1
                colorpicker.Label.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    colorpicker.Label.Font = theme.font
                    colorpicker.Label.TextColor3 = theme.itemscolor
                end)

                colorpicker.Main = Instance.new("Frame", colorpicker.Label)
                colorpicker.Main.ZIndex = 6
                colorpicker.Main.BorderSizePixel = 0
                colorpicker.Main.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 29, 0)
                colorpicker.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorpicker.Main.Size = UDim2.fromOffset(16, 10)

                colorpicker.Gradient = Instance.new("UIGradient", colorpicker.Main)
                colorpicker.Gradient.Rotation = 90

                local clr = Color3.new(math.clamp(colorpicker.value.R / 1.7, 0, 1), math.clamp(colorpicker.value.G / 1.7, 0, 1), math.clamp(colorpicker.value.B / 1.7, 0, 1))
                colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, colorpicker.value), ColorSequenceKeypoint.new(1.00, clr) })

                colorpicker.BlackOutline2 = Instance.new("Frame", colorpicker.Main)
                colorpicker.BlackOutline2.Name = "blackline"
                colorpicker.BlackOutline2.ZIndex = 4
                colorpicker.BlackOutline2.Size = colorpicker.Main.Size + UDim2.fromOffset(6, 6)
                colorpicker.BlackOutline2.BorderSizePixel = 0
                colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                colorpicker.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                updateevent.Event:Connect(function(theme)
                    colorpicker.BlackOutline2.BackgroundColor3 = window.OpenedColorPickers[colorpicker.MainPicker] and theme.accentcolor or theme.outlinecolor2
                end)
                
                colorpicker.Outline = Instance.new("Frame", colorpicker.Main)
                colorpicker.Outline.Name = "blackline"
                colorpicker.Outline.ZIndex = 4
                colorpicker.Outline.Size = colorpicker.Main.Size + UDim2.fromOffset(4, 4)
                colorpicker.Outline.BorderSizePixel = 0
                colorpicker.Outline.BackgroundColor3 = window.theme.outlinecolor
                colorpicker.Outline.Position = UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    colorpicker.Outline.BackgroundColor3 = theme.outlinecolor
                end)

                colorpicker.BlackOutline = Instance.new("Frame", colorpicker.Main)
                colorpicker.BlackOutline.Name = "blackline"
                colorpicker.BlackOutline.ZIndex = 4
                colorpicker.BlackOutline.Size = colorpicker.Main.Size + UDim2.fromOffset(2, 2)
                colorpicker.BlackOutline.BorderSizePixel = 0
                colorpicker.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                colorpicker.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                updateevent.Event:Connect(function(theme)
                    colorpicker.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                end)

                colorpicker.BlackOutline2.MouseEnter:Connect(function()
                    colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                end)
                colorpicker.BlackOutline2.MouseLeave:Connect(function()
                    if not window.OpenedColorPickers[colorpicker.MainPicker] then
                        colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end
                end)

                colorpicker.MainPicker = Instance.new("TextButton", colorpicker.Main)
                colorpicker.MainPicker.Name = "picker"
                colorpicker.MainPicker.ZIndex = 100
                colorpicker.MainPicker.Visible = false
                colorpicker.MainPicker.AutoButtonColor = false
                colorpicker.MainPicker.Text = ""
                window.OpenedColorPickers[colorpicker.MainPicker] = false
                colorpicker.MainPicker.Size = UDim2.fromOffset(180, 196)
                colorpicker.MainPicker.BorderSizePixel = 0
                colorpicker.MainPicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                colorpicker.MainPicker.Rotation = 0.000000000000001
                colorpicker.MainPicker.Position = UDim2.fromOffset(-colorpicker.MainPicker.AbsoluteSize.X + colorpicker.Main.AbsoluteSize.X, 15)

                colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                colorpicker.BlackOutline3.Name = "blackline"
                colorpicker.BlackOutline3.ZIndex = 98
                colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(6, 6)
                colorpicker.BlackOutline3.BorderSizePixel = 0
                colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                colorpicker.BlackOutline3.Position = UDim2.fromOffset(-3, -3)
                updateevent.Event:Connect(function(theme)
                    colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                end)
                
                colorpicker.Outline2 = Instance.new("Frame", colorpicker.MainPicker)
                colorpicker.Outline2.Name = "blackline"
                colorpicker.Outline2.ZIndex = 98
                colorpicker.Outline2.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(4, 4)
                colorpicker.Outline2.BorderSizePixel = 0
                colorpicker.Outline2.BackgroundColor3 = window.theme.outlinecolor
                colorpicker.Outline2.Position = UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    colorpicker.Outline2.BackgroundColor3 = theme.outlinecolor
                end)

                colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                colorpicker.BlackOutline3.Name = "blackline"
                colorpicker.BlackOutline3.ZIndex = 98
                colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(2, 2)
                colorpicker.BlackOutline3.BorderSizePixel = 0
                colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                colorpicker.BlackOutline3.Position = UDim2.fromOffset(-1, -1)
                updateevent.Event:Connect(function(theme)
                    colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                end)

                colorpicker.hue = Instance.new("ImageLabel", colorpicker.MainPicker)
                colorpicker.hue.ZIndex = 101
                colorpicker.hue.Position = UDim2.new(0,3,0,3)
                colorpicker.hue.Size = UDim2.new(0,172,0,172)
                colorpicker.hue.Image = "rbxassetid://4155801252"
                colorpicker.hue.ScaleType = Enum.ScaleType.Stretch
                colorpicker.hue.BackgroundColor3 = Color3.new(1,0,0)
                colorpicker.hue.BorderColor3 = window.theme.outlinecolor2
                updateevent.Event:Connect(function(theme)
                    colorpicker.hue.BorderColor3 = theme.outlinecolor2
                end)

                colorpicker.hueselectorpointer = Instance.new("ImageLabel", colorpicker.MainPicker)
                colorpicker.hueselectorpointer.ZIndex = 101
                colorpicker.hueselectorpointer.BackgroundTransparency = 1
                colorpicker.hueselectorpointer.BorderSizePixel = 0
                colorpicker.hueselectorpointer.Position = UDim2.new(0, 0, 0, 0)
                colorpicker.hueselectorpointer.Size = UDim2.new(0, 7, 0, 7)
                colorpicker.hueselectorpointer.Image = "rbxassetid://6885856475"

                colorpicker.selector = Instance.new("TextLabel", colorpicker.MainPicker)
                colorpicker.selector.ZIndex = 100
                colorpicker.selector.Position = UDim2.new(0,3,0,181)
                colorpicker.selector.Size = UDim2.new(0,173,0,10)
                colorpicker.selector.BackgroundColor3 = Color3.fromRGB(255,255,255)
                colorpicker.selector.BorderColor3 = window.theme.outlinecolor2
                colorpicker.selector.Text = ""
                updateevent.Event:Connect(function(theme)
                    colorpicker.selector.BorderColor3 = theme.outlinecolor2
                end)
    
                colorpicker.gradient = Instance.new("UIGradient", colorpicker.selector)
                colorpicker.gradient.Color = ColorSequence.new({ 
                    ColorSequenceKeypoint.new(0, Color3.new(1,0,0)), 
                    ColorSequenceKeypoint.new(0.17, Color3.new(1,0,1)), 
                    ColorSequenceKeypoint.new(0.33,Color3.new(0,0,1)), 
                    ColorSequenceKeypoint.new(0.5,Color3.new(0,1,1)), 
                    ColorSequenceKeypoint.new(0.67, Color3.new(0,1,0)), 
                    ColorSequenceKeypoint.new(0.83, Color3.new(1,1,0)), 
                    ColorSequenceKeypoint.new(1, Color3.new(1,0,0))
                })

                colorpicker.pointer = Instance.new("Frame", colorpicker.selector)
                colorpicker.pointer.ZIndex = 101
                colorpicker.pointer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                colorpicker.pointer.Position = UDim2.new(0,0,0,0)
                colorpicker.pointer.Size = UDim2.new(0,2,0,10)
                colorpicker.pointer.BorderColor3 = Color3.fromRGB(255, 255, 255)

                if colorpicker.flag and colorpicker.flag ~= "" then
                    library.flags[colorpicker.flag] = colorpicker.default
                end

                function colorpicker:RefreshSelector()
                    local pos = math.clamp((mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X, 0, 1)
                    colorpicker.color = 1 - pos
                    colorpicker.pointer:TweenPosition(UDim2.new(pos, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    colorpicker.hue.BackgroundColor3 = Color3.fromHSV(1 - pos, 1, 1)
                end

                function colorpicker:RefreshHue()
                    local x = (mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X
                    local y = (mouse.Y - colorpicker.hue.AbsolutePosition.Y) / colorpicker.hue.AbsoluteSize.Y
                    colorpicker.hueselectorpointer:TweenPosition(UDim2.new(math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 0.952 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 0, math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 0.885 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                    colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 1 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 1 - (math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 1 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y)))
                end

                function colorpicker:Set(value)
                    local color = Color3.new(math.clamp(value.r, 0, 1), math.clamp(value.g, 0, 1), math.clamp(value.b, 0, 1))
                    colorpicker.value = color
                    if colorpicker.flag and colorpicker.flag ~= "" then
                        library.flags[colorpicker.flag] = color
                    end
                    local clr = Color3.new(math.clamp(color.R / 1.7, 0, 1), math.clamp(color.G / 1.7, 0, 1), math.clamp(color.B / 1.7, 0, 1))
                    colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, color), ColorSequenceKeypoint.new(1.00, clr) })
                    pcall(colorpicker.callback, color)
                end
                function colorpicker:Get()
                    return colorpicker.value
                end
                colorpicker:Set(colorpicker.default)

                function colorpicker:AddDropdown(items, default, multichoice, callback, flag)
                    local dropdown = { }

                    dropdown.defaultitems = items or { }
                    dropdown.default = default
                    dropdown.callback = callback or function() end
                    dropdown.multichoice = multichoice or false
                    dropdown.values = { }
                    dropdown.flag = flag or ((colorpicker.text or "") .. tostring( #(sector.Items:GetChildren()) ))
    
                    dropdown.Main = Instance.new("TextButton", sector.Items)
                    dropdown.Main.Name = "dropdown"
                    dropdown.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.Main.BorderSizePixel = 0
                    dropdown.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 16)
                    dropdown.Main.Position = UDim2.fromOffset(0, 0)
                    dropdown.Main.ZIndex = 5
                    dropdown.Main.AutoButtonColor = false
                    dropdown.Main.Font = window.theme.font
                    dropdown.Main.Text = ""
                    dropdown.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.Main.TextSize = 15
                    dropdown.Main.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        dropdown.Main.Font = theme.font
                    end)
    
                    dropdown.Gradient = Instance.new("UIGradient", dropdown.Main)
                    dropdown.Gradient.Rotation = 90
                    dropdown.Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39))}
    
                    dropdown.SelectedLabel = Instance.new("TextLabel", dropdown.Main)
                    dropdown.SelectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.SelectedLabel.BackgroundTransparency = 1
                    dropdown.SelectedLabel.Position = UDim2.fromOffset(5, 2)
                    dropdown.SelectedLabel.Size = UDim2.fromOffset(130, 13)
                    dropdown.SelectedLabel.Font = window.theme.font
                    dropdown.SelectedLabel.Text = colorpicker.text
                    dropdown.SelectedLabel.ZIndex = 5
                    dropdown.SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.SelectedLabel.TextSize = 15
                    dropdown.SelectedLabel.TextStrokeTransparency = 1
                    dropdown.SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        dropdown.SelectedLabel.Font = theme.font
                    end)

                    dropdown.Nav = Instance.new("ImageButton", dropdown.Main)
                    dropdown.Nav.Name = "navigation"
                    dropdown.Nav.BackgroundTransparency = 1
                    dropdown.Nav.LayoutOrder = 10
                    dropdown.Nav.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 5)
                    dropdown.Nav.Rotation = 90
                    dropdown.Nav.ZIndex = 5
                    dropdown.Nav.Size = UDim2.fromOffset(8, 8)
                    dropdown.Nav.Image = "rbxassetid://4918373417"
                    dropdown.Nav.ImageColor3 = Color3.fromRGB(210, 210, 210)
    
                    dropdown.BlackOutline2 = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline2.Name = "blackline"
                    dropdown.BlackOutline2.ZIndex = 4
                    dropdown.BlackOutline2.Size = dropdown.Main.Size + UDim2.fromOffset(6, 6)
                    dropdown.BlackOutline2.BorderSizePixel = 0
                    dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    dropdown.Outline = Instance.new("Frame", dropdown.Main)
                    dropdown.Outline.Name = "blackline"
                    dropdown.Outline.ZIndex = 4
                    dropdown.Outline.Size = dropdown.Main.Size + UDim2.fromOffset(4, 4)
                    dropdown.Outline.BorderSizePixel = 0
                    dropdown.Outline.BackgroundColor3 = window.theme.outlinecolor
                    dropdown.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        dropdown.Outline.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    dropdown.BlackOutline = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline.Name = "blackline"
                    dropdown.BlackOutline.ZIndex = 4
                    dropdown.BlackOutline.Size = dropdown.Main.Size + UDim2.fromOffset(2, 2)
                    dropdown.BlackOutline.BorderSizePixel = 0
                    dropdown.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    dropdown.ItemsFrame = Instance.new("ScrollingFrame", dropdown.Main)
                    dropdown.ItemsFrame.Name = "itemsframe"
                    dropdown.ItemsFrame.BorderSizePixel = 0
                    dropdown.ItemsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    dropdown.ItemsFrame.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                    dropdown.ItemsFrame.ScrollBarThickness = 2
                    dropdown.ItemsFrame.ZIndex = 8
                    dropdown.ItemsFrame.ScrollingDirection = "Y"
                    dropdown.ItemsFrame.Visible = false
                    dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.Main.AbsoluteSize.X, 0)
    
                    dropdown.ListLayout = Instance.new("UIListLayout", dropdown.ItemsFrame)
                    dropdown.ListLayout.FillDirection = Enum.FillDirection.Vertical
                    dropdown.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
                    dropdown.ListPadding = Instance.new("UIPadding", dropdown.ItemsFrame)
                    dropdown.ListPadding.PaddingTop = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingBottom = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingLeft = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingRight = UDim.new(0, 2)
    
                    dropdown.BlackOutline2Items = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline2Items.Name = "blackline"
                    dropdown.BlackOutline2Items.ZIndex = 7
                    dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                    dropdown.BlackOutline2Items.BorderSizePixel = 0
                    dropdown.BlackOutline2Items.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline2Items.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-3, -3)
                    dropdown.BlackOutline2Items.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline2Items.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    dropdown.OutlineItems = Instance.new("Frame", dropdown.Main)
                    dropdown.OutlineItems.Name = "blackline"
                    dropdown.OutlineItems.ZIndex = 7
                    dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                    dropdown.OutlineItems.BorderSizePixel = 0
                    dropdown.OutlineItems.BackgroundColor3 = window.theme.outlinecolor
                    dropdown.OutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-2, -2)
                    dropdown.OutlineItems.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.OutlineItems.BackgroundColor3 = theme.outlinecolor
                    end)
    
                    dropdown.BlackOutlineItems = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutlineItems.Name = "blackline"
                    dropdown.BlackOutlineItems.ZIndex = 7
                    dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(-2, -2)
                    dropdown.BlackOutlineItems.BorderSizePixel = 0
                    dropdown.BlackOutlineItems.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-1, -1)
                    dropdown.BlackOutlineItems.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutlineItems.BackgroundColor3 = theme.outlinecolor2
                    end)
    
                    dropdown.IgnoreBackButtons = Instance.new("TextButton", dropdown.Main)
                    dropdown.IgnoreBackButtons.BackgroundTransparency = 1
                    dropdown.IgnoreBackButtons.BorderSizePixel = 0
                    dropdown.IgnoreBackButtons.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                    dropdown.IgnoreBackButtons.Size = UDim2.new(0, 0, 0, 0)
                    dropdown.IgnoreBackButtons.ZIndex = 7
                    dropdown.IgnoreBackButtons.Text = ""
                    dropdown.IgnoreBackButtons.Visible = false
                    dropdown.IgnoreBackButtons.AutoButtonColor = false

                    if dropdown.flag and dropdown.flag ~= "" then
                        library.flags[dropdown.flag] = dropdown.multichoice and { dropdown.default or dropdown.defaultitems[1] or "" } or (dropdown.default or dropdown.defaultitems[1] or "")
                    end

                    function dropdown:isSelected(item)
                        for i, v in pairs(dropdown.values) do
                            if v == item then
                                return true
                            end
                        end
                        return false
                    end
    
                    function dropdown:updateText(text)
                        if #text >= 27 then
                            text = text:sub(1, 25) .. ".."
                        end
                        dropdown.SelectedLabel.Text = text
                    end
    
                    dropdown.Changed = Instance.new("BindableEvent")
                    function dropdown:Set(value)
                        if type(value) == "table" then
                            dropdown.values = value
                            dropdown:updateText(table.concat(value, ", "))
                            pcall(dropdown.callback, value)
                        else
                            dropdown:updateText(value)
                            dropdown.values = { value }
                            pcall(dropdown.callback, value)
                        end
                        
                        dropdown.Changed:Fire(value)
                        if dropdown.flag and dropdown.flag ~= "" then
                            library.flags[dropdown.flag] = dropdown.multichoice and dropdown.values or dropdown.values[1]
                        end
                    end
    
                    function dropdown:Get()
                        return dropdown.multichoice and dropdown.values or dropdown.values[1]
                    end
    
                    dropdown.items = { }
                    function dropdown:Add(v)
                        local Item = Instance.new("TextButton", dropdown.ItemsFrame)
                        Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Item.BorderSizePixel = 0
                        Item.Position = UDim2.fromOffset(0, 0)
                        Item.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset - 4, 20)
                        Item.ZIndex = 9
                        Item.Text = v
                        Item.Name = v
                        Item.AutoButtonColor = false
                        Item.Font = window.theme.font
                        Item.TextSize = 15
                        Item.TextXAlignment = Enum.TextXAlignment.Left
                        Item.TextStrokeTransparency = 1
                        dropdown.ItemsFrame.CanvasSize = dropdown.ItemsFrame.CanvasSize + UDim2.fromOffset(0, Item.AbsoluteSize.Y)
    
                        Item.MouseButton1Down:Connect(function()
                            if getgenv().disablefeatures == true then return end
                            if dropdown.multichoice then
                                if dropdown:isSelected(v) then
                                    for i2, v2 in pairs(dropdown.values) do
                                        if v2 == v then
                                            table.remove(dropdown.values, i2)
                                        end
                                    end
                                    dropdown:Set(dropdown.values)
                                else
                                    table.insert(dropdown.values, v)
                                    dropdown:Set(dropdown.values)
                                end
    
                                return
                            else
                                dropdown.Nav.Rotation = 90
                                dropdown.ItemsFrame.Visible = false
                                dropdown.ItemsFrame.Active = false
                                dropdown.OutlineItems.Visible = false
                                dropdown.BlackOutlineItems.Visible = false
                                dropdown.BlackOutline2Items.Visible = false
                                dropdown.IgnoreBackButtons.Visible = false
                                dropdown.IgnoreBackButtons.Active = false
                            end
    
                            dropdown:Set(v)
                            return
                        end)
    
                        runservice.RenderStepped:Connect(function()
                            if dropdown.multichoice and dropdown:isSelected(v) or dropdown.values[1] == v then
                                Item.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
                                Item.TextColor3 = window.theme.accentcolor
                                Item.Text = " " .. v
                            else
                                Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Item.Text = v
                            end
                        end)
    
                        table.insert(dropdown.items, v)
                        dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * Item.AbsoluteSize.Y, 20, 156) + 4)
                        dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * Item.AbsoluteSize.Y) + 4)
    
                        dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                        dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                        dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                        dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
                    end
    
                    function dropdown:Remove(value)
                        local item = dropdown.ItemsFrame:FindFirstChild(value)
                        if item then
                            for i,v in pairs(dropdown.items) do
                                if v == value then
                                    table.remove(dropdown.items, i)
                                end
                            end
    
                            dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * item.AbsoluteSize.Y, 20, 156) + 4)
                            dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * item.AbsoluteSize.Y) + 4)
        
                            dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                            dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                            dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                            dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
    
                            item:Remove()
                        end
                    end 
    
                    for i,v in pairs(dropdown.defaultitems) do
                        dropdown:Add(v)
                    end
    
                    if dropdown.default then
                        dropdown:Set(dropdown.default)
                    end
    
                    local MouseButton1Down = function()
                        if getgenv().disablefeatures == true then return end
                        if dropdown.Nav.Rotation == 90 then
                            dropdown.ItemsFrame.ScrollingEnabled = true
                            sector.Main.Parent.ScrollingEnabled = false
                            tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = -90 }):Play()
                            dropdown.ItemsFrame.Visible = true
                            dropdown.ItemsFrame.Active = true
                            dropdown.IgnoreBackButtons.Visible = true
                            dropdown.IgnoreBackButtons.Active = true
                            dropdown.OutlineItems.Visible = true
                            dropdown.BlackOutlineItems.Visible = true
                            dropdown.BlackOutline2Items.Visible = true
                        else
                            dropdown.ItemsFrame.ScrollingEnabled = false
                            sector.Main.Parent.ScrollingEnabled = true
                            tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 90 }):Play()
                            dropdown.ItemsFrame.Visible = false
                            dropdown.ItemsFrame.Active = false
                            dropdown.IgnoreBackButtons.Visible = false
                            dropdown.IgnoreBackButtons.Active = false
                            dropdown.OutlineItems.Visible = false
                            dropdown.BlackOutlineItems.Visible = false
                            dropdown.BlackOutline2Items.Visible = false
                        end
                    end
    
                    dropdown.Main.MouseButton1Down:Connect(MouseButton1Down)
                    dropdown.Nav.MouseButton1Down:Connect(MouseButton1Down)
    
                    dropdown.BlackOutline2.MouseEnter:Connect(function()
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    dropdown.BlackOutline2.MouseLeave:Connect(function()
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)
    
                    sector:FixSize()
                    table.insert(library.items, dropdown)
                    return dropdown
                end

                local dragging_selector = false
                local dragging_hue = false

                colorpicker.selector.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging_selector = true
                        colorpicker:RefreshSelector()
                    end
                end)

                colorpicker.selector.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging_selector = false
                        colorpicker:RefreshSelector()
                    end
                end)

                colorpicker.hue.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging_hue = true
                        colorpicker:RefreshHue()
                    end
                end)

                colorpicker.hue.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging_hue = false
                        colorpicker:RefreshHue()
                    end
                end)

                uis.InputChanged:Connect(function(input)
                    if dragging_selector and input.UserInputType == Enum.UserInputType.MouseMovement then
                        colorpicker:RefreshSelector()
                    end
                    if dragging_hue and input.UserInputType == Enum.UserInputType.MouseMovement then
                        colorpicker:RefreshHue()
                    end
                end)

                local inputBegan = function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        for i,v in pairs(window.OpenedColorPickers) do
                            if v and i ~= colorpicker.MainPicker then
                                i.Visible = false
                                window.OpenedColorPickers[i] = false
                            end
                        end

                        colorpicker.MainPicker.Visible = not colorpicker.MainPicker.Visible
                        window.OpenedColorPickers[colorpicker.MainPicker] = colorpicker.MainPicker.Visible
                        if window.OpenedColorPickers[colorpicker.MainPicker] then
                            colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                        else
                            colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        end
                    end
                end

                colorpicker.Main.InputBegan:Connect(inputBegan)
                colorpicker.Outline.InputBegan:Connect(inputBegan)
                colorpicker.BlackOutline2.InputBegan:Connect(inputBegan)

                sector:FixSize()
                table.insert(library.items, colorpicker)
                return colorpicker
            end

            function sector:AddKeybind(text,default,newkeycallback,callback,flag)
                local keybind = { }

                keybind.text = text or ""
                keybind.default = default or "None"
                keybind.callback = callback or function() end
                keybind.newkeycallback = newkeycallback or function(key) end
                keybind.flag = flag or text or ""

                keybind.value = keybind.default

                keybind.Main = Instance.new("TextLabel", sector.Items)
                keybind.Main.BackgroundTransparency = 1
                keybind.Main.Size = UDim2.fromOffset(156, 10)
                keybind.Main.ZIndex = 4
                keybind.Main.Font = window.theme.font
                keybind.Main.Text = keybind.text
                keybind.Main.TextColor3 = window.theme.itemscolor
                keybind.Main.TextSize = 15
                keybind.Main.TextStrokeTransparency = 1
                keybind.Main.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    keybind.Main.Font = theme.font
                    keybind.Main.TextColor3 = theme.itemscolor
                end)

                keybind.Bind = Instance.new("TextButton", keybind.Main)
                keybind.Bind.Name = "keybind"
                keybind.Bind.BackgroundTransparency = 1
                keybind.Bind.BorderColor3 = window.theme.outlinecolor
                keybind.Bind.ZIndex = 5
                keybind.Bind.BorderSizePixel = 0
                keybind.Bind.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 10, 0)
                keybind.Bind.Font = window.theme.font
                keybind.Bind.TextColor3 = Color3.fromRGB(136, 136, 136)
                keybind.Bind.TextSize = 15
                keybind.Bind.TextXAlignment = Enum.TextXAlignment.Right
                keybind.Bind.MouseButton1Down:Connect(function()
                    if getgenv().disablefeatures == true then return end
                    keybind.Bind.Text = "[...]"
                    keybind.Bind.TextColor3 = window.theme.accentcolor
                end)
                updateevent.Event:Connect(function(theme)
                    keybind.Bind.BorderColor3 = theme.outlinecolor
                    keybind.Bind.Font = theme.font
                end)

                if keybind.flag and keybind.flag ~= "" then
                    library.flags[keybind.flag] = keybind.default
                end

                local shorter_keycodes = {
                    ["LeftShift"] = "LSHIFT",
                    ["RightShift"] = "RSHIFT",
                    ["LeftControl"] = "LCTRL",
                    ["RightControl"] = "RCTRL",
                    ["LeftAlt"] = "LALT",
                    ["RightAlt"] = "RALT"
                }

                function keybind:Set(value)
                    if value == "None" then
                        keybind.value = value
                        keybind.Bind.Text = "[" .. value .. "]"
    
                        local size = textservice:GetTextSize(keybind.Bind.Text, keybind.Bind.TextSize, keybind.Bind.Font, Vector2.new(2000, 2000))
                        keybind.Bind.Size = UDim2.fromOffset(size.X, size.Y)
                        keybind.Bind.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 10 - keybind.Bind.AbsoluteSize.X, 0)
                        if keybind.flag and keybind.flag ~= "" then
                            library.flags[keybind.flag] = value
                        end
                        pcall(keybind.newkeycallback, value)
                    end

                    keybind.value = value
                    keybind.Bind.Text = "[" .. (shorter_keycodes[value.Name or value] or (value.Name or value)) .. "]"

                    local size = textservice:GetTextSize(keybind.Bind.Text, keybind.Bind.TextSize, keybind.Bind.Font, Vector2.new(2000, 2000))
                    keybind.Bind.Size = UDim2.fromOffset(size.X, size.Y)
                    keybind.Bind.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 10 - keybind.Bind.AbsoluteSize.X, 0)
                    if keybind.flag and keybind.flag ~= "" then
                        library.flags[keybind.flag] = value
                    end
                    pcall(keybind.newkeycallback, value)
                end
                keybind:Set(keybind.default and keybind.default or "None")

                function keybind:Get()
                    return keybind.value
                end

                uis.InputBegan:Connect(function(input, gameProcessed)
                    if not gameProcessed then
                        if keybind.Bind.Text == "[...]" then
                            keybind.Bind.TextColor3 = Color3.fromRGB(136, 136, 136)
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                keybind:Set(input.KeyCode)
                            else
                                keybind:Set("None")
                            end
                        else
                            if keybind.value ~= "None" and input.KeyCode == keybind.value then
                                pcall(keybind.callback)
                            end
                        end
                    end
                end)

                sector:FixSize()
                table.insert(library.items, keybind)
                return keybind
            end

            function sector:AddDropdown(text, items, default, multichoice, callback, flag)
                local dropdown = { }

                dropdown.text = text or ""
                dropdown.defaultitems = items or { }
                dropdown.default = default
                dropdown.callback = callback or function() end
                dropdown.multichoice = multichoice or false
                dropdown.values = { }
                dropdown.flag = flag or text or ""

                dropdown.MainBack = Instance.new("Frame", sector.Items)
                dropdown.MainBack.Name = "backlabel"
                dropdown.MainBack.ZIndex = 7
                dropdown.MainBack.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 34)
                dropdown.MainBack.BorderSizePixel = 0
                dropdown.MainBack.BackgroundTransparency = 1

                dropdown.Label = Instance.new("TextLabel", dropdown.MainBack)
                dropdown.Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.Label.BackgroundTransparency = 1
                dropdown.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 10)
                dropdown.Label.Position = UDim2.fromOffset(0, 0)
                dropdown.Label.Font = window.theme.font
                dropdown.Label.Text = dropdown.text
                dropdown.Label.ZIndex = 4
                dropdown.Label.TextColor3 = window.theme.itemscolor
                dropdown.Label.TextSize = 15
                dropdown.Label.TextStrokeTransparency = 1
                dropdown.Label.TextXAlignment = Enum.TextXAlignment.Left

                updateevent.Event:Connect(function(theme)
                    dropdown.Label.Font = theme.font
                    dropdown.Label.TextColor3 = theme.itemscolor
                end)

                dropdown.Main = Instance.new("TextButton", dropdown.MainBack)
                dropdown.Main.Name = "dropdown"
                dropdown.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.Main.BorderSizePixel = 0
                dropdown.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 16)
                dropdown.Main.Position = UDim2.fromOffset(0, 17)
                dropdown.Main.ZIndex = 5
                dropdown.Main.AutoButtonColor = false
                dropdown.Main.Font = window.theme.font
                dropdown.Main.Text = ""
                dropdown.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.Main.TextSize = 15
                dropdown.Main.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    dropdown.Main.Font = theme.font
                end)

                dropdown.Gradient = Instance.new("UIGradient", dropdown.Main)
                dropdown.Gradient.Rotation = 90
                dropdown.Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39))}

                dropdown.SelectedLabel = Instance.new("TextLabel", dropdown.Main)
                dropdown.SelectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.SelectedLabel.BackgroundTransparency = 1
                dropdown.SelectedLabel.Position = UDim2.fromOffset(5, 2)
                dropdown.SelectedLabel.Size = UDim2.fromOffset(130, 13)
                dropdown.SelectedLabel.Font = window.theme.font
                dropdown.SelectedLabel.Text = dropdown.text
                dropdown.SelectedLabel.ZIndex = 5
                dropdown.SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.SelectedLabel.TextSize = 15
                dropdown.SelectedLabel.TextStrokeTransparency = 1
                dropdown.SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
                updateevent.Event:Connect(function(theme)
                    dropdown.SelectedLabel.Font = theme.font
                end)

                dropdown.Nav = Instance.new("ImageButton", dropdown.Main)
                dropdown.Nav.Name = "navigation"
                dropdown.Nav.BackgroundTransparency = 1
                dropdown.Nav.LayoutOrder = 10
                dropdown.Nav.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 5)
                dropdown.Nav.Rotation = 90
                dropdown.Nav.ZIndex = 5
                dropdown.Nav.Size = UDim2.fromOffset(8, 8)
                dropdown.Nav.Image = "rbxassetid://4918373417"
                dropdown.Nav.ImageColor3 = Color3.fromRGB(210, 210, 210)

                dropdown.BlackOutline2 = Instance.new("Frame", dropdown.Main)
                dropdown.BlackOutline2.Name = "blackline"
                dropdown.BlackOutline2.ZIndex = 4
                dropdown.BlackOutline2.Size = dropdown.Main.Size + UDim2.fromOffset(6, 6)
                dropdown.BlackOutline2.BorderSizePixel = 0
                dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                dropdown.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                updateevent.Event:Connect(function(theme)
                    dropdown.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                end)

                dropdown.Outline = Instance.new("Frame", dropdown.Main)
                dropdown.Outline.Name = "blackline"
                dropdown.Outline.ZIndex = 4
                dropdown.Outline.Size = dropdown.Main.Size + UDim2.fromOffset(4, 4)
                dropdown.Outline.BorderSizePixel = 0
                dropdown.Outline.BackgroundColor3 = window.theme.outlinecolor
                dropdown.Outline.Position = UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    dropdown.Outline.BackgroundColor3 = theme.outlinecolor
                end)

                dropdown.BlackOutline = Instance.new("Frame", dropdown.Main)
                dropdown.BlackOutline.Name = "blackline"
                dropdown.BlackOutline.ZIndex = 4
                dropdown.BlackOutline.Size = dropdown.Main.Size + UDim2.fromOffset(2, 2)
                dropdown.BlackOutline.BorderSizePixel = 0
                dropdown.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                dropdown.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                updateevent.Event:Connect(function(theme)
                    dropdown.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                end)

                dropdown.ItemsFrame = Instance.new("ScrollingFrame", dropdown.Main)
                dropdown.ItemsFrame.Name = "itemsframe"
                dropdown.ItemsFrame.BorderSizePixel = 0
                dropdown.ItemsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                dropdown.ItemsFrame.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                dropdown.ItemsFrame.ScrollBarThickness = 2
                dropdown.ItemsFrame.ZIndex = 8
                dropdown.ItemsFrame.ScrollingDirection = "Y"
                dropdown.ItemsFrame.Visible = false
                dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.Main.AbsoluteSize.X, 0)

                dropdown.ListLayout = Instance.new("UIListLayout", dropdown.ItemsFrame)
                dropdown.ListLayout.FillDirection = Enum.FillDirection.Vertical
                dropdown.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

                dropdown.ListPadding = Instance.new("UIPadding", dropdown.ItemsFrame)
                dropdown.ListPadding.PaddingTop = UDim.new(0, 2)
                dropdown.ListPadding.PaddingBottom = UDim.new(0, 2)
                dropdown.ListPadding.PaddingLeft = UDim.new(0, 2)
                dropdown.ListPadding.PaddingRight = UDim.new(0, 2)

                dropdown.BlackOutline2Items = Instance.new("Frame", dropdown.Main)
                dropdown.BlackOutline2Items.Name = "blackline"
                dropdown.BlackOutline2Items.ZIndex = 7
                dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                dropdown.BlackOutline2Items.BorderSizePixel = 0
                dropdown.BlackOutline2Items.BackgroundColor3 = window.theme.outlinecolor2
                dropdown.BlackOutline2Items.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-3, -3)
                dropdown.BlackOutline2Items.Visible = false
                updateevent.Event:Connect(function(theme)
                    dropdown.BlackOutline2Items.BackgroundColor3 = theme.outlinecolor2
                end)

                dropdown.OutlineItems = Instance.new("Frame", dropdown.Main)
                dropdown.OutlineItems.Name = "blackline"
                dropdown.OutlineItems.ZIndex = 7
                dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                dropdown.OutlineItems.BorderSizePixel = 0
                dropdown.OutlineItems.BackgroundColor3 = window.theme.outlinecolor
                dropdown.OutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-2, -2)
                dropdown.OutlineItems.Visible = false
                updateevent.Event:Connect(function(theme)
                    dropdown.OutlineItems.BackgroundColor3 = theme.outlinecolor
                end)

                dropdown.BlackOutlineItems = Instance.new("Frame", dropdown.Main)
                dropdown.BlackOutlineItems.Name = "blackline"
                dropdown.BlackOutlineItems.ZIndex = 7
                dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(-2, -2)
                dropdown.BlackOutlineItems.BorderSizePixel = 0
                dropdown.BlackOutlineItems.BackgroundColor3 = window.theme.outlinecolor2
                dropdown.BlackOutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-1, -1)
                dropdown.BlackOutlineItems.Visible = false
                updateevent.Event:Connect(function(theme)
                    dropdown.BlackOutlineItems.BackgroundColor3 = theme.outlinecolor2
                end)

                dropdown.IgnoreBackButtons = Instance.new("TextButton", dropdown.Main)
                dropdown.IgnoreBackButtons.BackgroundTransparency = 1
                dropdown.IgnoreBackButtons.BorderSizePixel = 0
                dropdown.IgnoreBackButtons.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                dropdown.IgnoreBackButtons.Size = UDim2.new(0, 0, 0, 0)
                dropdown.IgnoreBackButtons.ZIndex = 7
                dropdown.IgnoreBackButtons.Text = ""
                dropdown.IgnoreBackButtons.Visible = false
                dropdown.IgnoreBackButtons.AutoButtonColor = false

                if dropdown.flag and dropdown.flag ~= "" then
                    library.flags[dropdown.flag] = dropdown.multichoice and { dropdown.default or dropdown.defaultitems[1] or "" } or (dropdown.default or dropdown.defaultitems[1] or "")
                end

                function dropdown:isSelected(item)
                    for i, v in pairs(dropdown.values) do
                        if v == item then
                            return true
                        end
                    end
                    return false
                end

                function dropdown:GetOptions()
                    return dropdown.values
                end

                function dropdown:updateText(text)
                    if not text then return end;
                    if #text >= 27 then
                        text = text:sub(1, 25) .. ".."
                    end
                    dropdown.SelectedLabel.Text = text
                end

                dropdown.Changed = Instance.new("BindableEvent")
                function dropdown:Set(value)
                    if type(value) == "table" then
                        dropdown.values = value
                        dropdown:updateText(table.concat(value, ", "))
                        pcall(dropdown.callback, value)
                    else
                        dropdown:updateText(value)
                        dropdown.values = { value }
                        pcall(dropdown.callback, value)
                    end
                    
                    dropdown.Changed:Fire(value)
                    if dropdown.flag and dropdown.flag ~= "" then
                        library.flags[dropdown.flag] = dropdown.multichoice and dropdown.values or dropdown.values[1]
                    end
                end

                function dropdown:Get()
                    return dropdown.multichoice and dropdown.values or dropdown.values[1]
                end

                dropdown.items = { }
                function dropdown:Add(v)
                    local Item = Instance.new("TextButton", dropdown.ItemsFrame)
                    Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Item.BorderSizePixel = 0
                    Item.Position = UDim2.fromOffset(0, 0)
                    Item.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset - 4, 20)
                    Item.ZIndex = 9
                    Item.Text = v
                    Item.Name = v
                    Item.AutoButtonColor = false
                    Item.Font = window.theme.font
                    Item.TextSize = 15
                    Item.TextXAlignment = Enum.TextXAlignment.Left
                    Item.TextStrokeTransparency = 1
                    dropdown.ItemsFrame.CanvasSize = dropdown.ItemsFrame.CanvasSize + UDim2.fromOffset(0, Item.AbsoluteSize.Y)

                    Item.MouseButton1Down:Connect(function()
                        if getgenv().disablefeatures == true then return end
                        if dropdown.multichoice then
                            if dropdown:isSelected(v) then
                                for i2, v2 in pairs(dropdown.values) do
                                    if v2 == v then
                                        table.remove(dropdown.values, i2)
                                    end
                                end
                                dropdown:Set(dropdown.values)
                            else
                                table.insert(dropdown.values, v)
                                dropdown:Set(dropdown.values)
                            end

                            return
                        else
                            dropdown.Nav.Rotation = 90
                            dropdown.ItemsFrame.Visible = false
                            dropdown.ItemsFrame.Active = false
                            dropdown.OutlineItems.Visible = false
                            dropdown.BlackOutlineItems.Visible = false
                            dropdown.BlackOutline2Items.Visible = false
                            dropdown.IgnoreBackButtons.Visible = false
                            dropdown.IgnoreBackButtons.Active = false
                        end

                        dropdown:Set(v)
                        return
                    end)

                    runservice.RenderStepped:Connect(function()
                        if dropdown.multichoice and dropdown:isSelected(v) or dropdown.values[1] == v then
                            Item.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
                            Item.TextColor3 = window.theme.accentcolor
                            Item.Text = " " .. v
                        else
                            Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.Text = v
                        end
                    end)

                    table.insert(dropdown.items, v)
                    dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * Item.AbsoluteSize.Y, 20, 156) + 4)
                    dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * Item.AbsoluteSize.Y) + 4)

                    dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                    dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                    dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                    dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
                end

                function dropdown:Remove(value)
                    local item = dropdown.ItemsFrame:FindFirstChild(value)
                    if item then
                        for i,v in pairs(dropdown.items) do
                            if v == value then
                                table.remove(dropdown.items, i)
                            end
                        end

                        dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * item.AbsoluteSize.Y, 20, 156) + 4)
                        dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * item.AbsoluteSize.Y) + 4)
    
                        dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                        dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                        dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                        dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size

                        item:Remove()
                    end
                end 

                for i,v in pairs(dropdown.defaultitems) do
                    dropdown:Add(v)
                end

                if dropdown.default then
                    dropdown:Set(dropdown.default)
                end

                local MouseButton1Down = function()
                    if getgenv().disablefeatures == true then return end
                    if dropdown.Nav.Rotation == 90 then
                        tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = -90 }):Play()
                        if dropdown.items and #dropdown.items ~= 0 then
                            dropdown.ItemsFrame.ScrollingEnabled = true
                            sector.Main.Parent.ScrollingEnabled = false
                            dropdown.ItemsFrame.Visible = true
                            dropdown.ItemsFrame.Active = true
                            dropdown.IgnoreBackButtons.Visible = true
                            dropdown.IgnoreBackButtons.Active = true
                            dropdown.OutlineItems.Visible = true
                            dropdown.BlackOutlineItems.Visible = true
                            dropdown.BlackOutline2Items.Visible = true
                        end
                    else
                        tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 90 }):Play()
                        dropdown.ItemsFrame.ScrollingEnabled = false
                        sector.Main.Parent.ScrollingEnabled = true
                        dropdown.ItemsFrame.Visible = false
                        dropdown.ItemsFrame.Active = false
                        dropdown.IgnoreBackButtons.Visible = false
                        dropdown.IgnoreBackButtons.Active = false
                        dropdown.OutlineItems.Visible = false
                        dropdown.BlackOutlineItems.Visible = false
                        dropdown.BlackOutline2Items.Visible = false
                    end
                end

                dropdown.Main.MouseButton1Down:Connect(MouseButton1Down)
                dropdown.Nav.MouseButton1Down:Connect(MouseButton1Down)

                dropdown.BlackOutline2.MouseEnter:Connect(function()
                    dropdown.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                end)
                dropdown.BlackOutline2.MouseLeave:Connect(function()
                    dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                end)

                sector:FixSize()
                table.insert(library.items, dropdown)
                return dropdown
            end

            function sector:AddSeperator(text)
                local seperator = { }
                seperator.text = text or ""

                seperator.main = Instance.new("Frame", sector.Items)
                seperator.main.Name = "Main"
                seperator.main.ZIndex = 5
                seperator.main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 10)
                seperator.main.BorderSizePixel = 0
                seperator.main.BackgroundTransparency = 1

                seperator.line = Instance.new("Frame", seperator.main)
                seperator.line.Name = "Line"
                seperator.line.ZIndex = 7
                seperator.line.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                seperator.line.BorderSizePixel = 0
                seperator.line.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 1)
                seperator.line.Position = UDim2.fromOffset(7, 5)

                seperator.outline = Instance.new("Frame", seperator.line)
                seperator.outline.Name = "Outline"
                seperator.outline.ZIndex = 6
                seperator.outline.BorderSizePixel = 0
                seperator.outline.BackgroundColor3 = window.theme.outlinecolor2
                seperator.outline.Position = UDim2.fromOffset(-1, -1)
                seperator.outline.Size = seperator.line.Size - UDim2.fromOffset(-2, -2)
                updateevent.Event:Connect(function(theme)
                    seperator.outline.BackgroundColor3 = theme.outlinecolor2
                end)

                seperator.label = Instance.new("TextLabel", seperator.main)
                seperator.label.Name = "Label"
                seperator.label.BackgroundTransparency = 1
                seperator.label.Size = seperator.main.Size
                seperator.label.Font = window.theme.font
                seperator.label.ZIndex = 8
                seperator.label.Text = seperator.text
                seperator.label.TextColor3 = Color3.fromRGB(255, 255, 255)
                seperator.label.TextSize = window.theme.fontsize
                seperator.label.TextStrokeTransparency = 1
                seperator.label.TextXAlignment = Enum.TextXAlignment.Center
                updateevent.Event:Connect(function(theme)
                    seperator.label.Font = theme.font
                    seperator.label.TextSize = theme.fontsize
                end)

                local textSize = textservice:GetTextSize(seperator.text, window.theme.fontsize, window.theme.font, Vector2.new(2000, 2000))
                local textStart = seperator.main.AbsoluteSize.X / 2 - (textSize.X / 2)

                sector.LabelBackFrame = Instance.new("Frame", seperator.main)
                sector.LabelBackFrame.Name = "LabelBack"
                sector.LabelBackFrame.ZIndex = 7
                sector.LabelBackFrame.Size = UDim2.fromOffset(textSize.X + 12, 10)
                sector.LabelBackFrame.BorderSizePixel = 0
                sector.LabelBackFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                sector.LabelBackFrame.Position = UDim2.new(0, textStart - 6, 0, 0)
                updateevent.Event:Connect(function(theme)
                    textSize = textservice:GetTextSize(seperator.text, theme.fontsize, theme.font, Vector2.new(2000, 2000))
                    textStart = seperator.main.AbsoluteSize.X / 2 - (textSize.X / 2)

                    sector.LabelBackFrame.Size = UDim2.fromOffset(textSize.X + 12, 10)
                    sector.LabelBackFrame.Position = UDim2.new(0, textStart - 6, 0, 0)
                end)

                sector:FixSize()
                return seperator
            end

            return sector
        end

        function tab:CreateConfigSystem(side)
            local configSystem = { }

            configSystem.configFolderDomain = 'Azfake Hub V3'--window.name .. "/" .. tostring(game.PlaceId)
            configSystem.AZFAKEconfigFolder= 'azfakeconfigs'
            configSystem.configs = 'configs'
            -- ConfigsDirectory = configFolder
            configSystem.ConfigsDirectory = configSystem.configFolderDomain .. '/' .. configSystem.configs;
            if (not isfolder(configSystem.configFolderDomain)) then
                warn('creating domain')
                makefolder(configSystem.configFolderDomain)
            else
                -- print('found')
            end
            if (not isfolder(configSystem.configFolderDomain .. '/' .. configSystem.AZFAKEconfigFolder)) then
                warn('creating folder cofg')
                makefolder(configSystem.configFolderDomain .. '/' .. configSystem.AZFAKEconfigFolder)
            end
            if (not isfolder(configSystem.configFolderDomain .. '/' .. configSystem.configs)) then
                warn('creating main conf')
                makefolder(configSystem.configFolderDomain .. '/' .. configSystem.configs)
            end

            --[[
                    cursor = false,
                    cursorimg = "https://t0.rbxcdn.com/42f66da98c40252ee151326a82aab51f",
                    backgroundcolor = Color3.fromRGB(20, 20, 20),
                    tabstextcolor = Color3.fromRGB(240, 240, 240),
                    bordercolor = Color3.fromRGB(60, 60, 60),
                    accentcolor = Color3.fromRGB(28, 56, 139),
                    accentcolor2 = Color3.fromRGB(16, 31, 78),
                    outlinecolor = Color3.fromRGB(60, 60, 60),
                    outlinecolor2 = Color3.fromRGB(0, 0, 0),
                    sectorcolor = Color3.fromRGB(30, 30, 30),
                    toptextcolor = Color3.fromRGB(255, 255, 255),
                    topheight = 48,
                    topcolor = Color3.fromRGB(30, 30, 30),
                    topcolor2 = Color3.fromRGB(30, 30, 30),
                    buttoncolor = Color3.fromRGB(49, 49, 49),
                    buttoncolor2 = Color3.fromRGB(39, 39, 39),
                    itemscolor = Color3.fromRGB(200, 200, 200),
                    itemscolor2 = Color3.fromRGB(210, 210, 210)
            ]]


            configSystem.sector = tab:CreateSector("Configs", side or "left")
            configSystem.rightsector = tab:CreateSector('Configs', 'right')
            configSystem.extrasector = tab:CreateSector('Configs', 'extra')
            local gname = GAMENAME; --game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
            local ConfigName = configSystem.sector:AddTextbox("Config Name", "", ConfigName, function() end, "")
            local autoloadindex = configSystem.ConfigsDirectory .. '/' .. 'settings.conf' 

            local default = 'default' --tostring(listfiles(configSystem.ConfigsDirectory)[1] or ""):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".txt", "")
            local templateSettings = {
                autoload = true;
                fileautoload = 'default'; -- autoloadfile
                theme = '';
            };
            local isWritten = nil;
            pcall(function()
                isWritten = httpservice:JSONDecode(readfile(autoloadindex))
            end)
            if isWritten == nil then 
                writefile(autoloadindex, httpservice:JSONEncode(templateSettings))
            end;
            local worked,notwork = pcall(function()
                default = httpservice:JSONDecode(readfile(autoloadindex))['fileautoload']
                --print(default)
            end)
            if pcall(readfile, autoloadindex) then 
                --print('has settings')
                local configtable = httpservice:JSONDecode(readfile(autoloadindex))
                if not configtable['theme'] then 
                    --print('writing theme')
                    --print('write theme')
                    configtable['theme'] = '';
                    writefile(autoloadindex,httpservice:JSONEncode(configtable))
                    --print('written theme')
                end
                if not configtable['fileautoload'] then 
                    writefile(autoloadindex,httpservice:JSONEncode(templateSettings))
                end;
            end

            local function getsettings()
                local a,b = pcall(readfile, autoloadindex)
                if a then 
                    b = httpservice:JSONDecode(b)
                end
                return b
            end;
            
            
            -- print('default '..default)
            local selectedConfig = ''
            local Config = configSystem.sector:AddDropdown("Configs", {}, default, false, function(xconfig) selectedConfig = xconfig;  end, "") -- print(selectedConfig)
            Config:Set(default)
            -- make the config dropdown instantly set to the previous one
            for i,v in pairs(listfiles(configSystem.ConfigsDirectory)) do
                -- print(i,v)
                if v:find(".txt") and tostring(v) ~= 'settings.conf' then
                    Config:Add(tostring(v):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".txt", ""))
                end
            end


            local function clientUpdTheme()
                if getgenv().watermarktable then 
                   getgenv().watermarktable:UpdateTheme(library['theme'])
                end
                window:UpdateTheme(library['theme'])
            end

            --

            local selectedTheme = ''
            local createTheme = '';

            if getsettings() then 
                selectedTheme = getsettings()['theme']
            end

            configSystem.savetheme = function(toSave)
                local themewriting = toSave or selectedTheme
                if themewriting == '' or themewriting == ' ' then return end;
                local themelist = {}
                local function geteq(a)
                    local b = nil;
                    for i,v in next, library.flags do 
                        --print(i)
                        --if i == 'Watermark' then print('----') end;
                        if tostring(i) ==  a then
                            --print('found')
                            b = v;
                            break
                        end
                        --print(i,v)
                    end
                    return b
                end
                for i,v in next, library.items do 
                    if v.istheme then 
                        local flagdata = geteq(v.flag)
                        --print('is theme',v.flag, flagdata)
                        themelist[v.flag] = flagdata; --library.flags[v.flag] -- gets toggle flag name into library flag value
                    end;
                end
                local newthemesave = {}
                for i,v in next, themelist do 
                    if (typeof(v) == "Color3") then
                        newthemesave[i] = { v.R, v.G, v.B }
                    elseif (tostring(v):find("Enum.KeyCode")) then
                        newthemesave[i] = "Enum.KeyCode." .. v.Name
                    elseif (tostring(v):find("Enum.UserInputType")) then
                        newthemesave[i] = "Enum.UserInputType." .. v.Name
                    elseif (typeof(v) == "table") then
                        newthemesave[i] = { v }
                    else
                        newthemesave[i] = v
                    end
                end
                newthemesave = httpservice:JSONEncode(newthemesave)
                writefile(configSystem.ConfigsDirectory .. '/' .. themewriting .. ".mixoustheme", newthemesave)
            end; -- could pass a string to make it custom args
            configSystem.loadtheme = function(toLoad)
                local themetoload = toLoad or selectedTheme
                local currentTheme = httpservice:JSONDecode(readfile(autoloadindex))['theme'];
                local newTheme, filecontents = pcall(readfile, configSystem.ConfigsDirectory .. '/'.. themetoload..'.mixoustheme')
                if not newTheme then -- httpservice:JSONDecode
                    return (__getnotify and __getnotify('Unable to read file.', 3) or '')
                end
                --print(newTheme,selectedTheme)
                newTheme = httpservice:JSONDecode(filecontents); --(configSystem.ConfigsDirectory .. '/'.. selectedTheme..'.mixoustheme');
                local tempthemedump = {}
                for i,v in pairs(newTheme) do
                    if tostring(v):find('Enum.UserInput') then 
                        local getConv = string.gsub(tostring(v),'Enum.UserInputType.','')
                        tempthemedump[i] = Enum.UserInputType[getConv]
                    elseif (typeof(v) == "table") then
                        if (typeof(v[1]) == "number") then
                            tempthemedump[i] = Color3.new(v[1], v[2], v[3])
                        elseif (typeof(v[1]) == "table") then
                            tempthemedump[i] = v[1]
                        end
                    elseif (tostring(v):find("Enum.KeyCode.")) then
                        tempthemedump[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")]
                    else
                        tempthemedump[i] = v
                    end
                end
                library.flags = tempthemedump;
                for i,v in pairs(library.flags) do
                    for i2,v2 in pairs(library.items) do
                        if (i ~= nil and i ~= "" and i ~= "Configs_Name" and i ~= "Configs" and v2.flag ~= nil) then
                            if (v2.flag == i) then
                                pcall(function() 
                                    v2:Set(v)
                                end)
                            end
                        end
                    end
                end
            end;    

            configSystem.extrasector:AddTextbox('New Theme', nil, function(x)
                createTheme = x;
            end)
            local Theme = configSystem.extrasector:AddDropdown('Select Theme', {}, selectedTheme, false, function(chosen)
                selectedTheme = chosen;
            end)
            local lastTheme = ''
            for i,v in pairs(listfiles(configSystem.ConfigsDirectory)) do
                if v:find(".mixoustheme") and tostring(v) ~= 'settings.conf' then
                    local nameTheme = tostring(v):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".mixoustheme", "")
                    lastTheme = nameTheme
                    Theme:Add(nameTheme)
                end
            end
            --selectedTheme = lastTheme;
            Theme:Set(selectedTheme)
            configSystem.extrasector:AddButton('Create Theme', function()
                if createTheme == '' then return end;
                -- either would create a blank theme
                -- or save to a new theme
                -- yeah fuckt hat coukld be possbile nopw()())
                if not table.find(Theme.defaultitems, createTheme) then 
                    Theme:Add(createTheme)
                end
                local isExisting = pcall(readfile, configSystem.ConfigsDirectory .. '/'.. createTheme..'.mixoustheme')
                if isExisting then 
                    local result = library:CheckForPermission(`Are you sure you want to override the config\n"{createTheme}"?`) -- This will set it to default.
                    if result == false then 
                        return;
                    end
                end
                writefile(configSystem.ConfigsDirectory .. '/'.. createTheme..'.mixoustheme', '{}')
                if __getnotify then 
                    __getnotify(`{isExisting == false and 'Created' or 'Overritten'} new theme`)
                end
            end)
            configSystem.extrasector:AddButton('Load Theme', function()
                if selectedTheme == '' then return end;
                configSystem.loadtheme() -- selectedTheme
            end);
            configSystem.extrasector:AddButton('Save Theme', function()
                --print(selectedTheme)
                if selectedTheme == '' then return end;
                --print('save pls')
                configSystem.savetheme()
                local file = httpservice:JSONDecode(readfile(autoloadindex))
                file['theme'] = selectedTheme
                writefile(autoloadindex,httpservice:JSONEncode(file))
            end)

            -- my patience is
            -- is this enteratijwikojgnweikg


            -- graa graa boom

            -- make theme load on exec
            -- make button load theme

            local theme = library.theme;
            configSystem.rightsector:AddColorpicker('Accent Colour 1', theme.accentcolor , function(ztx)
                library['theme']['accentcolor'] = ztx
                clientUpdTheme() -- if flag, updtheme then upd theme
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Accent Colour 2',theme.accentcolor2, function(ztx)
                library['theme']['accentcolor2'] = ztx
                clientUpdTheme() -- if flag, updtheme then upd theme
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Background Colour',theme.backgroundcolor, function(ztx)
                library['theme']['backgroundcolor'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Outline Colour 1',theme.outlinecolor, function(ztx)
                library['theme']['outlinecolor'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Outline Colour 2',theme.outlinecolor2, function(ztx)
                library['theme']['outlinecolor2'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Sector Colour',theme.sectorcolor, function(ztx)
                library['theme']['sectorcolor'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Title Colour', theme.toptextcolor , function(ztx)
                library['theme']['toptextcolor'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddSlider('Topbar Height', 0, theme.topheight, 60, 1 , function(ztx)
                library['theme']['topheight'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Top Colour 1', theme.topcolor , function(ztx)
                library['theme']['topcolor'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Top Colour 2', theme.topcolor2 , function(ztx)
                library['theme']['topcolor2'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Button Colour 1', theme.buttoncolor , function(ztx)
                library['theme']['buttoncolor'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Button Colour 2', theme.buttoncolor2 , function(ztx)
                library['theme']['buttoncolor2'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Items Colour 1', theme.itemscolor , function(ztx)
                library['theme']['itemscolor'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddColorpicker('Items Colour 2', theme.itemscolor2 , function(ztx)
                library['theme']['itemscolor2'] = ztx
                clientUpdTheme()
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddToggle('Watermark', false, function(e)
                getgenv().watermarktable:SetState(e == false and 'Disable' or 'Active')
            end, nil, {['properties'] = {istheme = true}})
            configSystem.rightsector:AddButton('Reset Keybinds',function()
                if window.Tabs then 
                    for i, item in next, library.items do 
                        if item.Main and item.Main.Name == 'keybind' then 
                            pcall(item.Unbind)
                        end
                    end;
                    --[[
                        local function sueReset(v)

                        end
                        for _, Item in next, Tab.SectorsLeft do 
                            sueReset(Item)
                        end
                        for _, Item in next, Tab.SectorsLeft do 
                            sueReset(Item)
                        end
                        for _, Item in next, Tab.SectorsLeft do 
                            sueReset(Item)
                        end
                    ]]
                end
            end) -- configurations
            configSystem.extrasector:AddButton('Reset Theme',function() -- Colors, the em
                library.theme = library.defaulttheme -- theme --
                for i,v in next, library.theme do 
                    if library.defaulttheme[i] ~= v then 
                        --print('should swap, '..i)
                    else
                        --print(library.defaulttheme[i],v)
                    end
                end
                for i,v in next, library.items do 
                    if type(v) == 'table' and v.iscolorpicker then 
                        v:Set(v.default)
                    end
                end
                clientUpdTheme()
            end)

            --
            local autoloadfile = nil  -- could make it open then save it on game close
            -- index
            local autoloadsetting = false 
            local IsFileSet = false;
            local configsdir = 'configs'
            local autosaving = false
            local previousautosavefile = ''
            -- httpdecode or separate?
            -- if autoloadindex == 'settings.conf' then 
            --     autoloadindex = 'default.txt'
            -- end
            if not isfile(autoloadindex)  then 
                local tablepack = {
                    autoload = false;
                    fileautoload = '';
                    theme = '';
                }
                writefile(autoloadindex,httpservice:JSONEncode(tablepack))
            else
                IsFileSet = true;
            end
            --warn(autoloadindex)
            local worked,notwork = pcall(function()
                autoloadfile = httpservice:JSONDecode(readfile(autoloadindex))
            end)
            if notwork then 
                warn('didnt work')
                local tablepack = {
                    autoload = false;
                    fileautoload = 'default';
                    theme = '';
                }
                writefile(autoloadindex,httpservice:JSONEncode(tablepack))
            end
            
            local beenset = false
            configSystem.AutoLoad = configSystem.sector:AddToggle('Auto Load',autoloadfile['autoload'],function(xtate)
                local Success = Config:Get()-- pcall(readfile, Config:Get())
                if Success and Config:Get() ~= 'settings.conf' then 
                    --print('setting autoload to '..Config:Get())
                    local pack = {
                        autoload = xtate;
                        fileautoload = Config:Get();
                        theme = getsettings() and getsettings()['theme'] or '';
                    }
                    writefile(autoloadindex,httpservice:JSONEncode(pack))
                    autoloadfile = pack; --httpservice:JSONDecode(readfile(autoloadindex)) -- if false save the file its autoloading and check if the index name is autoload then set to this autoload value 
                    if beenset == false then 
                        configevent:Fire('setautoloadf')
                    end
                end
            end,'AUTOLOADNOSAVEMENT')
            configSystem.AutoLoad:Set(autoloadfile['autoload'])
            -- configSystem.SetAutoLoadFile = configSystem.sector:AddButton("Set Auto load", function()
            --     -- print(Config:Get())
            --     local Success = Config:Get()-- pcall(readfile, Config:Get())
            --     if Success and Config:Get() ~= 'settings.conf' then 
            --         pcall(function()
            --             local configname = Config:Get() -- configSystem.configFolder .. '/' .. ConfigName:Get() .. ".txt" 

            --             local tablepack = {

            --             }
            --             local pack = {
            --                 autoload = autoloadfile['autoload'];
            --                 fileautoload = configname;
            --             }
            --             -- if not isfile('autoload.txt') then 
            --             --     writefile('autoload.txt',configname)
            --             -- end
            --             writefile(autoloadindex,httpservice:JSONEncode(pack))-- save the file its autoloading
            --             autoloadfile = httpservice:JSONDecode(readfile(autoloadindex)) -- new addon

            --         end)
            --     end

            -- end)
            local menubtton = configSystem.sector:AddKeybindAttachment('Open Menu') -- string.split(tostring(window.hidebutton))[3]
            menubtton:AddKeybind(Enum.KeyCode.LeftAlt)
            function awlafwa()
                --warn('key press..'..string.split(tostring(menubtton:GetKeybind()),'.')[3])
                if menubtton:GetKeybind() ~= nil and  menubtton:GetKeybind() ~= Enum.UserInputType.MouseButton1 and  menubtton:GetKeybind() ~= Enum.UserInputType.MouseButton2 then 
                    window.hidebutton = menubtton:GetKeybind()
                    --print(menubtton:GetKeybind())
                else
                    --print(menubtton:GetKeybind())
                end
            end
            menubtton:keychangedmethod(awlafwa)

            local universeId = httpservice:JSONDecode(game:HttpGet(`https://apis.roblox.com/universes/v1/places/{game.PlaceId}/universe`))['universeId']
            hasAutoloaded = false;
            configSystem.savefunc = function()
                local configwriting = Config:Get()
                if configwriting == '' or configwriting == ' ' then return end;
                local config = {}
                local function getTable(ii)
                    local tblget = true;
                    for i,v in next, library.items do 
                        --print(v.flag,ii,v.istheme)
                        if v.flag and tostring(v.flag) == tostring(ii) then 
                            if v.dontsave or v.istheme then 
                                tblget = v.dontsave and 'nosave' or v.istheme and 'istheme' --true; --'istheme';
                                --print('worked, dont save')
                            else
                                tblget = true; ---tblget = v;
                            end
                            --print('save flag', v.flag) --print('save   ing',v.flag)
                            break
                        end
                    end
                    return tblget
                end
                local timeelspaesd = 0
                -- task.spawn(function()
                 --   repeat 
                       -- task.wait(0.1)
                       -- timeelspaesd += 0.1
                    --until timeelspaesd > 1.5
                --end)
                for i,v in pairs(library.flags) do -- flags are used so you can have the same textbox with the same text name with a different value to save and it wont bug when loading and load the two textboxes with the same value
                    --print('flag',i,v)
                    local shouldSave = getTable(i) -- getTable(i) == false
                    if shouldSave == false then  end -- print('no save',i,'loop')
                    if (v ~= nil and v ~= "" and v ~= 'AUTOLOADNOSAVEMENT') and shouldSave == true and v ~= 'configsave' then -- and v.Name ~= autoload and the flag for autoload isnt equal to the autoload we use on our configurations tab
                        --print('loop save shouldsave',i,shouldSave)
                        if (typeof(v) == "Color3") then
                            config[i] = { v.R, v.G, v.B }
                        elseif (tostring(v):find("Enum.KeyCode")) then
                            config[i] = "Enum.KeyCode." .. v.Name
                        elseif (tostring(v):find("Enum.UserInputType")) then
                            config[i] = "Enum.UserInputType." .. v.Name
                        elseif (typeof(v) == "table") then
                            config[i] = { v }
                        else
                            config[i] = v
                        end
                    end
                end
                --print(`dumped at {timeelspaesd}`)
                for i,v in next, config do 
                    if tostring(v):find('InputType') then 
                        --print(i,v)
                    end
                end
                -- read current config
                -- or we can store them under a game place or universe
                -- ['10101'] = {config}

                --writefile(configSystem.configFolder.. "/"..gname .. Config:Get() .. ".txt", httpservice:JSONEncode(config))
                --config = {universeId} = config
                --if not pcall(readfile, configSystem.ConfigsDirectory..'/'..configwriting..".txt") then 

                --end
                --configwriting = configwriting..".txt"
                -- if shouldSave == 'istheme' then 
                --     configwriting = selectedTheme..'.mixoustheme'
                -- end
                local _, currentconfig = pcall(readfile, configSystem.ConfigsDirectory..'/'..configwriting.. ".txt")
                local uniqueTable = nil;
                pcall(function()
                    uniqueTable = httpservice:JSONDecode(currentconfig); --{};
                end)
                if uniqueTable == nil or _ == false then 
                    --print('was nil so reset')
                    uniqueTable = {}
                end
                if not uniqueTable[tostring(universeId)] then 
                    uniqueTable[tostring(universeId)] = {};
                end
                for i,v in next, config do 
                    uniqueTable[tostring(universeId)][i] = v -- still doesnt loop all flags for some reason but fuck that and leave it
                end
                --uniqueTable[tostring(universeId)] = config
                uniqueTable = httpservice:JSONEncode(uniqueTable)
              --  print(uniqueTable)
                for i,v in next, config do 
                 --   print(i,v)
                end
                --local configsav = httpservice:JSONEncode(config)
                writefile(configSystem.ConfigsDirectory .. '/' .. configwriting .. ".txt", uniqueTable)
                --print(`saved at {timeelspaesd}`) -- dusamped
            end

            -- toggle . flag and library .  flag are two different things :smile:

            -- extract config for game;
            -- import config for game
            
            configSystem.AutoSave = configSystem.sector:AddToggle('Auto Save',true,function(xstate)
                autosaving = xstate
                getgenv().newloadedui = not xstate; -- true = false, false = true;
                if autosaving == true then 
                    task.spawn(function()
                        while task.wait(6) do 
                            if getgenv().newloadedui then break end; -- print('newbreak')  print('new exec debug')
                            if getgenv().currentHash ~= windowHash then  break end;
                            if hasAutoloaded == true then 
                                configSystem.savefunc()
                            end
                        end
                    end) -- endedloop
                end
            end) -- savte

            configSystem.sector:AddSeperator('')
            configSystem.Create = configSystem.sector:AddButton("Create", function()
                for i,v in pairs(listfiles(configSystem.ConfigsDirectory)) do
                    Config:Remove(tostring(v):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".mixoustheme", ""))
                    --print('removing '..tostring(v):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".mixoustheme", ""))
                end

                if Config:Get() and Config:Get() ~= "" then
                    local config = {}
    
                    for i,v in pairs(library.flags) do
                        if (v ~= nil and v ~= "" and v ~= 'AUTOLOADNOSAVEMENT') then
                            if (typeof(v) == "Color3") then
                                config[i] = { v.R, v.G, v.B }
                            elseif (tostring(v):find("Enum.KeyCode")) then
                                config[i] = v.Name
                            elseif (typeof(v) == "table") then
                                config[i] = { v }
                            else
                                config[i] = v
                            end
                        end
                    end
                    --print(ConfigName:Get())
                    --print(configSystem.configFolder .. "/" .. 'configs' .. ConfigName:Get() .. ".txt")
                    -- print(configSystem.ConfigsDirectory .. "/" .. configsdir .. '/' .. ConfigName:Get() .. ".txt")
                    local configrs = httpservice:JSONEncode(config)
                    pcall(function()
                        local CreateMessage = 'Created Config - '..ConfigName:Get();
                        getgenv().__getnotify(CreateMessage,3)
                    end)
                    writefile(configSystem.ConfigsDirectory .. '/' .. ConfigName:Get() .. ".txt", configrs)

                    --writefile(configSystem.ConfigsDirectory .. '/' .. Config:Get() .. ".txt", httpservice:JSONEncode(config))
                    --print('wrnt')
                    for i,v in pairs(listfiles(configSystem.ConfigsDirectory)) do
                        if v:find(".txt") then
                            Config:Add(tostring(v):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".txt", ""))
                        end
                    end
                end
            end)

            configSystem.Save = configSystem.sector:AddButton("Save", function() -- make this a function you can call
                local config = {} -- make this a function you can call
                if Config:Get() and Config:Get() ~= "" and Config:Get() ~= ' ' then
                    configSystem.savefunc()
                    if getgenv().__getnotify then 
                        local NotifyMessage = 'Saved To '..Config:Get()
                        getgenv().__getnotify(NotifyMessage,3)
                    end
                -- elseif selectedConfig ~= '' then 
                --     local config = {}
                --     for i,v in pairs(library.flags) do
                --         if (v ~= nil and v ~= "") then
                --             if (typeof(v) == "Color3") then
                --                 config[i] = { v.R, v.G, v.B }
                --             elseif (tostring(v):find("Enum.KeyCode")) then
                --                 config[i] = "Enum.KeyCode." .. v.Name
                --             elseif (typeof(v) == "table") then
                --                 config[i] = { v }
                --             else
                --                 config[i] = v
                --             end
                --         end
                --     end

                --     --writefile(configSystem.configFolder.. "/"..gname .. Config:Get() .. ".txt", httpservice:JSONEncode(config))
                --     writefile(configSystem.ConfigsDirectory .. '/' .. selectedConfig .. ".txt", httpservice:JSONEncode(config))
                --     if getgenv().__getnotify then 
                --         local NotifyMessage = 'Saved To '..selectedConfig
                --         getgenv().__getnotify(NotifyMessage,3)
                --     end
                end
            end)
            -- ToOurPosition
            configSystem.Load = configSystem.sector:AddButton("Load", function()
                local Success = pcall(readfile, configSystem.ConfigsDirectory .. '/' .. Config:Get() .. ".txt")
                local SuccessDropdown = pcall(readfile, configSystem.ConfigsDirectory .. '/' .. selectedConfig .. ".txt")
                if (Success) then
                    pcall(function() 
                        local ReadConfig =  httpservice:JSONDecode(readfile(configSystem.ConfigsDirectory .. '/' .. Config:Get() .. ".txt"))--httpservice:JSONDecode(readfile(configSystem.configFolder .. "/" .. Config:Get() .. ".txt"))
                        local NewConfig = {}
                        local actualread = {}
                        warn('loading func')
                        for i,v in next, ReadConfig do 
                            --print(i,universeId)
                            if tostring(i) == tostring(universeId) then
                                --print('loading save in universe')
                                actualread = v
                            end
                        end
                        for i,v in pairs(actualread) do
                            if tostring(v):find('Enum.UserInput') then 
                                --print(i,v,'cuz of input')
                                --print('keybind loading input type,',tostring(v):gsub("Enum.UserInputType.", ""))
                                local getConv = string.gsub(tostring(v),'Enum.UserInputType.','')
                                --print('input to '..getConv)
                                --print(Enum.KeyCode[getConv])
                                NewConfig[i] = Enum.UserInputType[getConv]
                            elseif (typeof(v) == "table") then
                                if (typeof(v[1]) == "number") then
                                    NewConfig[i] = Color3.new(v[1], v[2], v[3])
                                elseif (typeof(v[1]) == "table") then
                                    NewConfig[i] = v[1]
                                end
                            elseif (tostring(v):find("Enum.KeyCode.")) then
                                --print('cuz of keycode')
                                NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")]
                            -- elseif (tostring(v):find("Enum.UserInput")) then -- Type.
                            --     NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.UserInputType.", "")]
                            --     print('userinput '..i,v) -- USERINPUT T YPE, 
                            else
                                --print('set it other',i,v)
                                NewConfig[i] = v
                            end
                        end
                        -- for i,v in pairs(actualread) do
                        --     if tostring(v):find('Enum.UserInput') then 
                        --         --print(i,v,'cuz of input')
                        --         print('loading input type')
                        --         NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.UserInputType.", "")]
                        --     elseif (typeof(v) == "table") then
                        --         if (typeof(v[1]) == "number") then
                        --             NewConfig[i] = Color3.new(v[1], v[2], v[3])
                        --         elseif (typeof(v[1]) == "table") then
                        --             NewConfig[i] = v[1]
                        --         end
                        --     elseif (tostring(v):find("Enum.KeyCode.")) then
                        --         --print('cuz of keycode')
                        --         NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")]
                        --     -- elseif (tostring(v):find("Enum.UserInput")) then -- Type.
                        --     --     NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.UserInputType.", "")]
                        --     --     print('userinput '..i,v) -- USERINPUT T YPE, 
                        --     else
                        --         --print('set it other',i,v)
                        --         NewConfig[i] = v
                        --     end
                        -- end
                        -- for i,v in next, NewConfig do 
                        --     print(i,v)
                        -- end
                        --library.flags = NewConfig
                        -- for i,v in next, NewConfig do 
                        --     if library.flags[i] ~= nil then 
                        --         library.flags[i] = v
                        --     end
                        -- end
                        -- for i,v in next, NewConfig do 
                        --     library.flags[i] = v
                        --     -- if library.flags[i] ~= nil then 
                        --     --     library.flags[i] = v
                        --     -- end
                        -- end
                        for i,v in next, NewConfig do 
                            pcall(function()
                                library.flags[i] = v
                            end)
                            -- if library.flags[i] ~= nil then 
                            --     library.flags[i] = v
                            -- end
                        end
    
                        for i,v in pairs(library.flags) do
                            for i2,v2 in pairs(library.items) do
                                if (i ~= nil and i ~= "" and i ~= "Configs_Name" and i ~= "Configs" and v2.flag ~= nil) then
                                    if (v2.flag == i) then
                                        pcall(function() 
                                            --print(i,v)
                                            -- if v2:Get() ~= v then 
                                            --     v2:Set(v)
                                            -- end
                                            v2:Set(v)
                                        end)
                                    end
                                end
                            end
                        end
                        if getgenv().__getnotify then 
                            local NotifyMessage = 'Loaded '..Config:Get()
                            getgenv().__getnotify(NotifyMessage,3)
                        end
                    end)
                -- elseif (SuccessDropdown) then 
                --     pcall(function() 
                --         local ReadConfig =  httpservice:JSONDecode(readfile(configSystem.ConfigsDirectory .. '/' .. selectedConfig .. ".txt"))--httpservice:JSONDecode(readfile(configSystem.configFolder .. "/" .. Config:Get() .. ".txt"))
                --         local NewConfig = {}
    
                --         for i,v in pairs(ReadConfig) do
                --             if (typeof(v) == "table") then
                --                 if (typeof(v[1]) == "number") then
                --                     NewConfig[i] = Color3.new(v[1], v[2], v[3])
                --                 elseif (typeof(v[1]) == "table") then
                --                     NewConfig[i] = v[1]
                --                 end
                --             elseif (tostring(v):find("Enum.KeyCode.")) then
                --                 NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")]
                --             else
                --                 NewConfig[i] = v
                --             end
                --         end
    
                --         library.flags = NewConfig
    
                --         for i,v in pairs(library.flags) do
                --             for i2,v2 in pairs(library.items) do
                --                 if (i ~= nil and i ~= "" and i ~= "Configs_Name" and i ~= "Configs" and v2.flag ~= nil) then
                --                     if (v2.flag == i) then
                --                         pcall(function() 
                --                             v2:Set(v)
                --                         end)
                --                     end
                --                 end
                --             end
                --         end
                --         if getgenv().__getnotify then 
                --             local NotifyMessage = 'Loaded '..selectedConfig
                --             getgenv().__getnotify(NotifyMessage,3)
                --         end
                --     end)
                end
            end)

            configSystem.Delete = configSystem.sector:AddButton("Delete", function()
                -- for i,v in pairs(listfiles(configSystem.configFolder)) do
                --     Config:Remove(tostring(v):gsub(configSystem.configFolder..gname .. "\\", ""):gsub(".txt", ""))
                -- end

                for i,v in pairs(listfiles(configSystem.ConfigsDirectory)) do
                    Config:Remove(tostring(v):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".txt", ""))
                end

                --if (not Config:Get() or Config:Get() == "") then return end
                --if (not isfile(configSystem.configFolder..gname .. "/" .. Config:Get() .. ".txt")) then return end
                --delfile(configSystem.configFolder..gname .. "/" .. Config:Get() .. ".txt")


                if (not Config:Get() or Config:Get() == "") then return end
                if (not isfile( configSystem.ConfigsDirectory .. '/' .. Config:Get() .. ".txt")) then return end
                delfile(configSystem.ConfigsDirectory .. "/" .. Config:Get() .. ".txt")
                for i,v in pairs(listfiles(configSystem.ConfigsDirectory)) do
                    if v:find(".txt") then
                        --Config:Add(tostring(v):gsub(configSystem.configFolder..gname .. "\\", ""):gsub(".txt", ""))
                        Config:Add(tostring(v):gsub(configSystem.ConfigsDirectory .. "\\", ""):gsub(".txt", ""))
                    end
                end
            end)

            -- configSystem.sector:AddButton("show flags", function() -- donty use on type soul
            --     for i,v in next, library.flags do 
            --         --print(i,v, 'loopshowflag')
            --     end
            -- end)

            updateevent:Fire(library.theme)
            local function autoLoad()
                if IsFileSet == true then 
                    --print('is file set')
                    local Success = pcall(readfile, configSystem.ConfigsDirectory .. '/' .. autoloadfile['fileautoload']..'.txt')
                    local themetoload, themecontent = pcall(readfile, configSystem.ConfigsDirectory .. '/' .. autoloadfile['theme']..'.mixoustheme')
                    --print(Success)
                    --print(autoloadfile['fileautoload'])
                    if (Success) then
                        --pcall(function() -- Config:Get()
                            local ReadConfig =  httpservice:JSONDecode(readfile(configSystem.ConfigsDirectory .. '/' .. autoloadfile['fileautoload'] .. ".txt"))--httpservice:JSONDecode(readfile(configSystem.configFolder .. "/" .. Config:Get() .. ".txt"))
                            local NewConfig = {}
                            local actualread = {}
                            for i,v in next, ReadConfig do 
                                if tostring(i) == tostring(universeId) then
                                    --print('loading save in universe')
                                    actualread = v
                                end
                            end
                            --print('universe save loop')
                            for i,v in pairs(actualread) do
                                --print('save')
                                if tostring(v):find('Enum.UserInput') then 
                                    --print(i,v,'cuz of input')
                                    --print('keybind loading input type,',tostring(v):gsub("Enum.UserInputType.", ""))
                                    local getConv = string.gsub(tostring(v),'Enum.UserInputType.','')
                                    --print('input to '..getConv)
                                    --print(Enum.KeyCode[getConv])
                                    NewConfig[i] = Enum.UserInputType[getConv]
                                elseif (typeof(v) == "table") then
                                    if (typeof(v[1]) == "number") then
                                        NewConfig[i] = Color3.new(v[1], v[2], v[3])
                                    elseif (typeof(v[1]) == "table") then
                                        NewConfig[i] = v[1]
                                    end
                                elseif (tostring(v):find("Enum.KeyCode.")) then
                                    --print('cuz of keycode')
                                    NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")]
                                -- elseif (tostring(v):find("Enum.UserInput")) then -- Type.
                                --     NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.UserInputType.", "")]
                                --     print('userinput '..i,v) -- USERINPUT T YPE, 
                                else
                                    --print('set it other',i,v)
                                    NewConfig[i] = v
                                end
                            end
                            for i,v in next, NewConfig do 
                                --print(i,v,'loop value')
                            end
                            -- for i,v in pairs(actualread) do
                            --     if (typeof(v) == "table") then
                            --         if (typeof(v[1]) == "number") then
                            --             NewConfig[i] = Color3.new(v[1], v[2], v[3])
                            --         elseif (typeof(v[1]) == "table") then
                            --             NewConfig[i] = v[1]
                            --         end
                            --     elseif (tostring(v):find("Enum.KeyCode.")) then
                            --         NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")]
                            --     elseif (tostring(v):find("Enum.UserInputType.")) then
                            --         NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.UserInputType.", "")]
                            --     else
                            --         NewConfig[i] = v
                            --     end
                            -- end
                            -- for i,v in next, NewConfig do 
                              --  print(i,v)
                            -- end
                            library.flags = NewConfig
                            -- for i,v in next, library.flags do 
                            --     if NewConfig[i] ~= nil then 

                            --     end
                            -- end
                            -- for i,v in next, NewConfig do 
                            --     pcall(function()
                            --         print(`set {i} to {v}`,'loopset')
                            --         library.flags[i] = v
                            --     end)
                            --     -- if library.flags[i] ~= nil then 
                            --     --     library.flags[i] = v
                            --     -- end
                            -- end

                            for i,v in next, library.flags do 
                                --print(`flag [{i}] with value [{tostring(v)}]`)
                            end;
        
                            for i,v in pairs(library.flags) do
                                for i2,v2 in pairs(library.items) do
                                    if v2.flag then 
                                        --print(i,v,i2,v2,v2.flag,'flag nil')
                                    end
                                    if (i ~= nil and i ~= "" and i ~= "Configs_Name" and i ~= "Configs" and v2.flag ~= nil) then
                                        if (v2.flag == i) then
                                            --print('set flag',loop,'loop')
                                            pcall(function() 
                                                if tostring(v):find('Enum') then 
                                                    --print(i,' is a keybind being set to ',tostring(v))
                                                end
                                                --print(v)
                                                -- if v2:Get() ~= v then 
                                                --     v2:Set(v)
                                                -- end
                                                --print('autoladed to',v2.flag,'loop')
                                                v2:Set(v)
                                            end)
                                        else
                                            --print('loop flag isnt same. v2 flag:',v2.flag,'main flag',i)
                                        end
                                    end
                                end
                            end
                            for i,v in next, library.flags do 
                                --print(`after run, flag [{i}] with value [{tostring(v)}]`)
                            end;
                        --end)
                    end
                    if themetoload then 
                        -- themetoload_
                        --print('loading theme',autoloadfile['theme'])
                        configSystem.loadtheme(autoloadfile['theme']) --(themecontent)
                    end;
                    updateevent:Fire(library.theme)
                    hasAutoloaded = true;
                end
            end
            autoLoad()
            configevent.Event:Connect(function(b)
                if b == 'setautoloadf' then 
                    print('do autoload')
                    autoLoad()
                end
                beenset = true
            end)
            --

            return configSystem
        end


        function tab:CreatePlayerlist(name,toSect)
            local list = { }
            list.name = name or ""


            --tab.SectorsRight[#tab.SectorsLeft + 1].space = 220

            list.Line = Instance.new("Frame", toSect.Items)
            list.Line.Name = "line"
            list.Line.ZIndex = 2
            list.Line.Size = UDim2.fromOffset(list.Main.Size.X.Offset + 2, 1)
            list.Line.BorderSizePixel = 0
            list.Line.Position = UDim2.fromOffset(-1, -1)
            list.Line.BackgroundColor3 = window.theme.accentcolor



            local size = textservice:GetTextSize(list.name, 13, window.theme.font, Vector2.new(2000, 2000))
            list.Label = Instance.new("TextLabel", toSect.Items)
            list.Label.AnchorPoint = Vector2.new(0,0.5)
            list.Label.Position = UDim2.fromOffset(12, -1)
            list.Label.Size = UDim2.fromOffset(math.clamp(textservice:GetTextSize(list.name, 13, window.theme.font, Vector2.new(200,300)).X + 10, 0, list.Main.Size.X.Offset), size.Y)
            list.Label.BackgroundTransparency = 1
            list.Label.BorderSizePixel = 0
            list.Label.ZIndex = 4
            list.Label.Text = list.name
            list.Label.TextColor3 = Color3.new(1,1,2552/255)
            list.Label.TextStrokeTransparency = 1
            list.Label.Font = window.theme.font
            list.Label.TextSize = 13

            list.LabelBackFrame = Instance.new("Frame", list.Label)
            list.LabelBackFrame.Name = "labelframe"
            list.LabelBackFrame.ZIndex = 3
            list.LabelBackFrame.Size = UDim2.fromOffset(list.Label.Size.X.Offset, 10)
            list.LabelBackFrame.BorderSizePixel = 0
            list.LabelBackFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            list.LabelBackFrame.Position = UDim2.fromOffset(0, 6)

            list.Items = Instance.new("ScrollingFrame", toSect.Items) 
            list.Items.Name = "items"
            list.Items.ZIndex = 2
            list.Items.ScrollBarThickness = 1
            list.Items.BackgroundTransparency = 1
            list.Items.Size = list.Main.Size - UDim2.fromOffset(10, 15)
            list.Items.ScrollingDirection = "Y"
            list.Items.BorderSizePixel = 0
            list.Items.Position = UDim2.fromOffset(5, 10)
            list.Items.CanvasSize = list.Items.Size

            list.ListLayout = Instance.new("UIListLayout", list.Items)
            list.ListLayout.FillDirection = Enum.FillDirection.Vertical
            list.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            list.ListLayout.Padding = UDim.new(0, 0)

            list.ListPadding = Instance.new("UIPadding", list.Items)
            list.ListPadding.PaddingTop = UDim.new(0, 2)
            list.ListPadding.PaddingLeft = UDim.new(0, 6)
            list.ListPadding.PaddingRight = UDim.new(0, 6)

            list.items = { }
            function list:AddPlayer(Player)
                local player = { }

                player.Main = Instance.new("Frame", list.Items)
                player.Main.Name = Player.Name
                player.Main.BorderColor3 = window.theme.outlinecolor
                player.Main.ZIndex = 3
                player.Main.Size = UDim2.fromOffset(list.Items.AbsoluteSize.X - 12, 20)
                player.Main.BackgroundColor3 = window.theme.sectorcolor
                player.Main.Position = UDim2.new(0, 0, 0, 0)

                table.insert(list.items, Player)
                list.Items.CanvasSize = UDim2.fromOffset(list.Items.AbsoluteSize.X, (#list.items * 20))
                list.Items.Size = UDim2.fromOffset(list.Items.AbsoluteSize.X, math.clamp(list.Items.CanvasSize.Y.Offset, 0, 205))
                return player
            end

            function list:RemovePlayer(Player)
                local p = list.Items:FindFirstChild(Player)
                if p then
                    for i,v in pairs(list.items) do
                        if v == Player then
                            table.remove(list.items, i)
                        end
                    end

                    p:Remove()
                    list.Items.CanvasSize = UDim2.fromOffset(list.Items.AbsoluteSize.X, (#list.items * 90))
                end
            end

            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                list:AddPlayer(v)
            end
            
            game:GetService("Players").PlayerAdded:Connect(function(v)
                list:AddPlayer(v)
            end)
            
            return list
        end


        table.insert(window.Tabs, tab)
        return tab
    end

    window:UpdateTheme()
    library.currentwindow = window
    return window
end

return library
