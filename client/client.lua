local Lavaggio = false
local TempoLavaggio =  false


local function Tempo()
	TempoLavaggio = true
	Wait(Config.Tempo)
	TempoLavaggio = false
end


function LavaggioSoldi()

	local playerPed = cache.ped or PlayerPedId()

    if Lavaggio then

        lib.notify({
            title = locale('title_notify'),
            description = locale('description_start_wash'),
            type = locale('error_notify')
        })
    else
        if not TempoLavaggio then
         
            lib.requestAnimDict('anim@gangops@facility@servers@bodysearch@', 10)
            TaskPlayAnim(playerPed, 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, -8.0, -1, 48, 0)
			
            local input = lib.inputDialog(locale('title_menu_dialog'), {
				{type = 'number', label = locale('label_dialog'), min = 1, description = locale('description_dialog'), icon = Config.iconaDialog},
			})
    
            if not input then return end
            local WashAmount = tonumber(input[1])    
            TriggerServerEvent('krs_moneywash:washAmount', WashAmount)
            Wait(500)
            ClearPedTasksImmediately(playerPed)
        else
            lib.notify({
                title = locale('title_notify'),
                description = locale('description_time_wash'),
                type = locale('error_notify')
            })
        end
    end
end



RegisterNetEvent('krs_moneywash:startWashing', function()

	local playerPed = cache.ped or PlayerPedId()

	Lavaggio = true

	lib.notify({
		title = locale('title_notify'),
		description = locale('description_start_washing'),
		type = locale('inform_notify')
	})

	Wait(1000)

	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_AA_SMOKE")

	if lib.progressCircle({
		duration = Config.WashDuration,
		position = Config.positionProgress,
		label = locale('label_progress'),
		useWhileDead = false,
		canCancel = false,
	}) then 

		lib.notify({
			title = locale('title_notify'),
			description = locale('description_finish_wash'),
			type = locale('inform_notify')
		}) 
	end

	Lavaggio = false
	ClearPedTasks(playerPed)
    Tempo()
end)



	for k, v in pairs(Config.MarkerPos) do 

	local point = lib.points.new({

		coords = v.pos,
		distance = 3,
	
	})
 
	function point:onEnter()
		lib.showTextUI(locale('enter_textui'), {
			position = Config.positionTextUi,
			icon = Config.iconTextUi,
			style = {
				borderRadius = Config.borderRadiusTextUi,
				backgroundColor = Config.backgroundColorTextUi,
				color = Config.colorTextUi
			}
		})
	end
	
	function point:onExit()
		lib.hideTextUI()
	end
	
	function point:nearby()
		DrawMarker(22, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 255, false, true, 2, false, nil, nil, false)
	
		if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
			LavaggioSoldi()
		end
	end
end