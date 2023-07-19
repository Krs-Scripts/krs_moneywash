AddEventHandler('krs_moneywash:OpenNui', function()
    ESX.TriggerServerCallback('krs_moneywash:GetPlayerData', function(money)
        if money < 1 then
            lib.notify({
                title = 'Money Wash',
                description = Krs.Lang['nonhaisoldi'],
                type = 'error'
            })
            return
        end
        
        SendNUIMessage({
            action  = 'open',
            blackcash  = money,
            removecash  = Krs.Washprezzo, 
            currency  = Krs.Currency,
            notify  = {
                titolo1  = Krs.Lang['titolo1'],
                titolo2  = Krs.Lang['titolo2'],
                prezzo  = Krs.Lang['prezzo'],
                soldisporchi  = Krs.Lang['soldisporchi'],
                soldipuliti  = Krs.Lang['soldipuliti'],
                washmoney  = Krs.Lang['lavaggiosoldi'],
                nonhaisoldi  = Krs.Lang['nonhaisoldi'],
                accetta  = Krs.Lang['accetta'],
                annulla  = Krs.Lang['annulla']
            },
        })

        SetNuiFocus(true, true)
    end)
end)


AddEventHandler('krs_moneywash:CloseNui', function()
    SendNUIMessage({
        action    = close,
    })

    SetNuiFocus(false)
end)

RegisterNUICallback('WashBlackMoney', function(data, cb)
    TriggerServerEvent('krs_moneywash:WashMoney')
end)


RegisterNUICallback('close', function(data, cb)
    TriggerEvent('krs_moneywash:CloseNui') 
end)


-- RegisterCommand('washopen', function()
--     TriggerEvent('krs_moneywash:OpenNui') 
-- end)


if Krs.type == 'ox_target' then
    Citizen.CreateThread(function()
        for k,v in pairs(Krs.PosWash) do
            local options = {
                {
                    icon = Krs.Icon, 
                    label = Krs.Label,
                    distance = 10.5,
                    onSelect = function(data)
                        TriggerEvent('krs_moneywash:OpenNui')
                    end,
                    canInteract = function(entity, distance, coords, name, bone)
                        return not IsEntityDead(entity)
                    end
                }
            }
            
            Citizen.CreateThread(function()
                for i = 1, #Krs.NpcWash, 1 do
                    if not HasModelLoaded(Krs.NpcWash[i].modelloNpc) then
                        RequestModel(Krs.NpcWash[i].modelloNpc)
                        while not HasModelLoaded(Krs.NpcWash[i].modelloNpc) do
                            Citizen.Wait(5)
                        end
                    end
                    npc = CreatePed(4, Krs.NpcWash[i].modelloNpc, Krs.NpcWash[i].posizioneNpc, false, true)
                    FreezeEntityPosition(npc, true)
                    SetEntityInvincible(npc, true)
                    SetBlockingOfNonTemporaryEvents(npc, true)
                    exports.ox_target:addLocalEntity(npc, options)
                end
            end)
        end
    end)
end

if Krs.type == 'marker' then
    Citizen.CreateThread(function()
        for k,v in pairs(Krs.PosWash) do
            TriggerEvent('gridsystem:registerMarker', {
                name = '_moneywash',
                pos = Krs.PosWash.marker,
                type = 22,
                color = { r = 0, g = 140, b = 255 },
                scale = vector3(0.50, 0.50, 0.50),
                size = vector3(1.5,1.5,1.5),
                control = 'E',
                msg = Krs.Lang['msg'],
                action = function()
                    TriggerEvent('krs_moneywash:OpenNui')
                end
            })
        end
    end)
end

-- Karos Blip --
CreateThread(function()
    for i = 1, #Krs.PosBlipWash, 1 do
        local Krs = Krs.PosBlipWash[i]

            if Krs.blip.active then 
            local blip = AddBlipForCoord(Krs.poswashmoney.x, Krs.poswashmoney.y, Krs.poswashmoney.z)
            SetBlipSprite (blip, Krs.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, Krs.blip.size)
            SetBlipColour (blip, Krs.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Krs.blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)
  

-- RegisterCommand('showinfo', function()
--     SendNUIMessage({
--         action = 'info'
--     })
-- end)

-- RegisterCommand('closeinfo', function()
--     SendNUIMessage({
--         action = 'closeinfo'
--     })
-- end)