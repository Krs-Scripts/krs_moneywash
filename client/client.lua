local startWashing = false
local timeWashing = false
local currentWashAmount = 0

local function setTimeWashing()
    timeWashing = true
    Wait(cfg.waitRewashing)
    timeWashing = false
end

local function startWashingMoney()
    if startWashing then
        lib.notify({
            title = locale('title_notify'),
            description = locale('description_start_wash'),
            type = locale('error_notify')
        })
        return
    end

    if timeWashing then
        lib.notify({
            title = locale('title_notify'),
            description = locale('description_time_wash'),
            type = locale('error_notify')
        })
        return
    end

    local input = lib.inputDialog(locale('title_menu_dialog'), {
        {type = 'number', label = locale('label_dialog'), min = 1, description = locale('description_dialog'), icon = cfg.iconDialog}
    })

    if not input then return end

    currentWashAmount = tonumber(input[1])

    TriggerServerEvent('krs_moneywash:washAmount', currentWashAmount)
end

RegisterNetEvent('krs_moneywash:startWashing', function(amount)
    local playerPed = cache.ped

    startWashing = true

    lib.notify({
        title = locale('title_notify'),
        description = locale('description_start_washing'),
        type = locale('inform_notify')
    })

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_AA_SMOKE")

    if lib.progressCircle({
        duration = cfg.washDuration,
        position = cfg.positionProgress,
        label = locale('label_progress'),
        useWhileDead = false,
        canCancel = false
    }) then
       
        lib.notify({
            title = locale('title_notify'),
            description = locale('description_finish_wash'),
            type = locale('inform_notify')
        })
    end

    startWashing = false
    ClearPedTasksImmediately(playerPed)
    setTimeWashing()
end)

for k, v in pairs(cfg.positionWashing) do
    local point = lib.points.new({
        coords = v.coords,
        distance = 3
    })

    function point:onEnter()
        lib.showTextUI(locale('enter_textui'), {
            position = cfg.positionTextUi,
            icon = cfg.iconTextUi,
            style = {
                borderRadius = cfg.borderRadius,
                backgroundColor = cfg.backgroundColor,
                color = cfg.color
            }
        })
    end

    function point:onExit()
        lib.hideTextUI()
    end

    function point:nearby()
        DrawMarker(0, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 255, false, true, 2, false, nil, nil, false)

        if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
            startWashingMoney()
        end
    end
end