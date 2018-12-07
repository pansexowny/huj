
function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end
  
AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message,1,string.len("/"))=="/" then
		--ne doit rien se passer c'est une commande
	else
		TriggerClientEvent("sendProximityMessage", -1, source, name, message)
	end
	CancelEvent()
end)
  
  --EXT1 DO NOT TOUCH
  function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
  --EXT2 DO NOT TOUCH
  local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
  end
RegisterServerEvent('3dme:do')
AddEventHandler('3dme:do', function(text)
	  local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname, text)
end)

RegisterServerEvent('3dme:me')
AddEventHandler('3dme:me', function(text)
	  local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, text)
end)

  TriggerEvent('es:addCommand', 'me', function(source, args, user)
      local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname ..' ' .. name.lastname, table.concat(args, " "))
  end)

  TriggerEvent('es:addCommand', 'do', function(source, args, user)
      local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname .. ' ' .. name.lastname, table.concat(args, " "))
  end)

  TriggerEvent('es:addCommand', 'twt', function(source, args, user)
  	local name = getIdentity(source)
  	TriggerClientEvent('chatMessage', -1, "^4Twitter | ^3" .. name.firstname .. ' ' .. name.lastname .. "^0", {30, 144, 255}, table.concat(args, " "))
  end)

  TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
  	TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source), {128, 128, 128}, table.concat(args, " "))
  end, {help = 'Send an out of character message to the whole server.'})
   
   TriggerEvent('es:addCommand', 'darkweb', function(source, args, user)
  	TriggerClientEvent('chatMessage', -1, "^6Darkweb | ^5 ", {30, 144, 255}, table.concat(args, " "))
  end, {help = ' [IC]'})
  
function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end