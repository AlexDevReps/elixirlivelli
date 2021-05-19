local display = true
local currentlevel = 0
local currentpercent = 0
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end


	ESX.PlayerData = ESX.GetPlayerData()
end)
Citizen.CreateThread(function()
while true do 
	Citizen.Wait(4000)	
		TriggerServerEvent('elixirlivelli:getlevel',source)


	
end
end)
RegisterCommand("addlvl",function()
Citizen.CreateThread(function()
	TriggerServerEvent('elixirlivelli:addonelevel',currentlevel)
end)



end)
RegisterCommand("addexp",function()
	TriggerServerEvent('elixirlivelli:getexp', GetPlayerPed(-1))
	Citizen.CreateThread(function()
		local totalexp = currentpercent + 20
		if(currentpercent ~= nil) then
			if totalexp > 100 then
			totalexp = totalexp - 100
			TriggerServerEvent('elixirlivelli:addexperience',totalexp)
			TriggerServerEvent('elixirlivelli:addonelevel',currentlevel)
			currentpercent = 0
			else
				TriggerServerEvent('elixirlivelli:addexperience',totalexp)	
				currentpercent = totalexp
			end
		end	
	end)
	end)
	
RegisterNetEvent("elixirlivelli:addexp")
AddEventHandler("elixirlivelli:addexp",function(upexp)

	local totalexp = currentpercent + upexp
	if totalexp > 100 then
	totalexp = totalexp - 100
	TriggerServerEvent('elixirlivelli:addexperience',totalexp)
	TriggerServerEvent('elixirlivelli:addonelevel',currentlevel)
	else
		TriggerServerEvent('elixirlivelli:addexperience',totalexp)	
	end

	
end)
RegisterNetEvent("elixirlivelli:sendpercent")
AddEventHandler("elixirlivelli:sendpercent",function(percent)
	
	
	SendNUIMessage({
		datlvl = "lvlpercent".. percent,
	})

end)

RegisterNetEvent("elixirlivelli:sendlevel")
AddEventHandler("elixirlivelli:sendlevel",function(level)
	currentlevel = level
	TriggerEvent("elixirlivelli:off")
	display = false
	SendNUIMessage({
	dataab = "charlevel".. level,
})

TriggerEvent("elixirlivelli:on")
display = true
end)
RegisterNetEvent("elixirlivelli:on")
AddEventHandler("elixirlivelli:on",function()
	SendNUIMessage({
	type = "ui",
	display = true

})
end)
RegisterNetEvent("elixirlivelli:off")
AddEventHandler("elixirlivelli:off",function()
	SendNUIMessage({
	type = "ui",
	display = false
	
})
end)