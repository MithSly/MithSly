--[[ DUMPED USING FIVEX ]]--
-- StarBlazt Chat

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		PlayerData = ESX.GetPlayerData()
	end
end)


RegisterCommand('911', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local caller = GetPlayerServerId(PlayerId())
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local msg = rawCommand:sub(4)
    TriggerServerEvent('chat:server:911source', source, caller, msg)
    TriggerServerEvent('911', source, caller, msg, playerCoords)
end, false)

RegisterCommand('311', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local caller = GetPlayerServerId(PlayerId())
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local msg = rawCommand:sub(4)
    TriggerServerEvent(('chat:server:311source'), source, caller, msg)
    TriggerServerEvent('311', source, caller, msg, playerCoords)
end, false)


RegisterNetEvent('chat:EmergencySend911r')
AddEventHandler('chat:EmergencySend911r', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">911r {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend311r')
AddEventHandler('chat:EmergencySend311r', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message nonemergency">311r {0} ({1}): {2} </div>',
            args = {caller, fal, msg}
        });

    end
end)

RegisterNetEvent('chat:EmergencySend911')
AddEventHandler('chat:EmergencySend911', function(fal, caller, msg, targetCoords)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message emergency">911 {0} ({1}): {2} </div>',
            args = {caller, fal, msg}
        });

        local alpha = 250
		local blip911 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(blip911,  480)
		SetBlipColour(blip911,  1)
		SetBlipScale(blip911, 0.8)
        SetBlipDisplay(blip911, 4)
        ShowNumberOnBlip(blip911, 911)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('911-' .. fal)
		EndTextCommandSetBlipName(blip911)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(blip911, alpha)

            if alpha == 0 then
                RemoveBlip(blip911)
                return
            end
  	    end
    end
end)

RegisterNetEvent('chat:EmergencySend311')
AddEventHandler('chat:EmergencySend311', function(fal, caller, msg, targetCoords)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message nonemergency">311 {0} ({1}): {2} </div>',
            args = {caller, fal, msg}
        });

        local alpha = 250
		local blip311 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(blip311,  480)
		SetBlipColour(blip311,  5)
		SetBlipScale(blip311, 0.8)
        SetBlipDisplay(blip311, 4)
        ShowNumberOnBlip(blip311, 311)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('311-' .. fal)
		EndTextCommandSetBlipName(blip311)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(blip311, alpha)

            if alpha == 0 then
                RemoveBlip(blip311)
                return
            end
  	    end
    end
end)

RegisterCommand('911r', function(target, args, rawCommand)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:911r'), target, source, msg)
        TriggerServerEvent('911r', target, source, msg)
    end
end, false)

RegisterCommand('311r', function(target, args, rawCommand)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then 
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:311r'), target, source, msg)
        TriggerServerEvent('311r', target, source, msg)
    end
end, false)


--[[ DUMPED USING FIVEX ]]--