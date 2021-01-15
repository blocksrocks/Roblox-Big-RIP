local ATTEMPT_INTERVAL = 5

local Repeat = _G.require("Repeat")

local Players = game:GetService("Players")

local Robloxian = {}

function Robloxian.fromUserId(id)
	local info = Repeat(ATTEMPT_INTERVAL, Players.GetCharacterAppearanceAsync, Players, id)

	local type = info.IsR15.Value and "R15" or "R6"

	local character = script[type]:Clone()

	local mesh = info:FindFirstChild("Mesh")
	if mesh then
		character.Head.Mesh:Destroy()
		mesh.Parent = character.Head
	end

	local face = info:FindFirstChild("face")
	if face then
		character.Head.face:Destroy()
		face.Parent = character.Head
	end

	for _, object in next, info:GetChildren() do
		if object:IsA("Folder") then
			if object.Name == type then
				if type == "R15" then
					for _, part in next, object:GetChildren() do
						local found = character:FindFirstChild(part.Name)
						found:Destroy()
						part.Parent = character
					end
				elseif type == "R6" then
					object:GetChildren()[1].Parent = character
				end
			end
			object:Destroy()
		end
	end

	for _, object in next, info:GetChildren() do
		if object:IsA("NumberValue") and info.IsR15.Value then
			object.Parent = character.Humanoid
		elseif not object:IsA("NumberValue") and not object:IsA("BoolValue") then
			object.Parent = character
		end
	end

	info:Destroy()

	return character
end

--lmfao i'm dumb asf
function Robloxian.fromUserId(id)
	return Repeat(ATTEMPT_INTERVAL, Players.CreateHumanoidModelFromUserId, Players, id)
end

return Robloxian