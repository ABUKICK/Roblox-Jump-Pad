local jumpPad = script.Parent

-- Cooldown-Tabelle
local cooldown = {}

-- Stärke des Jumps (viel höher!)
local JUMP_KRAFT = 200

-- Cooldown-Zeit in Sekunden
local COOLDOWN_ZEIT = 2

-- Funktion, die die Rauchwolke erzeugt
local function rauchwolkeErzeugen(position)
	local rauchPart = Instance.new("Part")
	rauchPart.Name = "RauchEffekt"
	rauchPart.Size = Vector3.new(1, 1, 1)
	rauchPart.Position = position
	rauchPart.Anchored = true
	rauchPart.CanCollide = false
	rauchPart.Transparency = 1
	rauchPart.Parent = workspace
	
	local partikel = Instance.new("ParticleEmitter")
	partikel.Texture = "rbxasset://textures/particles/smoke_main.dds"
	partikel.Rate = 200
	partikel.Lifetime = NumberRange.new(0.8, 1.5)
	partikel.Speed = NumberRange.new(2, 5)
	partikel.SpreadAngle = Vector2.new(180, 180)
	partikel.Color = ColorSequence.new(Color3.fromRGB(200, 200, 200))
	partikel.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 2),
		NumberSequenceKeypoint.new(1, 5)
	})
	partikel.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.3),
		NumberSequenceKeypoint.new(1, 1)
	})
	partikel.Parent = rauchPart
	
	partikel:Emit(50)
	
	task.delay(2, function()
		if rauchPart then
			rauchPart:Destroy()
		end
	end)
end

-- Wenn jemand das Jumppad berührt
jumpPad.Touched:Connect(function(beruehrung)
	local charakter = beruehrung.Parent
	local humanoid = charakter:FindFirstChildOfClass("Humanoid")
	local rootPart = charakter:FindFirstChild("HumanoidRootPart")
	
	if not humanoid or humanoid.Health <= 0 or not rootPart then return end
	
	local spielerName = charakter.Name
	
	-- Cooldown prüfen
	if cooldown[spielerName] then return end
	cooldown[spielerName] = true
	
	-- Rauchwolke erzeugen
	rauchwolkeErzeugen(rootPart.Position - Vector3.new(0, 2, 0))
	
	-- Spieler hochschleudern mit BodyVelocity (ältere, aber zuverlässige Methode)
	local bodyVel = Instance.new("BodyVelocity")
	bodyVel.MaxForce = Vector3.new(0, 50000, 0)
	bodyVel.Velocity = Vector3.new(0, JUMP_KRAFT, 0)
	bodyVel.Parent = rootPart
	
	-- Nach 0.3 Sekunden die Kraft wieder entfernen
	task.delay(0.3, function()
		if bodyVel then
			bodyVel:Destroy()
		end
	end)
	
	-- Cooldown abwarten
	task.wait(COOLDOWN_ZEIT)
	cooldown[spielerName] = nil
end)
