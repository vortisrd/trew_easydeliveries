local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local ESX	 = nil


-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
 
end)


local isDeliveryGoing = false
local deliveryBlip = nil
local itemsAmmount = 0
local playerJob = nil


RegisterNetEvent('trew_easydeliveries:checkList')
AddEventHandler('trew_easydeliveries:checkList', function(args)

	TriggerServerEvent('trew_easydeliveries:getJob', args['job'])

	-- YOU'RE NOT DEAD, RIGHT?
	if not IsEntityDead(GetPlayerPed(-1)) then

		-- ... AND YOU'RE NOT DOING OTHER DELIVERIES, RIGHT?
		if isDeliveryGoing == false then

			if args['howmany'] then --[[meh]]
			else args['howmany'] = #args['blips'] end

			-- IF THE AMMOUNT OF DELIVERIES ARE ENOUGH FOR THE BLIPS
			if args['howmany'] <= #args['blips'] then

				TriggerServerEvent('trew_easydeliveries:checkInventory', args['product'])
				TriggerEvent('trew_easydeliveries:playSound', 'countdown')
				ESX.ShowNotification( _U('starting_system') )

				SetTimeout(1000, function()



						-- FAKE CALL TO GIVE THE SERVER TIME TO RETURN THE ITEM INVENTORY
						TriggerEvent('trew_easydeliveries:playSound', 'countdown')
						ESX.ShowNotification( _U('checking_inventory') )



						SetTimeout(1000, function()				


							-- IF YOU HAVE ITEMS ENOUGH FOR DELIVERY!
							if itemsAmmount >= args['howmany'] then

								TriggerEvent('trew_easydeliveries:playSound', 'countdown')
								ESX.ShowNotification( _U('calculating_routes') )

								SetTimeout(1000, function()
									-- START!
									TriggerEvent('trew_easydeliveries:playSound', 'start')
									trewDeliveryStart(args)
								end)


							else


								TriggerEvent('trew_easydeliveries:playSound', 'error')
								ESX.ShowNotification( _U('not_enough_items_start') )


							end

						end)






				end)



			else

				TriggerEvent('trew_easydeliveries:playSound', 'error')
				ESX.ShowNotification( _U('more_checkpoints_than_items') )

			end

		else
			TriggerEvent('trew_easydeliveries:playSound', 'error')
			ESX.ShowNotification( string.format( Locales[Config.Locale]['already_doing_deliveries'], Config.cancelDeliveryKey ) )
		end

	else
		ESX.ShowNotification( _U('youre_dead') )
	end



end)


RegisterNetEvent('trew_easydeliveries:inventoryResult')
AddEventHandler('trew_easydeliveries:inventoryResult', function(itemNumber)
    itemsAmmount = itemNumber
end)

RegisterNetEvent('trew_easydeliveries:getJobResult')
AddEventHandler('trew_easydeliveries:getJobResult', function(job)
    playerJob = job
end)


RegisterNetEvent('trew_easydeliveries:cancel')
AddEventHandler('trew_easydeliveries:cancel', function()
	RemoveBlip(deliveryBlip)
	isDeliveryGoing = false
	deliveryBlip = nil
	itemsAmmount = 0
	deliveryJob = nil
end)


function trewDeliveryStart(args)

	local job = args['job']
	local product = args['product']
	local howmany = args['howmany']
	local label = args['label']
	local title = args['title']
	local blips = args['blips']
	local blipColor = args['blipcolor']
	local r,g,b = args['markercolor']['r'],args['markercolor']['g'],args['markercolor']['b']
	local anim = args['anim']
	local markervisibility = args['markervisibility']

	isDeliveryGoing = true
	local currentblip = math.random(1,#blips)
	local blipCount = 1
	blips[currentblip]['active'] = false
	blips[currentblip]['delivered'] = false

	ESX.ShowNotification( title )
	ESX.ShowNotification( _U('first_checkpoint') )


	Citizen.CreateThread(function ()
		while isDeliveryGoing do
			Citizen.Wait(0)


			-- CANCEL
			if IsControlJustReleased(0,Keys[ Config.cancelDeliveryKey ]) then
				TriggerEvent('trew_easydeliveries:playSound', 'error')
				TriggerEvent('trew_easydeliveries:cancel')
				ESX.ShowNotification( _U('delivery_cancelled') )
			else

				if not IsEntityDead(GetPlayerPed(-1)) then

					local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
					local bz,cz = GetGroundZFor_3dCoord(blips[currentblip]['x'],blips[currentblip]['y'],blips[currentblip]['z'])
					local distance = GetDistanceBetweenCoords(blips[currentblip]['x'],blips[currentblip]['y'],cz,x,y,z,true)


					-- CHECKING IF YOU DIDN'T WENT THER ALREADY
					if not blips[currentblip]['active'] then

						-- ... AND IF YOU'RE GOING THERE, TELL IF YOU'RE DID THE DELIVERY
						if not blips[currentblip]['delivered'] then
							blips[currentblip]['active'] = true
							trewDeliveryCreateBlip(
								{blips[currentblip]['x'],blips[currentblip]['y'],blips[currentblip]['z']},
								blipColor,
								label
							)
						else
							currentblip = math.random(1,#blips)
						end

					end


					-- YOU CAN SEE THE MARKER FROM 40 METERS AWAY
					if distance <= markervisibility then

						trewDeliveryDrawMarker(
							20,
							{ blips[currentblip]['x'], blips[currentblip]['y'], blips[currentblip]['z'] },
							{ r, g, b }
						)

						-- ... AND BY 1.2 METERS, THE HELPER WILL SHOW.
						if distance <= 1.2 then


								-- IF YOU PRESS E, YOU MAKE THE DELIVERY
								if IsControlJustPressed(0,Keys['E']) then

											blips[currentblip]['active'] = false
											blips[currentblip]['delivered'] = true
											
											RemoveBlip(deliveryBlip)
											blipCount = math.floor(blipCount+1)
											deliveryBlip = nil

											if (anim) and (anim['dict']) and (anim['name']) then

												ESX.Streaming.RequestAnimDict(anim['dict'], function()
													TaskPlayAnim(PlayerPedId(), anim['dict'], anim['name'], 8.0, -8.0, -1, 0, 0, false, false, false)
												end)

											end

											-- REMOVING THE ITEM FROM YOUR INVENTORY AND GIVE YOU THE REWARD
											TriggerServerEvent('trew_easydeliveries:removeItemAndReward', product)

											-- CHECKING IF THE DELIVERY IS COMPLETE
											if blipCount > howmany then
												TriggerEvent('trew_easydeliveries:cancel')
												TriggerEvent('trew_easydeliveries:playSound', 'start')
												ESX.ShowNotification( _U('delivery_complete') )
											else
												currentblip = math.random(1,howmany)
											end

								else
									DisplayHelpText( _U('press_key_to_start') )
								end




						end


					end



				else
					TriggerEvent('trew_easydeliveries:cancel')
					TriggerEvent('trew_easydeliveries:playSound', 'error')
					ESX.ShowNotification( _U('youre_dead') )
				end
			end

			



		end
	end)

end


RegisterNetEvent('trew_easydeliveries:playSound')
AddEventHandler('trew_easydeliveries:playSound', function(type)
	if type == 'start' then
		PlaySoundFrontend(-1, 'Event_Start_Text', 'GTAO_FM_Events_Soundset', 1)
	elseif type == 'error' then
		PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
	elseif type == 'timer' then
		PlaySoundFrontend(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 1)
	else
		PlaySoundFrontend(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 1)
	end
end)


function DisplayHelpText(str)
	SetTextComponentFormat('STRING')
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function trewDeliveryCreateBlip(blipCoords,blipColor,blipLabel)
	local x,y,z = blipCoords[1],blipCoords[2],blipCoords[3]

	if not DoesBlipExist(deliveryBlip) then
		deliveryBlip = AddBlipForCoord(x,y,z)
		SetBlipScale(deliveryBlip,0.7)
		SetBlipSprite(deliveryBlip,1)
		SetBlipColour(deliveryBlip,blipColor)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString( blipLabel )
		EndTextCommandSetBlipName(deliveryBlip)
		SetBlipAsShortRange(deliveryBlip,false)
		SetBlipRoute(deliveryBlip,true)
	end
end


function trewDeliveryDrawMarker(markerType,markerCoords,makerColor)
	DrawMarker(
		markerType,
		markerCoords[1],markerCoords[2],markerCoords[3],
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		1.5, 1.5, 1.0,
		makerColor[1],makerColor[2],makerColor[3],
		100,
		false,
		true,
		2,
		true,
		false,
		false,
		false
	)
end


exports('deliveryStatus', function()
	return isDeliveryGoing
end)