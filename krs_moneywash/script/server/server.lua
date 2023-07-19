ESX.RegisterServerCallback('krs_moneywash:GetPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money   = xPlayer.getAccount('black_money').money
    cb(money)
end)  

RegisterServerEvent('krs_moneywash:WashMoney')
AddEventHandler('krs_moneywash:WashMoney', function()
    local xPlayer    = ESX.GetPlayerFromId(source)
    local removecash = Krs.Washprezzo
    local money      = xPlayer.getAccount('black_money').money

    xPlayer.setAccountMoney('black_money', 0)
    xPlayer.addAccountMoney('money', (money * (100 - removecash) / 100))

    if xPlayer.getAccount('black_money').money == 0 then
        TriggerClientEvent('ox_lib:notify', source, {type = 'success', description = "You cleaned your money", 4000})
    else
        TriggerClientEvent('ox_lib:notify', source, {type = 'error', description = "Error washing money", 4000})
    end
end)
