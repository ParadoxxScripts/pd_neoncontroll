ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("rtx_neons:CheckNeons", function(source, cb, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchScalar('SELECT neons FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = vehicleProps.plate
		}, function (neons)
			if neons ~= nil then
				cb(neons)
			else
				cb(false)
			end
		end)
	end
end)

ESX.RegisterUsableItem("neonbox", function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerPed = GetPlayerPed(source)	
	local playervehicle = GetVehiclePedIsIn(playerPed)
	if playervehicle then
		local vehicleplate = GetVehicleNumberPlateText(playervehicle)
		xPlayer.removeInventoryItem("neonbox", 1)
		MySQL.Async.fetchAll('SELECT neons FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = vehicleplate
		}, function (neons)
			if neons[1] ~= nil then
				MySQL.Async.execute("UPDATE owned_vehicles SET neons = @neons WHERE owner = @owner AND plate = @plate", {
					['@owner'] = xPlayer.identifier,
					['@plate'] = vehicleplate,
					['@neons'] = 1
				}, function (changed)
					TriggerClientEvent("esx:showNotification", source, "Neons installed on vehicle with plate "..vehicleplate.."")
					if Config.NeonsUseOnlyViaController then
						xPlayer.addInventoryItem('neoncontroller', 1)
					end
				end)	
			else
				TriggerClientEvent("esx:showNotification", source, "This vehicle is not owned!")
			end
		end)	
	else
		TriggerClientEvent("esx:showNotification", source, "You are not in vehicle")
	end
end)

if Config.NeonsUseOnlyViaController then
	ESX.RegisterUsableItem("neoncontroller", function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local playerPed = GetPlayerPed(source)	
		local playervehicle = GetVehiclePedIsIn(playerPed)
		if playervehicle then
			TriggerClientEvent("rtx_neons:UseController", source)
		else
			TriggerClientEvent("esx:showNotification", source, "You are not in vehicle")
		end
	end)
end