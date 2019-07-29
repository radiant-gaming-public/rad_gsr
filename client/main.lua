ESX = nil
local hasShot = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = GetPlayerPed(-1)
        if IsPedShooting(ped) then
            TriggerServerEvent('GSR:SetGSR', timer)
            hasShot = true
            Citizen.Wait(Config.gsrUpdate)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if Config.waterClean and hasShot then
            ped = GetPlayerPed(-1)
            if IsEntityInWater(ped) then
                exports['mythic_notify']:DoLongHudText('inform', 'You begin cleaning off the Gunshot Residue... stay in the water') 
				Wait(100)
				TriggerEvent("mythic_progbar:client:progress", {
        			name = "washing_gsr",
        			duration = Config.waterCleanTime,
        			label = "Washing Off GSR",
        			useWhileDead = false,
        			canCancel = true,
        			controlDisables = {
            			disableMovement = false,
            			disableCarMovement = false,
            			disableMouse = false,
            			disableCombat = false,
        			},
    			}, function(status)
        			if not status then
            			if IsEntityInWater(ped) then
                    		hasShot = false
                    		TriggerServerEvent('GSR:Remove')
                    		exports['mythic_notify']:DoLongHudText('success', 'You washed off all the Gunshot Residue in the water')
                		else
                    		exports['mythic_notify']:DoLongHudText('error', 'You left the water too early and did not wash off the gunshot residue.')
                		end
        			end
    			end)
            end
        end
    end
end)

function status()
    if hasShot then
        ESX.TriggerServerCallback('GSR:Status', function(cb)
            if not cb then
                hasShot = false
            end
        end)
    end
end

function updateStatus()
    status()
    SetTimeout(Config.gsrUpdateStatus, updateStatus)
end

updateStatus()
