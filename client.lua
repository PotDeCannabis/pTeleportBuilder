local BlipsCreated = {}
local Blips2Created = {}

Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	while ESX == nil do Wait(0) end
end)

-- Vérification

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
	Blips()
end)

-- Blips

CreateThread(function()
    Blips()
end)

function Blips()
    if BlipsCreated and #BlipsCreated > 0 then
        for i = 1, #BlipsCreated do
            RemoveBlip(BlipsCreated[i])
            BlipsCreated[i] = nil
        end
    end
	if Blips2Created and #Blips2Created > 0 then
        for i = 1, #Blips2Created do
            RemoveBlip(Blips2Created[i])
            Blips2Created[i] = nil
        end
    end
    for k, v in pairs(Point) do
        if v.JobActif == true then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.JobNom then
                if v.BlipsActif == true then
					-- Blips Point 01
                    local Blips = AddBlipForCoord(v.Point01.x, v.Point01.y, v.Point01.z)
                    SetBlipSprite(Blips, v.BlipsMotif)
                    SetBlipColour(Blips, v.BlipsCouleur)
                    SetBlipScale(Blips, v.BlipsTaille)
                    SetBlipAsShortRange(Blips, true)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString(v.BlipsNom)
                    EndTextCommandSetBlipName(Blips)
                    table.insert(BlipsCreated, Blips)

					-- Blips Point 02
					local Blips2 = AddBlipForCoord(v.Point02.x, v.Point02.y, v.Point02.z)
					SetBlipSprite(Blips2, v.BlipsMotif)
					SetBlipColour(Blips2, v.BlipsCouleur)
					SetBlipScale(Blips2, v.BlipsTaille)
					SetBlipAsShortRange(Blips2, true)
					BeginTextCommandSetBlipName('STRING')
					AddTextComponentString(v.Blips2Nom)
					EndTextCommandSetBlipName(Blips2)
					table.insert(Blips2Created, Blips2)
                end
            end
        else
            if v.BlipsActif == true then
				-- Blips Point 01
                local Blips = AddBlipForCoord(v.Point01.x, v.Point01.y, v.Point01.z)
                SetBlipSprite(Blips, v.BlipsMotif)
                SetBlipColour(Blips, v.BlipsCouleur)
                SetBlipScale(Blips, v.BlipsTaille)
                SetBlipAsShortRange(Blips, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(v.BlipsNom)
                EndTextCommandSetBlipName(Blips)
                table.insert(BlipsCreated, Blips)

				-- Blips Point 02
                local Blips2 = AddBlipForCoord(v.Point02.x, v.Point02.y, v.Point02.z)
                SetBlipSprite(Blips2, v.BlipsMotif)
                SetBlipColour(Blips2, v.BlipsCouleur)
                SetBlipScale(Blips2, v.BlipsTaille)
                SetBlipAsShortRange(Blips2, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(v.Blips2Nom)
                EndTextCommandSetBlipName(Blips2)
                table.insert(Blips2Created, Blips2)
            end
        end
    end
end

-- Intéraction [E] (Point01)

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Point) do
            if v.JobActif == true then
                if ESX.PlayerData.job and ESX.PlayerData.job.name == v.JobNom then
                    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Point01.x, v.Point01.y, v.Point01.z)
                    if dist <= 5 then 
                        wait = 1                                                 
                        DrawMarker(6, v.Point01.x, v.Point01.y, v.Point01.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 230, 230, 0 , 120)
                    end
                    if dist <= 2 then
                        wait = 1
                        Visual.Subtitle(v.HelpMessagePoint01, 1) 
                        if IsControlJustPressed(1,51) then
                            SetPedCoordsKeepVehicle(PlayerPedId(), v.Point02.x, v.Point02.y, v.Point02.z)
                        end
                    end
                end
            else 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Point01.x, v.Point01.y, v.Point01.z)
                if dist <= 5 then 
                    wait = 1                                                 
                    DrawMarker(6, v.Point01.x, v.Point01.y, v.Point01.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 230, 230, 0 , 120)
                end
                if dist <= 2 then
                    wait = 1
                    Visual.Subtitle(v.HelpMessagePoint01, 1) 
                    if IsControlJustPressed(1,51) then
                        SetPedCoordsKeepVehicle(PlayerPedId(), v.Point02.x, v.Point02.y, v.Point02.z)
                    end
                end
            end 
        end
    Citizen.Wait(wait)
    end
end)

-- Intéraction [E] (Point02)

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Point) do
            if v.JobActif == true then
                if ESX.PlayerData.job and ESX.PlayerData.job.name == v.JobNom then
                    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Point02.x, v.Point02.y, v.Point02.z)
                    if dist <= 5 then 
                        wait = 1                                                 
                        DrawMarker(6, v.Point02.x, v.Point02.y, v.Point02.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 230, 230, 0 , 120)
                    end
                    if dist <= 2 then
                        wait = 1
                        Visual.Subtitle(v.HelpMessagePoint02, 1) 
                        if IsControlJustPressed(1,51) then
                            SetPedCoordsKeepVehicle(PlayerPedId(), v.Point01.x, v.Point01.y, v.Point01.z)
                        end
                    end 
                end 
            else 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Point02.x, v.Point02.y, v.Point02.z)
                if dist <= 5 then 
                    wait = 1                                                 
                    DrawMarker(6, v.Point02.x, v.Point02.y, v.Point02.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 230, 230, 0 , 120)
                end
                if dist <= 2 then
                    wait = 1
                    Visual.Subtitle(v.HelpMessagePoint02, 1) 
                    if IsControlJustPressed(1,51) then
                        SetPedCoordsKeepVehicle(PlayerPedId(), v.Point01.x, v.Point01.y, v.Point01.z)
                    end
                end 
            end 
        end
    Citizen.Wait(wait)
    end
end)