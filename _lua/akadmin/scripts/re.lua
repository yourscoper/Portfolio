-- Respawn script coded by yourscoper and revamped ak's since he can't code and is a skid.

local Players   = game:GetService("Players");
local Player    = Players.LocalPlayer

Player.Character:BreakJoints();
local oldPos = Player.Character:WaitForChild("HumanoidRootPart").CFrame

Player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = oldPos
