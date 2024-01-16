local ox_inventory = exports.ox_inventory


RegisterNetEvent('krs_moneywash:washAmount', function(Quantita)
    
    local source = source
    local Percentuale = Quantita * Config.Percentuale
    local Totale = Quantita - Percentuale
    local black_money = exports.ox_inventory:Search(source, 'count','black_money')

    if black_money >= Quantita then

        exports.ox_inventory:RemoveItem(source, 'black_money', Quantita)

        TriggerClientEvent('krs_moneywash:startWashing', source)
        Citizen.Wait(Config.WashDuration)
        exports.ox_inventory:AddItem(source, 'money', Totale)
    else
        TriggerClientEvent('ox_lib:notify', source, {title = 'KRS MONEYWASH', description = 'Non hai abbastanza soldi sporchi.', type = 'error'})
    end
end)
