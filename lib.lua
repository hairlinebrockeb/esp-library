--Settings--
getgenv().ESP = getgenv().ESP or {
	Enabled = false,
	Boxes = true,
	BoxShift = CFrame.new(0,-1.5,0),
	BoxSize = Vector3.new(4,6,0),
	Color = Color3.fromRGB(255, 170, 0),
	FaceCamera = false,
	Names = true,
	TeamColor = true,
	Thickness = 2,
	AttachShift = 1,
	TeamMates = true,
	Players = true,
	
	Objects = setmetatable({}, {__mode="kv"}),
	Overrides = {};

	PathEsps = {};
}

--Declarations--
local cam = workspace.CurrentCamera
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()

local V3new = Vector3.new
local WorldToViewportPoint = cam.WorldToViewportPoint

--Functions--
local function Draw(obj, props)
	local new = Drawing.new(obj)
	
	props = props or {}
	for i,v in pairs(props) do
		new[i] = v
	end
	return new
end

function ESP:GetTeam(p)
	local ov = self.Overrides.GetTeam
	if ov then
		return ov(p)
	end
	
	return p and p.Team
end

function ESP:IsTeamMate(p)
	local ov = self.Overrides.IsTeamMate
	if ov then
		return ov(p)
	end
	
	return self:GetTeam(p) == self:GetTeam(plr)
end

function ESP:GetColor(obj)
	local ov = self.Overrides.GetColor
	if ov then
		return ov(obj)
	end
	local p = self:GetPlrFromChar(obj)
	return p and self.TeamColor and p.Team and p.Team.TeamColor.Color or self.Color
end

function ESP:GetPlrFromChar(char)
	local ov = self.Overrides.GetPlrFromChar
	if ov then
		return ov(char)
	end
	
	return plrs:GetPlayerFromCharacter(char)
end

function ESP:Toggle(bool)
	self.Enabled = bool
	if not bool then
		for i,v in pairs(self.Objects) do
			if v.Type == "Box" then --fov circle etc
				if v.Temporary then
					v:Remove()
				else
					for i,v in pairs(v.Components) do
						v.Visible = false
					end
				end
			end
		end
	end
end

function ESP:GetBox(obj)
	return self.Objects[obj]
end

function ESP:AddObjectListener(parent, options)
	local function NewListener(c)
		if type(options.Type) == "string" and c:IsA(options.Type) or options.Type == nil then
			if type(options.Name) == "string" and c.Name == options.Name or options.Name == nil then
				if not options.Validator or options.Validator(c) then
					
                    local box = ESP:Add(c, {
						PrimaryPart = type(options.PrimaryPart) == "string" and c:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(c),
						Color = type(options.Color) == "function" and options.Color(c) or options.Color,
						ColorDynamic = options.ColorDynamic,
						Name = type(options.CustomName) == "function" and options.CustomName or options.CustomName or options.SelfName and c.Name,
						IsEnabled = options.IsEnabled,
						RenderInNil = options.RenderInNil,
						flag = options.flag;
						tag = options.flag;
                        entity = options.entity;
						distance = options.distance; -- type(options.Distance) == "function" and options.Distance or
						maxdistance = options.maxdistance
					})
					--TODO: add a better way of passing options
					if options.OnAdded then
						coroutine.wrap(options.OnAdded)(box)
					end
				end
			end
		end
	end

	if options.Recursive then
		parent.DescendantAdded:Connect(NewListener)
		for i,v in pairs(parent:GetDescendants()) do
			coroutine.wrap(NewListener)(v)
		end
	else
		parent.ChildAdded:Connect(NewListener)
		for i,v in pairs(parent:GetChildren()) do
			coroutine.wrap(NewListener)(v)
		end
	end
end

function ESP:CreateOnPath(path, options)
	ESP.PathEsps[path:GetFullName()] = {};
	EspsAssignedToPath = ESP.PathEsps[path:GetFullName()]
	EspsAssignedToPath.removeobj = function()

	end;
	EspsAssignedToPath.ObjectRemoved = function()

	end	
	local EspComponents = {};
	local MaximumEsps = options.max;
	if not MaximumEsps then return warn('cant do esp without a max') end

	EspsAssignedToPath.EspFunction = function(child)
		table.insert(EspsAssignedToPath,child)
		--print(child.Name)
		pcall(function()
            if child.Position then 
                ispart = true
            end
        end) -- or child:IsA('Part') or child:IsA('MeshPart') or child:IsA('UnionPart')
		ESP:Add(child,{
			PrimaryPart = type(options.PrimaryPart) == "string" and child:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(child) or ispart and child ,
			Color = type(options.Color) == "function" and options.Color or options.Color,
			ColorDynamic = options.ColorDynamic,
			Name = type(options.CustomName) == "function" and options.CustomName or options.CustomName or options.SelfName and child.Name,
			IsEnabled = options.IsEnabled,
			RenderInNil = options.RenderInNil,
			flag = options.flag;
			tag = options.flag;
			entity = options.entity;
			renderclosest = options.renderclosest;
			pathorigin = EspsAssignedToPath;
			distance = options.distance;-- type(options.Distance) == "function" and options.Distance or
			_end = function(Object)
				for __, espobjects in next, EspsAssignedToPath do 
					if espobjects == Object then 
					--	print('removed table value',Object.Name)
						table.remove(EspsAssignedToPath,i)
						--break
					end;
				end;
			end;
		})
	end
	local EspFunction = EspsAssignedToPath.EspFunction
	EspsAssignedToPath.LookForObjects = function(firstOnly, old)
		for i,v in next, path:GetChildren() do 
			--if i == MaximumEsps + 1 and firstOnly == false then break end -- Maximum Allowed
			if #EspsAssignedToPath >= MaximumEsps then print('max allowed') break end
			local shouldstopnow = false;
			local obj = nil;
			local canUse = true ;
			for __, espobjects in next, EspsAssignedToPath do 
				if espobjects == v then 
				--	print('already used ',v.Name)
					canUse = false;
				end;
			end;
			pcall(function()
				if v.Position then 
					obj = v
				end
			end) 
			if obj == nil then 
				--print('is nil')
				obj = type(options.PrimaryPart) == "string" and v:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(v)
			end
			local DistanceFromObject
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.PrimaryPart then 
				DistanceFromObject = (obj.CFrame.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
			else
				DistanceFromObject = (obj.CFrame.Position - cam.CFrame.p).Magnitude
			end	
			 --= (obj.CFrame.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude --cam.CFrame.p).Magnitude 
			if DistanceFromObject <= options.distance() and v ~= old and canUse == true then 
				if firstOnly then 
					---print('ASSIGNING',obj.Name,DistanceFromObject)
				end	
				EspsAssignedToPath.EspFunction(obj)
				shouldstopnow = true;
			end	
			if firstOnly and shouldstopnow then task.wait() print('replaced removed') break end
		end
	end	
	EspsAssignedToPath.LookForObjects(false)
	path.ChildAdded:Connect(function(child)
		if #EspsAssignedToPath < MaximumEsps then 
			local obj = nil
			pcall(function()
				if v.Position then 
					obj = v
				end
			end) 
			if obj == nil then 
				obj = child.PrimaryPart ~= nil and child.PrimaryPart  or type(options.PrimaryPart) == "string" and child:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(child)
			end
			local DistanceFromObject = (obj.CFrame.Position - cam.CFrame.p).Magnitude 
			if DistanceFromObject <= options.distance() then 
				EspFunction(child)
			end	
		end
	end)
	path.ChildRemoved:Connect(function(child)
		for i,v in next, EspsAssignedToPath do 
			if v == child then 
				table.remove(EspsAssignedToPath,i)
				--break
			end;
		end;
		if #EspsAssignedToPath < MaximumEsps then 
			for i,v in next, path:GetChildren() do 
				local canBreak = false;
				for _, espChild in next, EspsAssignedToPath do 
					if espChild ~= v then 
						local obj = nil
						pcall(function()
							if v.Position then 
								obj = v
							end
						end) 
						if obj == nil then 
							obj = type(options.PrimaryPart) == "string" and v:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(v)
						end
						local DistanceFromObject = (obj.CFrame.Position - cam.CFrame.p).Magnitude 
						if DistanceFromObject <= options.distance() then 
							canBreak = true;
						end	
						break
					end
				end;
				if canBreak == true then 
					EspFunction(v)
					break
				end
			end;
		end;
	end) -- if espsassigned is 1 more than expected remove one random
	task.spawn(function()
		while task.wait() do 
			if #EspsAssignedToPath == 0 then 
				repeat 
					task.wait(5)
					EspsAssignedToPath.LookForObjects(false)
				until #EspsAssignedToPath ~= 0 
			end
		end
	end)

	return EspsAssignedToPath
end


local boxBase = {}
boxBase.__index = boxBase

function boxBase:Remove()
	ESP.Objects[self.Object] = nil
	if self.pathorigin and self.pathorigin.LookForObjects ~= nil then 
		--print('can get newe object')

		self.pathorigin.LookForObjects(true,self.PrimaryPart)
	end	
	for i,v in pairs(self.Components) do
		v.Visible = false
		v:Remove()
		self.Components[i] = nil
	end
	if self._end then 
		self._end(self.PrimaryPart)
		for i,v in next, self.pathorigin do 
			if v == self.PrimaryPart then 
				table.remove(self.pathorigin,i)
			end	
		end	
	end	
end

function boxBase:Update()
	if not self.PrimaryPart then
		--warn("not supposed to print", self.Object)
		return self:Remove()
	end

	local color
	if ESP.Highlighted == self.Object then
	   color = ESP.HighlightColor
	else
		color = type(self.Color) == 'function' and self.Color or self.Color or self.ColorDynamic and self:ColorDynamic() or ESP:GetColor(self.Object) or ESP.Color
	end

	local allow = true
	if ESP.Overrides.UpdateAllow and not ESP.Overrides.UpdateAllow(self) then
		allow = false
	end
	if self.Player and not ESP.TeamMates and ESP:IsTeamMate(self.Player) then
		allow = false
	end
	if self.Player and not ESP.Players then
		allow = false
	end
	if self.IsEnabled and not self.active and (type(self.IsEnabled) == "string" and not ESP[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
		allow = false
	end
	local notactive = false;
	if self.active and type(self.active) == 'function' then 
		--allow = self.active()
		if self.active() == false then allow = false notactive = true end;
	end
	if self.removeondisable and notactive == true then 
		self:Remove()
		print('disabled so remove;')
		return
	end
	if not workspace:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
		allow = false
	end
	--local dist = (self.PrimaryPart.CFrame.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude--(self.PrimaryPart.CFrame.Position - cam.CFrame.p).Magnitude     -- math.floor((cam.CFrame.p - cf.p).magnitude)
	local dist
	local objtake = self.PrimaryPart
	-- pcall(function()
	-- 	if objtake:FindFirstChildWhichIsA('Part') then 

	-- 	end
	-- end)
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.PrimaryPart then 
		dist = (self.PrimaryPart.CFrame.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
	else
		dist = (self.PrimaryPart.CFrame.Position - cam.CFrame.p).Magnitude
	end	
	if self.distance then  -- and self.distance < dist 
		--allow = false -- if self.
		local distget = self.distance()
		--warn(distget)
		if dist >= distget then -- distget  dist then --if dist < distget then 
			allow = false;
			if self.renderclosest and (dist-distget) > 20 then 
			--	print(dist,distget)
				--self.renderclosest
				--if self.newlyreplcat
			--	print(self.PrimaryPart.Name..' remvoed cuz distance')
				self:Remove()
			end
		end
	end
	if self.maxdistance then 
		local amxDist = self.maxdistance()
		if dist >= amxDist then 
			allow = false;
		--	print('dist bigger than max ')
		end
	end

	if not allow then
		for i,v in pairs(self.Components) do
			v.Visible = false
		end
		return
	end

	if ESP.Highlighted == self.Object then
		color = ESP.HighlightColor
	end

	--calculations--
	local cf = self.PrimaryPart.CFrame
	if ESP.FaceCamera then
		cf = CFrame.new(cf.p, cam.CFrame.p)
	end
	local size = self.Size
	local locs = {
		TopLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,size.Y/2,0),
		TopRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,size.Y/2,0),
		BottomLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,-size.Y/2,0),
		BottomRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,-size.Y/2,0),
		TagPos = cf * ESP.BoxShift * CFrame.new(0,size.Y/2,0),
		Torso = cf * ESP.BoxShift
	}
	local offset = self.offset or Vector2.new(0,0)
	if ESP.Boxes and self.Components.Quad   then
		local TopLeft, Vis1 = WorldToViewportPoint(cam, locs.TopLeft.p)
		local TopRight, Vis2 = WorldToViewportPoint(cam, locs.TopRight.p)
		local BottomLeft, Vis3 = WorldToViewportPoint(cam, locs.BottomLeft.p)
		local BottomRight, Vis4 = WorldToViewportPoint(cam, locs.BottomRight.p)

		if self.Components.Quad then
			if Vis1 or Vis2 or Vis3 or Vis4 then
				self.Components.Quad.Visible = true
				self.Components.Quad.PointA = Vector2.new(TopRight.X, TopRight.Y)
				self.Components.Quad.PointB = Vector2.new(TopLeft.X, TopLeft.Y)
				self.Components.Quad.PointC = Vector2.new(BottomLeft.X, BottomLeft.Y)
				self.Components.Quad.PointD = Vector2.new(BottomRight.X, BottomRight.Y)
				self.Components.Quad.Color = color
			else
				self.Components.Quad.Visible = false
			end
		end
	else
		if self.Components.Quad  then 
			self.Components.Quad.Visible = false
		end
	end

	if ESP.Names then
		local TagPos, Vis5 = WorldToViewportPoint(cam, locs.TagPos.p)
		
		if Vis5 then
			self.Components.Name.Visible = true
			self.Components.Name.Position = Vector2.new(TagPos.X, TagPos.Y) + offset
            local supposedName = self.Name
			if type(supposedName) == 'function' then supposedName = supposedName() end
            if self.entity and self.entity == true then 
                if self.Object:FindFirstChild('Humanoid') then 
                    local maxhealth = math.floor(self.Object:FindFirstChild('Humanoid').MaxHealth)
                    local health = math.floor(self.Object:FindFirstChild('Humanoid').Health)
                    local halfofname = math.floor(string.len(self.Name)/2)
                    supposedName = `{string.rep(' ',halfofname)}[{maxhealth}/{health}]\n{self.Name}`
                end
            end
			self.Components.Name.Text = supposedName --self.Name
			self.Components.Name.Color = color
			
			self.Components.Distance.Visible = true
			self.Components.Distance.Position = Vector2.new(TagPos.X, TagPos.Y + 14) + offset --Vector2.new(TagPos.X, TagPos.Y + 14)
            local disttext = math.floor((cam.CFrame.p - cf.p).magnitude) .."m away"
            local subsitute = disttext
            if supposedName ~= self.Name then 
                disttext = `\n{subsitute}`
            end
			self.Components.Distance.Text = disttext
			self.Components.Distance.Color = color
		else
			self.Components.Name.Visible = false
			self.Components.Distance.Visible = false
		end
	else
		self.Components.Name.Visible = false
		self.Components.Distance.Visible = false
	end
	
	if ESP.Tracers and self.Components.Tracer then
		local TorsoPos, Vis6 = WorldToViewportPoint(cam, locs.Torso.p)

		if Vis6 then
			self.Components.Tracer.Visible = true
			self.Components.Tracer.From = Vector2.new(TorsoPos.X, TorsoPos.Y)
			self.Components.Tracer.To = Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/ESP.AttachShift)
			self.Components.Tracer.Color = color
		else
			self.Components.Tracer.Visible = false
		end
	else
		if self.Components.Tracer then 
			self.Components.Tracer.Visible = false
		end
	end
end

function ESP:Add(obj, options)
	if not obj.Parent and not options.RenderInNil then
		return warn(obj, "has no parent")
	end
    local ispart = false
    pcall(function()
        if ispart.Position then 
            ispart = true
        end
    end)

	local box = setmetatable({
		Name = type(options.Name) == 'string' and options.Name or type(options.Name) == 'function' and options.Name or obj.Name,
		Type = "Box",
		Color = type(options.Color) == 'function' and options.Color or options.Color --[[or self:GetColor(obj)]],
		Size = options.Size or self.BoxSize,
		Object = obj,
		Player = options.Player or plrs:GetPlayerFromCharacter(obj),
		PrimaryPart = options.PrimaryPart or obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj:IsA("BasePart") and obj or ispart and obj,
		Components = {},
		IsEnabled = options.IsEnabled,
		Temporary = options.Temporary,
		ColorDynamic = options.ColorDynamic,
		RenderInNil = options.RenderInNil,
		offset = options.offset,
		tag = options.tag;
        flag = options.flag;
        entity = options.entity;
		distance = options.distance;
		renderclosest = options.renderclosest;
		pathorigin = options.pathorigin;
		_end = options._end;
		maxdistance = options.maxdistance;
		active = options.active;
		removeondisable = options.removeondisable
	}, boxBase)

	if self:GetBox(obj) then
		self:GetBox(obj):Remove()
	end

	if not options.NoBox then 
		box.Components["Quad"] = Draw("Quad", {
			Thickness = self.Thickness,
			Color = color,
			Transparency = 1,
			Filled = false,
			Visible = self.Enabled and self.Boxes
		})
	end
	box.Components["Name"] = Draw("Text", {
		Text = type(box.Name) == 'function' and box.Name() or box.Name,
		Color = type(box.Color) == 'function' and box.Color() or box.Color, -- box.Color -- table support (r,g,b)
		Center = true,
		Outline = true,
		Size = 19,
		Visible = self.Enabled and self.Names
	})
	box.Components["Distance"] = Draw("Text", {
		Color = box.Color,
		Center = true,
		Outline = true,
		Size = 19,
		Visible = self.Enabled and self.Names
	})
	
	if not options.NoTracer then 
		box.Components["Tracer"] = Draw("Line", {
			Thickness = ESP.Thickness,
			Color = type(box.Color) == 'function' and box.Color() or box.Color, --
			Transparency = 1,
			Visible = self.Enabled and self.Tracers
		})
	end
	self.Objects[obj] = box
	
	obj.AncestryChanged:Connect(function(_, parent)
		if parent == nil and ESP.AutoRemove ~= false then
			box:Remove()
		end
	end)
	obj:GetPropertyChangedSignal("Parent"):Connect(function()
		if obj.Parent == nil and ESP.AutoRemove ~= false then
			box:Remove()
		end
	end)

	local hum = obj:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.Died:Connect(function()
			if ESP.AutoRemove ~= false then
				box:Remove()
			end
		end)
	end

	return box
end

local function CharAdded(char)
	local p = plrs:GetPlayerFromCharacter(char)
	if not char:FindFirstChild("HumanoidRootPart") then
		local ev
		ev = char.ChildAdded:Connect(function(c)
			if c.Name == "HumanoidRootPart" then
				ev:Disconnect()
				ESP:Add(char, {
					Name = p.Name,
					Player = p,
					PrimaryPart = c
				})
			end
		end)
	else
		ESP:Add(char, {
			Name = p.Name,
			Player = p,
			PrimaryPart = char.HumanoidRootPart
		})
	end
end
local function PlayerAdded(p)
	p.CharacterAdded:Connect(CharAdded)
	if p.Character then
		coroutine.wrap(CharAdded)(p.Character)
	end
end
plrs.PlayerAdded:Connect(PlayerAdded)
for i,v in pairs(plrs:GetPlayers()) do
	if v ~= plr then
		PlayerAdded(v)
	end
end



game:GetService("RunService").RenderStepped:Connect(function()
	cam = workspace.CurrentCamera
	if ESP.Enabled == true then 
		for i,v in next, ESP.Objects do 
			if v.Update then
				v.Update(v)
			end	
		end	
	end	
	-- for i,v in (ESP.Enabled and pairs or ipairs)(ESP.Objects) do
	-- 	if v.Update then
    --         v.Update(v)
	-- 		--local s,e = pcall(v.Update, v)
	-- 		--if not s then warn("[EU]", e, v.Object:GetFullName()) end
	-- 	end
	-- end
end)
return ESP
