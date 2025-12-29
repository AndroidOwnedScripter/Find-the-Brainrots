-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Find The Brainrots",
	LoadingTitle = "Find The Brainrots",
	LoadingSubtitle = "Auto Finder",
	ConfigurationSaving = {
		Enabled = false
	}
})

local Tab = Window:CreateTab("Find the brainrots", 4483362458)

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local folder = workspace:WaitForChild("Brainrots") -- Dossier cible

local AutoFind = false

-- Toggle Auto Find
Tab:CreateToggle({
	Name = "Afk (wait for brainrots spawn)",
	CurrentValue = false,
	Flag = "AutoFindToggle",
	Callback = function(Value)
		AutoFind = Value

		task.spawn(function()
			while AutoFind do
				for _, obj in ipairs(folder:GetChildren()) do
					if not AutoFind then break end

					-- Touche tout objet qui a CFrame (BasePart ou autres)
					if obj:IsA("BasePart") or obj:FindFirstChild("CFrame") or obj:FindFirstChild("Position") then
						-- Touche l'objet
						if pcall(function() firetouchinterest(hrp, obj, 0) firetouchinterest(hrp, obj, 1) end) then
							-- OK
						end
					end
				end
				task.wait() -- une frame
			end
		end)
	end
})

-- Petit texte
Tab:CreateParagraph({
	Title = "Discord",
	Content = "find op scripts"
})

-- Bouton Join Discord
Tab:CreateButton({
	Name = "Join The Discord",
	Callback = function()
		setclipboard("https://discord.gg/YTAUARbbuj")

		Rayfield:Notify({
			Title = "Discord",
			Content = "Link copied to clipboard",
			Duration = 3
		})
	end
})
