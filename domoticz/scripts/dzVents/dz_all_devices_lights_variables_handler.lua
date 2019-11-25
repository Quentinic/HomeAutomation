return {
	on = {
-- 		devices = {
-- 			'myDevice'
-- 		}
        variables = {
            'ALL_DEVICES_ON',
            'ALL_DEVICES_OFF'
        }
	},
	logging = {
        marker = "<<All Devices and Lights variables Handler>>"
    },
	execute = function(domoticz, item)


        if(item.isVariable and item.name == 'ALL_DEVICES_ON') then

            domoticz.log('Variable: ' .. item.name .. ' has been changed as ' .. item.value ..', synchronized this value to Variable: ALL_LIGHTS_ON')

            domoticz.variables('ALL_LIGHTS_ON').set(item.value)

        elseif(item.isVariable and item.name == 'ALL_DEVICES_OFF') then

            domoticz.log('Variable: ' .. item.name .. ' has been changed as '.. item.value .. ', synchronized this value to Variable: ALL_LIGHTS_OFF')

            domoticz.variables('ALL_LIGHTS_OFF').set(item.value)

        end


	end
}