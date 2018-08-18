ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-qalle-needs:sync')
AddEventHandler('esx-qalle-needs:sync', function(ped, need, sex)
    TriggerClientEvent('esx-qalle-needs:syncCL', -1, ped, need, sex)
end)

RegisterServerEvent('esx-qalle-needs:add')
AddEventHandler('esx-qalle-needs:addt', function(source, thingy, amount)
  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerClientEvent('esx_status:add', source, thingy, amount)

end)
