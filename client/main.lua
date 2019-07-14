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
                TriggerEvent("chatMessage", "[GSR]", {255, 0, 0}, "You begin cleaning off the Gunshot Residue... stay in the water")
                Citizen.Wait(Config.waterCleanTime)
                if IsEntityInWater(ped) then
                    hasShot = false
                    TriggerServerEvent('GSR:Remove')
                    TriggerEvent("chatMessage", "[GSR]", {255, 0, 0}, "^2You washed off all the Gunshot Residue in the water")
                else
                    TriggerEvent("chatMessage", "[GSR]", {255, 0, 0}, "^1You left the water too early and did not wash off the gunshot residue.")
                end
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
