-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		devices = {
		    '*@ Home' -- all family members @ Home dummy device, like 'Qs @ Home'
			--'People at Home'
		},
		timer = {
	        'every minute'
	    }
	},
    logging = {
	    marker = "<<People at Home checker>>"
	},
	-- actual event code
	-- in case of a timer event or security event, device == nil
	execute = function(domoticz, device)

		local DEBUG_MODE = 1


		local atHomeDevicesRegex = {
	        'Q @ Home',
	        'C @ Home',
	        'S @ Home',
	        'J @ Home',
	        'R @ Home',
	        'CJ @ Home',
	        'L @ Home'
	    }

	    local peopleAtHomeDevice = domoticz.devices(x) -- device name: People at Home
	    local numOfPeopleAtHome = 0
	    local peopleAtHomeDeviceFromOffToOn = false

        local allMembersAtHomeDevices = domoticz.devices().filter(atHomeDevicesRegex)

        allMembersAtHomeDevices.forEach(function(memberDevice)

                if(
                    --domoticz.variables('dzVentsScriptDebugMode').value == 1
                    DEBUG_MODE == 1
                ) then
                    domoticz.log('Starting to check Device: \'' .. memberDevice.name .. '\', state == ' .. memberDevice.state)
                end


                if(memberDevice.state == 'On') then

                    -- plus 1 if a people at home
                    numOfPeopleAtHome = numOfPeopleAtHome + 1

                    if(domoticz.variables('HomeSecurityArmStatus').value ~= 'Off') then
                        domoticz.variables('HomeSecurityArmStatus').set('Off')
                    end


                    if(peopleAtHomeDevice.state == 'Off') then
                        peopleAtHomeDevice.switchOn().checkFirst()

                        peopleAtHomeDeviceFromOffToOn = true

                        
                    end

                end
        end)

        -- if some one at home, send only once notification
        if(numOfPeopleAtHome > 0 and peopleAtHomeDeviceFromOffToOn == true) then
            domoticz.notify('Domoticz: People at Home', numOfPeopleAtHome .. ' people at home now', domoticz.PRIORITY_LOW)
        end

        -- if no one at home, switch 'People at Home' off
        if(numOfPeopleAtHome == 0 and peopleAtHomeDevice.state == 'On') then
            peopleAtHomeDevice.switchOff().checkFirst()

            
            domoticz.notify('Domoticz: None at Home', 'No any people at home', domoticz.PRIORITY_HIGH)
        end


	end
}