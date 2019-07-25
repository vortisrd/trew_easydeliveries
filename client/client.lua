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

local entregas = {
	{ x = -1218.90,			y = 665.73,				z = 144.53 }, 
	{ x = -1338.42,			y = 606.44,				z = 134.37 }, 
	{ x = -1052.13,			y = 431.67,				z = 77.06 }, 
	{ x = -904.04,			y = 191.49,				z = 69.04 },
	{ x = -23.75,			y = -23.71,				z = 73.24 }, 
	{ x = 226.15,			y = -283.52,			z = 49.35 }, 
	{ x = 5.97,				y = -708.16,			z = 45.97 }, 
	{ x = 285.29,			y = -937.44,			z = 29.38 }, 
	{ x = 411.78,			y = -1487.88,			z = 30.14 }, 
	{ x = -1015.67,			y = -1515.04,			z = 6.51 },
	{ x = -86.08,			y = 834.52,				z = 235.92 },
	{ x = -658.71,			y = 886.54,				z = 229.24 }, 
	{ x = -824.543,			y = 807.46,				z = 202.58 }, 
	{ x = -1383.36,			y = 266.63,				z = 61.238 }, 
	{ x = -2289.58,			y = 365.29,				z = 174.60 }, 
	{ x = -1004.788,		y = -1154.824,			z = 1.64603 },
	{ x = -1113.937,		y = -1193.136,			z = 1.827304 },
	{ x = -1075.903,		y = -1026.452,			z = 4.031562 },
	{ x = -1056.485,		y = -1001.234,			z = 1.639098 },
	{ x = -1090.886,		y = -926.188,			z = 2.630009 },
	{ x = -1075.903,		y = -1026.452,			z = 4.031562 },
	{ x = -1181.652,		y = -988.6455,			z = 1.634243 },
	{ x = -1151.11,			y = -990.905,			z = 1.638789 },	
	{ x = -1022.788,		y = -896.3149,			z = 4.908271 },
	{ x = -1060.738,		y = -826.829,			z = 18.69866},
	{ x = -968.6487,		y = -1329.453,			z = 5.144861 },
	{ x = -1185.5,			y = -1386.238,			z = 4.112149 },
	{ x = -1132.848,		y = -1456.029,			z = 4.372081 },
	{ x = -1125.602,		y = -1544.203,			z = 5.391256 },
	{ x = -1084.74,			y = -1558.709,			z = 4.10145 },
	{ x = -1098.367,		y = -1679.272,			z = 3.853804 },
	{ x = -1155.863,		y = -1574.202,			z = 8.344403 },
	{ x = -1122.675,		y = -1557.524,			z = 5.277201 },
	{ x = -1108.679,		y = -1527.393,			z = 6.265457 },
	{ x = -1273.549,		y = -1382.664,			z = 3.81341 },
	{ x = -1342.454,		y = -1234.849,			z = 5.420023 },
	{ x = -1351.21,			y = -1128.669,			z = 3.626104 },
	{ x = -1343.232,		y = -1043.639,			z = 7.303696 },
	{ x = -729.2556,		y = -880.1547,			z = 22.22747 },
	{ x = -831.3006,		y = -864.8558,			z = 20.22383 },
	{ x = -810.4093,		y = -978.4364,			z = 13.74061 },
	{ x = -683.8874,		y = -876.8568,			z = 24.02004 },
	{ x = -1031.316,		y = -903.0217,			z = 3.692086 },
	{ x = -1262.703,		y = -1123.342,			z = 7.092357 },
	{ x = -1225.079,		y = -1208.524,			z = 7.619214 },
	{ x = -1207.095,		y = -1263.851,			z = 6.378308 },
	{ x = -1086.787,		y = -1278.122,			z = 5.09411 },
	{ x = -886.1298,		y = -1232.698,			z = 5.006698 },
	{ x = -753.5927,		y = -1512.016,			z = 4.370816 },
	{ x = -696.3545,		y = -1386.89,			z = 4.846177 }
}





local isDeliveryGoing = false
local deliveryBlip = nil
local itemsAmmount = 0
local playerJob = nil

local ballas = { x = 84.72, y = -1958.43, z = 20.20 }


-- Countdown
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isDeliveryGoing == false then

			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			local bz,cz = GetGroundZFor_3dCoord(ballas['x'], ballas['y'], ballas['z'])
			local distance = GetDistanceBetweenCoords(ballas['x'], ballas['y'],cz,x,y,z,true)

			if distance <= 40 then

				trewDeliveryDrawMarker(
					1,
					{ ballas['x'], ballas['y'], ballas['z'] },
					{ 210, 0, 255 }
				)

				if distance <= 1.2 then

					-- IF YOU PRESS E, YOU MAKE THE DELIVERY
					if IsControlJustPressed(0,Keys['E']) and not IsPedInAnyVehicle(PlayerPedId()) then


							TriggerEvent('trew_easydeliveries:start', {
								job = 'unemployed',
								product = 'bread',
								howmany = 2,
								label = 'Venda de cocaína', 
								title = 'Dirija-se aos locais para vender seus pães',
								reward = 1000,
								rewardtype = 'black',
								anim = {
									dict = 'pickup_object',
									name = 'putdown_low'
								},
								blipcolor = 27,
								markercolor = {
									r = 210,
									g = 0,
									b = 255
								},
								markervisibility = 40,
								blips = entregas
							}, function(status)

								if status == true then
									print('finalizei as entregas')
								elseif status == 'not_enough_items' then
									print('os itens acabaram no meio da entrega')
								elseif status == 'delivery_cancelled' then
									print('a entrega foi cancelada')
								elseif status == 'dead' then
									print('você morreu')
								else
									print('alguma coisa falhou e eu nao sei o que é')
								end

							end)




					else
						DisplayHelpText( 'Pressione ~INPUT_PICKUP~ iniciar as entregas. ~b~' )
					end
				end

			end

		end

	end
end)


RegisterNetEvent('trew_easydeliveries:start')
AddEventHandler('trew_easydeliveries:start', function(args,cb)

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
				PlaySoundFrontend(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 1)
				ESX.ShowNotification( _U('starting_system') )

				SetTimeout(1000, function()


					-- JUST CHECKING IF YOUR JOB IS THE SAME AS DEFINED
					if playerJob == args['job'] then

						-- FAKE CALL TO GIVE THE SERVER TIME TO RETURN THE ITEM INVENTORY
						PlaySoundFrontend(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 1)
						ESX.ShowNotification( _U('checking_inventory') )



						SetTimeout(1000, function()				


							-- IF YOU HAVE ITEMS ENOUGH FOR DELIVERY!
							if itemsAmmount >= args['howmany'] then

								PlaySoundFrontend(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 1)
								ESX.ShowNotification( _U('calculating_routes') )

								SetTimeout(1000, function()
									-- START!
									PlaySoundFrontend(-1, 'Event_Start_Text', 'GTAO_FM_Events_Soundset', 1)
									trewDeliveryStart(args,cb)
								end)


							else


								PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
								ESX.ShowNotification( _U('not_enough_items_start') )


							end

						end)

					else

						PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
						ESX.ShowNotification( _U('different_job') )

					end





				end)



			else

				PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
				ESX.ShowNotification( _U('more_checkpoints_than_items') )

			end

		else
			PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
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


function trewDeliveryStart(args,cb)

	local job = args['job']
	local product = args['product']
	local howmany = args['howmany']
	local label = args['label']
	local title = args['title']
	local reward = args['reward']
	local rewardtype = args['rewardtype']
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

	PlaySoundFrontend(-1, 'Event_Start_Text', 'GTAO_FM_Events_Soundset', 1)
	ESX.ShowNotification( _U('title') )
	ESX.ShowNotification( _U('first_checkpoint') )


	Citizen.CreateThread(function ()
		while isDeliveryGoing do
			Citizen.Wait(0)


			-- CANCEL
			if IsControlJustReleased(0,Keys[ Config.cancelDeliveryKey ]) then
				cb('delivery_cancelled')
				PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
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
								if IsControlJustPressed(0,Keys['E']) and not IsPedInAnyVehicle(PlayerPedId()) then

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


									-- REMOVING THE ITEM FROM YOUR INVENTORY
									TriggerServerEvent('trew_easydeliveries:removeItemAndReward', product, reward, rewardtype, 1)


									-- CHECKING IF THE DELIVERY IS COMPLETE
									if blipCount > howmany then
										cb(true)
										TriggerEvent('trew_easydeliveries:cancel')
										PlaySoundFrontend(-1, 'Event_Start_Text', 'GTAO_FM_Events_Soundset', 1)
										ESX.ShowNotification( _U('delivery_complete') )
									else


										-- ... AND IT IF'TS NOT, CHECKING THE INVENTORY AGAIN, COZ, WHY NOT?
										TriggerServerEvent('trew_easydeliveries:checkInventory', product)

										--SetTimeout(500, function()

											-- IF YOU, BY MISTAKE, EITHER USED ONE OF THE ITEMS DESTINED FOR DELIVERY OR LOST IT, THE EVENT WILL BE CANCELLED
											if itemsAmmount < math.floor(howmany-blipCount) then
												cb('not_enough_items')
												PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
												TriggerEvent('trew_easydeliveries:cancel')
												ESX.ShowNotification( _U('not_enough_items_in_between') )
											else

												-- ... AND IF NOT, IT WILL LEAD YOU TO THE NEXT CHECKPOINT!
												currentblip = math.random(1,howmany)
												PlaySoundFrontend(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 1)
												ESX.ShowNotification( _U('next_checkpoint') )
											end
										--end)

									end

								else
									DisplayHelpText( _U('press_key_to_start') )
								end




						end


					end



				else
					cb('dead')
					TriggerEvent('trew_easydeliveries:cancel')
					PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', 1)
					ESX.ShowNotification( _U('youre_dead') )
				end
			end

			



		end
	end)

end


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