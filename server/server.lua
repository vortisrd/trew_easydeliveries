ESX  = nil
local deliveryPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('trew_easydeliveries:start')
AddEventHandler('trew_easydeliveries:start', function(args)

	local xPlayer = ESX.GetPlayerFromId(args['player'])

	if xPlayer.job.name == args['job'] then
		deliveryPlayers[args['player']] = {
			job = args['job'],
			item = args['item'],
			rewardMoney = args['reward'],
			rewardType = args['rewardtype'],
			howmany = args['howmany']
		}

		args['reward'] = nil
		args['rewardtype'] = nil

		TriggerClientEvent('trew_easydeliveries:checkList', args['player'], args)
	else
		TriggerClientEvent('trew_easydeliveries:playSound', args['player'], 'error')
		TriggerClientEvent('esx:showNotification', args['player'], _U('different_job') )
	end
end)




RegisterServerEvent('trew_easydeliveries:checkInventory')
AddEventHandler('trew_easydeliveries:checkInventory', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemNumber = xPlayer.getInventoryItem(item).count
	TriggerClientEvent('trew_easydeliveries:inventoryResult', source, itemNumber)
end)


RegisterServerEvent('trew_easydeliveries:getJob')
AddEventHandler('trew_easydeliveries:getJob', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name

    TriggerClientEvent('trew_easydeliveries:getJobResult', source, job)
end)

RegisterServerEvent('trew_easydeliveries:removeItemAndReward')
AddEventHandler('trew_easydeliveries:removeItemAndReward', function(item)
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(1,Config.maxDeliveryItems)

	local rewardType = deliveryPlayers[source]['rewardType']
	local reward = math.ceil(deliveryPlayers[source]['rewardMoney']*random)

	local itemNumber = xPlayer.getInventoryItem(item).count

	if itemNumber < random then
		TriggerClientEvent('trew_easydeliveries:playSound', source, 'start')
		TriggerClientEvent('esx:showNotification', source, _U('not_enough_items_start') )
		TriggerClientEvent('trew_easydeliveries:cancel', source)
	elseif itemNumber <= 0 then
		TriggerClientEvent('trew_easydeliveries:playSound', source, 'timer')
		TriggerClientEvent('esx:showNotification', source, _U('not_enough_items_start') )
		TriggerClientEvent('trew_easydeliveries:cancel', source)
	else
		xPlayer.removeInventoryItem(item, math.ceil(1*random))

		if (rewardType == 'black_money') or (rewardType == 'bank') then
			xPlayer.addAccountMoney(rewardType, reward)
		else
			xPlayer.addMoney(reward)
		end

		itemNumber = xPlayer.getInventoryItem(item).count

		if itemNumber <= 0 then
			TriggerClientEvent('trew_easydeliveries:playSound', source, 'start')
			TriggerClientEvent('esx:showNotification', source, _U('not_enough_items_in_between') )
			TriggerClientEvent('trew_easydeliveries:cancel', source)
		else
			TriggerClientEvent('trew_easydeliveries:inventoryResult', source, itemNumber)

			TriggerClientEvent('trew_easydeliveries:playSound', source, 'timer')
			TriggerClientEvent('esx:showNotification', source, _U('next_checkpoint') )
		end
	end

	
end)