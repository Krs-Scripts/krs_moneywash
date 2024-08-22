
RegisterNetEvent('krs_moneywash:washAmount', function(amount)
    local source = source
    local percentage = amount * cfg.percentage
    local total = amount - percentage

    local black_money = exports.ox_inventory:Search(source, 'count', 'black_money')

    if black_money >= amount then
       
        exports.ox_inventory:RemoveItem(source, 'black_money', amount)

        TriggerClientEvent('krs_moneywash:startWashing', source, amount)

        Wait(cfg.washDuration)

        exports.ox_inventory:AddItem(source, 'money', total)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Krs MoneyWash',
            description = 'You do not have enough dirty money.',
            type = 'error'
        })
    end
end)
