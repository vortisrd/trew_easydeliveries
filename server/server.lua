ESX  = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('trew_easydeliveries:checkInventory')
AddEventHandler('trew_easydeliveries:checkInventory', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemNumber = xPlayer.getInventoryItem(item).count
	TriggerClientEvent('trew_easydeliveries:inventoryResult', source, itemNumber)
end)


RegisterNetEvent('trew_easydeliveries:getJob')
AddEventHandler('trew_easydeliveries:getJob', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name

    TriggerClientEvent('trew_easydeliveries:getJobResult', source, job)
end)

RegisterServerEvent('trew_easydeliveries:removeItemAndReward')
AddEventHandler('trew_easydeliveries:removeItemAndReward', function(item,money,moneytype,howmany)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, howmany)

	if (moneytype == 'black') then
		moneytype = 'black_money'
		xPlayer.addAccountMoney(moneytype, money)
	elseif (moneytype == 'bank') then
		moneytype = 'bank'
		xPlayer.addAccountMoney(moneytype, money)
	else
		moneytype = 'cash'
		xPlayer.addMoney(money)
	end


	TriggerClientEvent('trew_easydeliveries:inventoryResult', source, item)
end)