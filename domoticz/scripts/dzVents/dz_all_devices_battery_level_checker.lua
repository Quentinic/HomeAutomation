return {
    active = true,
    
	on = {
		timer = {
			'at 12:34 on sun'
		}
	},
	logging = {
        marker = "<<All Devices Battery Level Checker>>"
    },

	execute = function(domoticz, timer)
	    local ORIGINAL_TEXT = 'Checking result: <br/><br/>'
	    
	    local notificationMail = ORIGINAL_TEXT
	    
	    domoticz.devices().forEach(
	        
	        function(device)
	            
	            if(domoticz.variables('dzVentsScriptDebugMode').value == 1) then
                    domoticz.log('Start checking Device: \'' .. device.name .. '\' battery level...')
                end
	            
	            
	            if(device.batteryLevel ~= nil and device.batteryLevel < 20) then
	                domoticz.log('Device: <' .. device.name .. '> battery level is LOW: ' .. device.batteryLevel)
	                
                    notificationMail = notificationMail .. '<br/>' .. device.name .. ' battery level is low: ' .. device.batteryLevel .. ';'     
                end
                
	        end
	   )
	   
	   
	   if(notificationMail == ORIGINAL_TEXT) then
	        notificationMail = ORIGINAL_TEXT .. 'All battery-powered devices are full of energy.'
	   end
	   
	   
	   domoticz.email('Domoticz: All devices battery level check', notificationMail, 'xxxxxxx@qq.com')
	   
	    
	end
}