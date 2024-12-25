local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local LocalPlayer = Players.LocalPlayer
local Unloaded = false

if _G["Unload"] then
   _G.Unload()
end

function _G.Unload()
   Rayfield:Destroy()
   Unloaded = true
end

local Window = Rayfield:CreateWindow({
   Name = "Ba5t Hub",
   Icon = 93934268503586,
   LoadingTitle = "Loading Ba5t Hub",
   LoadingSubtitle = "by Ba5t",
   Theme = "Default",

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Ba5tHubConfig",
      FileName = "Ba5t Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "" or "noinvitelink",
      RememberJoins = true
   },
})

if game.GameId == 3808081382 then
   Rayfield:Notify({
      Title = "Game Detected!",
      Content = "The Strongest Battlegrounds",
      Duration = 5,
      Image = 0,
   })

   local ScriptVariables = {
      AntiDeathCounter = {
         Activated = false,
         Teleporting = false,
         OriginalPos = Vector3.new(0, 0, 0),
         TeleportPos = Vector3.new(0, -500, 0)
      }
   }

   local PlayerTab = Window:CreateTab("Player", 87064167176292)
   local AntisTab = Window:CreateTab("Antis", 84499734983619)
   local ESPTab = Window:CreateTab("ESP", 88318316784542)

   local AntiStun = AntisTab:CreateToggle({
      Name = "Anti Stun",
      CurrentValue = false,
      Flag = "AntiStun",
      Callback = function()

      end,
   })

   local AntiRagdoll = AntisTab:CreateToggle({
      Name = "Anti Ragdoll",
      CurrentValue = false,
      Flag = "AntiRagdoll",
      Callback = function()

      end,
   })

   local AntiVelocity = AntisTab:CreateToggle({
      Name = "Anti Velocity",
      CurrentValue = false,
      Flag = "AntiVelocity",
      Callback = function()

      end,
   })

   local AntiDeathCounter = AntisTab:CreateToggle({
      Name = "Anti Death Counter",
      CurrentValue = false,
      Flag = "AntiDeathCounter",
      Callback = function()

      end,
   })

   local InvisBlock = PlayerTab:CreateToggle({
      Name = "Invisible Block",
      CurrentValue = false,
      Flag = "InvisBlock",
      Callback = function()

      end,
   })

   local CFrameSpeed = PlayerTab:CreateToggle({
      Name = "CFrame Speed",
      CurrentValue = false,
      Flag = "CFrameSpeed",
      Callback = function()

      end,
   })

   local CFrameSpeedAmount = PlayerTab:CreateSlider({
      Name = "CFrame Speed Amount",
      Range = {0, 100},
      Increment = 1,
      Suffix = "Speed",
      CurrentValue = 0,
      Flag = "CFrameSpeedAmount",
      Callback = function()

      end,
   })

   local ESPEnabled = ESPTab:CreateToggle({
      Name = "ESP",
      CurrentValue = false,
      Flag = "ESPEnabled",
      Callback = function()

      end,
   })

   local ESPColor = ESPTab:CreateColorPicker({
      Name = "ESP Color",
      Color = Color3.fromRGB(255, 255, 255),
      Flag = "ESPColor",
      Callback = function()
          
      end
   })

   local ESPTransparency = ESPTab:CreateSlider({
      Name = "ESP Transparency",
      Range = {0, 1},
      Increment = 0.05,
      Suffix = "Transparency",
      CurrentValue = 0.5,
      Flag = "ESPTransparency",
      Callback = function()

      end,
   })

   pcall(function()
      workspace.FallenPartsDestroyHeight = -1000
      
      local LargePart = Instance.new("Part")
      LargePart.Anchored = true
      LargePart.Position = ScriptVariables.AntiDeathCounter.TeleportPos
      LargePart.Size = Vector3.new(2048, 1, 2048)
      LargePart.Transparency = 0.5
      LargePart.Parent = workspace

      ReplicatedStorage:WaitForChild("Replication").OnClientEvent:Connect(function(...)
         if Unloaded == true then
            return
         end

         if (...)["Root"] and (...)["Effect"] and (...)["Effect"] == "Death Punch" then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
               local AntiDeathCounter = ScriptVariables.AntiDeathCounter
               if AntiDeathCounter.Activated == false then
                  task.wait(1)
                  AntiDeathCounter.OriginalPos = LocalPlayer.Character.HumanoidRootPart.Position
                  AntiDeathCounter.Activated = true
               end
            end
         end
      end)
   end)

   RunService.Heartbeat:Connect(function()
      if Unloaded == true then
         return
      end

      pcall(function()
         if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				if Rayfield.Flags.AntiStun.CurrentValue == true then
               task.spawn(function()
                  for _,Child in pairs(LocalPlayer.Character:GetChildren()) do
                     if Child.Name == "ComboStun" or Child.Name == "NoJump" or Child.Name == "Slowed" or Child.Name == "Freeze" then
                        Child:Destroy()
                     end
                  end
               end)
            end
            if Rayfield.Flags.AntiRagdoll.CurrentValue == true then
               task.spawn(function()
                  for _,Child in pairs(LocalPlayer.Character:GetChildren()) do
                     if Child.Name == "Ragdoll" then
                        Child:Destroy()
                     end
                  end
               end)
            end
            if Rayfield.Flags.AntiVelocity.CurrentValue == true then
               task.spawn(function()
                  for _,Child in pairs(LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                     if Child:IsA("BodyVelocity") then
                        if Child.Name ~= "moveme" and Child.Name ~= "dodgevelocity" and Child.Name ~= "FlyForce" then
                           Child:Destroy()
                        end
                     end
                  end
               end)
            end
            if Rayfield.Flags.InvisBlock.CurrentValue == true then
               task.spawn(function()
                  if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                     if LocalPlayer.Character:GetAttribute("Blocking") and LocalPlayer.Character:GetAttribute("Blocking") == true then
                        for _,Anim in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                           if Anim.Animation.AnimationId == "rbxassetid://10470389827" then
                              Anim:Stop()
                           end
                        end
                  
                        if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("CustomBlock") then
                           local CustomBlock = LocalPlayer.Character.HumanoidRootPart.EsperShield:Clone()
                           CustomBlock.Name = "CustomBlock"
                           CustomBlock.Parent = LocalPlayer.Character.HumanoidRootPart
                           
                           for _,v in pairs(CustomBlock:GetChildren()) do
                              if v:IsA("ParticleEmitter") then
                                 v.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                                 v.Enabled = true
                              end
                           end
                        else
                           local CustomBlock = LocalPlayer.Character.HumanoidRootPart.CustomBlock
                           
                           for _,v in pairs(CustomBlock:GetChildren()) do
                              if v:IsA("ParticleEmitter") then
                                 v.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                                 v.Enabled = true
                              end
                           end
                        end
                     else
                        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("CustomBlock") then
                           local CustomBlock = LocalPlayer.Character.HumanoidRootPart.CustomBlock
                           
                           for _,v in pairs(CustomBlock:GetChildren()) do
                              if v:IsA("ParticleEmitter") then
                                 v.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                                 v.Enabled = false
                              end
                           end
                        end
                     end
                  end
               end)
            elseif Rayfield.Flags.InvisBlock.CurrentValue == false then
               task.spawn(function()
                  if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                     if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("CustomBlock") then
                        local CustomBlock = LocalPlayer.Character.HumanoidRootPart.CustomBlock
                        
                        for _,v in pairs(CustomBlock:GetChildren()) do
                           if v:IsA("ParticleEmitter") then
                              v.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                              v.Enabled = false
                           end
                        end
                     end
                  end
               end)
            end
            if Rayfield.Flags.CFrameSpeed.CurrentValue == true then
               task.spawn(function()
                  LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection * Rayfield.Flags.CFrameSpeedAmount.CurrentValue/100
               end)
            end
            if Rayfield.Flags.AntiDeathCounter.CurrentValue == true then
               task.spawn(function()
                  if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                     local AntiDeathCounter = ScriptVariables.AntiDeathCounter
                     if AntiDeathCounter.Activated == true then
                        task.spawn(function()
                           local TeleportCFrame = CFrame.new(AntiDeathCounter.TeleportPos.X, AntiDeathCounter.TeleportPos.Y + 2, AntiDeathCounter.TeleportPos.Z)
                           LocalPlayer.Character.HumanoidRootPart.CFrame = TeleportCFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
                           AntiDeathCounter.Teleporting = true

                           task.delay(2.5, function()
                              AntiDeathCounter.Teleporting = false

                              local OriginalCFrame = CFrame.new(AntiDeathCounter.OriginalPos.X, AntiDeathCounter.OriginalPos.Y, AntiDeathCounter.OriginalPos.Z)
                              LocalPlayer.Character.HumanoidRootPart.CFrame = OriginalCFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
                              AntiDeathCounter.Activated = false
                           end)
                        end)
                     end

                     if AntiDeathCounter.Teleporting == true then
                        local TeleportCFrame = CFrame.new(AntiDeathCounter.TeleportPos.X + math.random(-100, 100), AntiDeathCounter.TeleportPos.Y, AntiDeathCounter.TeleportPos.Z + math.random(-100, 100))
                        LocalPlayer.Character.HumanoidRootPart.CFrame = TeleportCFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
                     end
                  end
               end)
            end
            if Rayfield.Flags.ESPEnabled.CurrentValue == true then
               task.spawn(function()
                  for _,Plr in pairs(Players:GetPlayers()) do
                     if Plr ~= LocalPlayer then
                        if Plr.Character then
                           if not Plr.Character:FindFirstChild("ESP") then
                              local ESP = Instance.new("Highlight")
                              ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                              --ESP.FillColor = Rayfield.Flags.ESPColor.CurrentValue
                              print(game:GetService("HttpService"):JSONEncode(Rayfield.Flags.ESPColor))
                              ESP.FillTransparency = Rayfield.Flags.ESPTransparency.CurrentValue
                              ESP.OutlineTransparency = 1
                              ESP.Parent = Plr.Character
                           else
                              local ESP = Plr.Character.ESP
                              ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                              ESP.FillColor = Rayfield.Flags.ESPColor.CurrentValue
                              ESP.FillTransparency = Rayfield.Flags.ESPTransparency.CurrentValue
                              ESP.OutlineTransparency = 1
                           end
                        end
                     end
                  end
               end)
            elseif Rayfield.Flags.ESPEnabled.CurrentValue == false then
               task.spawn(function()
                  for _,Plr in pairs(Players:GetPlayers()) do
                     if Plr ~= LocalPlayer then
                        if Plr.Character then
                           if Plr.Character:FindFirstChild("ESP") then
                              Plr.Characted.ESP:Destroy()
                           end
                        end
                     end
                  end
               end)
            end
			end
      end)
   end)
else
   Rayfield:Notify({
      Title = "Game Not Supported!",
      Content = "Closing Script",
      Duration = 2.5,
      Image = 0,
   })

   task.delay(2.5, function()
      Rayfield:Destroy()
   end)
end

Rayfield:LoadConfiguration()
