
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('elixirlivelli:getlevel')
AddEventHandler('elixirlivelli:getlevel', function()
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM elixircitylivelli WHERE id = @id', {
			['@id'] = xPlayer.identifier
    })
    
    if result[1] ~= nil then

          TriggerClientEvent('elixirlivelli:sendlevel', _source, result[1].generaleL)    
          TriggerClientEvent('elixirlivelli:sendpercent', _source, result[1].generaleE)    





    else
      TriggerClientEvent('esx:showNotification', _source, 'you havent register')
      MySQL.Async.execute('INSERT INTO player_exp (identifier, level, percent) VALUES (@identifier, @level, @percent)', {
        ['@identifier'] = xPlayer.identifier,
        ['@level'] = 1,
        ['@percent'] = 0
      })

      TriggerClientEvent('esx:showNotification', _source, 'data updated')
      
    end

end)

RegisterServerEvent('elixirlivelli:getexp')
AddEventHandler('elixirlivelli:getexp', function()
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM elixircitylivelli WHERE id = @id', {
			['@id'] = xPlayer.identifier
    })
    
    if result[1] ~= nil then
          print("ECCO IL TUO EXP " .. result[1].generaleE)
    end

end)
    

RegisterServerEvent('elixirlivelli:addexperience')
AddEventHandler('elixirlivelli:addexperience', function(totalexp)
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

		MySQL.Async.execute('UPDATE elixircitylivelli SET generaleE = @percent WHERE id = @id', {
      ['@id'] = xPlayer.identifier,
      ['@percent'] = totalexp
    }, function (rowsChanged)
      
    
    end)


end)





RegisterServerEvent('elixirlivelli:addonelevel')
AddEventHandler('elixirlivelli:addonelevel', function(currentlevel)
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

		MySQL.Async.execute('UPDATE player_exp SET level = @level WHERE identifier = @identifier', {
      ['@identifier'] = xPlayer.identifier,
      ['@level'] = currentlevel + 1 
    }, function (rowsChanged)
      
    
    end)


end)
