local GetChecker = game.ReplicatedStorage:FindFirstChild(game.Players.LocalPlayer.Name)
if GetChecker then
    if GetChecker.Value == 0 then
        GetChecker.Value = 1
    elseif GetChecker.Value == 1 then
        game.Players.LocalPlayer:Kick("Executou mais de uma vez")
    end
else
    local ExecuteChecker = Instance.new("IntValue", game.ReplicatedStorage)
    ExecuteChecker.Name = game.Players.LocalPlayer.Name
    ExecuteChecker.Value = 0
end
