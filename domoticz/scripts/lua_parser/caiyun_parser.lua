s = request['content'];

local temperature = domoticz_applyJsonPath(s, '.result.temperature')
local humidity = domoticz_applyJsonPath(s, '.result.humidity')
local pressure = domoticz_applyJsonPath(s, '.result.pres')
local aqi = domoticz_applyJsonPath(s, '.result.aqi')
local pm25 = domoticz_applyJsonPath(s, '.result.pm25')
local pm10 = domoticz_applyJsonPath(s, '.result.pm10')
local wind_dir = domoticz_applyJsonPath(s, '.result.wind.direction')
local wind_speed = domoticz_applyJsonPath(s, '.result.wind.speed')
local skycon = domoticz_applyJsonPath(s, '.result.skycon')
local alert = domoticz_applyJsonPath(s, '.result.alert.content[0]')
local description = domoticz_applyJsonPath(s, '.result.description')

local pres_for = '0'
local hum_stat = '0'



if alert == nil then
	alert = '无天气预警'
end
if description == nil then
	description = '无出行建议'
end



if humidity >= 0.4 and humidity <= 0.6 then
	hum_stat = '1'
elseif humidity >= 0.3 and humidity <= 0.8 then
	hum_stat = '0'
elseif humidity > 0.8 then
	hum_stat = '3'
elseif humidity < 0.3 then
	hum_stat = '2'
end

if skycon == 'CLEAR_DAY' or skycon == 'CLEAR_NIGHT' then
	pres_for = '1'
elseif skycon == 'PARTLY_CLOUDY_DAY' or skycon == 'PARTLY_CLOUDY_NIGHT' then
	pres_for = '2'
elseif skycon == 'CLOUDY' then
	pres_for = '3'
elseif skycon == 'RAIN' then
	pres_for = '4'
end

local thb = tostring(temperature)..';'..tostring(humidity*100)..';'..hum_stat..';'..tostring(pressure/100)..';'..pres_for

domoticz_updateDevice(610,'',thb)
domoticz_updateDevice(616,'',tostring(aqi))
domoticz_updateDevice(614,'',tostring(pm25))
domoticz_updateDevice(615,'',tostring(pm10))
domoticz_updateDevice(617,'',alert)
domoticz_updateDevice(618,'',description)