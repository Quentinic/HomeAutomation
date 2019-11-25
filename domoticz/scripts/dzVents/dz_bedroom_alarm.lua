-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		devices = {
			--635, -- name = 'No.3 SOS'
			636, -- name = 'No.3 Lock'
			637 -- name = 'No.3 Unlock'
		},

-- 		timer = {
-- 	       -- 'between 21:00 and sunrise'
-- 	       'at 22:00-07:00'
-- 	    }
	}
	,
    logging = {
	    marker = "<<Bedroom Alarm>>"
	},

	-- actual event code
	-- in case of a timer event or security event, device == nil
	execute = function(domoticz, device)

		--
		-- when either 'Lock' button or 'Unlock' button has been pushed, will check if the SOS button has been pushed within 5s before
		--

		local numberThreeSOSDevice = domoticz.devices(635)

		local SOSPushedSecondsAgo = numberThreeSOSDevice.lastUpdate.secondsAgo
		domoticz.log('No.3 SOS button has been pushed ' .. SOSPushedSecondsAgo .. ' seconds ago.')
		local lockOrUnLOCKPushedSecondsAgo = device.lastUpdate.secondsAgo
		domoticz.log('No.3 Lock / No.3 Unlock button has been pushed ' .. lockOrUnLOCKPushedSecondsAgo .. ' seconds ago.')


		if(
		    device.state == 'On'
		    and
		    SOSPushedSecondsAgo <= 5
		    and
		    (lockOrUnLOCKPushedSecondsAgo > SOSPushedSecondsAgo) -- lastUpdate will not include this time trigger
	    ) then

		    domoticz.log('ATTENTION please, Bedroom ALARM trigged.')
		    domoticz.notify('Domoticz: !!! ATTENTION !!! Bedroom ALARM trigged.', domoticz.PRIORITY_HIGH)

        end




	end
}