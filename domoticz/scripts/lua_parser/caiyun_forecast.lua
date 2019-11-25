result = request['content'];


-- hourly rain forecast - current to 5 hours
local zeroHourRainfall = domoticz_applyJsonPath(result, '.result.hourly.precipitation[0].value')
local oneHourRainfall = domoticz_applyJsonPath(result, '.result.hourly.precipitation[1].value')
local twoHourRainfall = domoticz_applyJsonPath(result, '.result.hourly.precipitation[2].value')
local threeHourRainfall = domoticz_applyJsonPath(result, '.result.hourly.precipitation[3].value')
local fourHourRainfall = domoticz_applyJsonPath(result, '.result.hourly.precipitation[4].value')


-- daily rain forecast - today to 3 days
local todayRainfall = domoticz_applyJsonPath(result, '.result.daily.precipitation[0].max')
local tomorrowRainfall = domoticz_applyJsonPath(result, '.result.daily.precipitation[1].max')
local twoDaysRainfall = domoticz_applyJsonPath(result, '.result.daily.precipitation[2].max')


-- daily temperature forecase - 0 - 5 days (5 days)
local todayTempDate =domoticz_applyJsonPath(result, '.result.daily.temperature[0].date')
local todayTempMin = domoticz_applyJsonPath(result, '.result.daily.temperature[0].min')
local todayTempMax = domoticz_applyJsonPath(result, '.result.daily.temperature[0].max')
local todaySkycon = domoticz_applyJsonPath(result, '.result.daily.skycon[0].value')

local tomorrowTempDate =domoticz_applyJsonPath(result, '.result.daily.temperature[1].date')
local tomorrowTempMin = domoticz_applyJsonPath(result, '.result.daily.temperature[1].min')
local tomorrowTempMax = domoticz_applyJsonPath(result, '.result.daily.temperature[1].max')
local tomorrowSkycon = domoticz_applyJsonPath(result, '.result.daily.skycon[1].value')

local thirdDayTempDate =domoticz_applyJsonPath(result, '.result.daily.temperature[2].date')
local thirdDayTempMin = domoticz_applyJsonPath(result, '.result.daily.temperature[2].min')
local thirdDayTempMax = domoticz_applyJsonPath(result, '.result.daily.temperature[2].max')
local thirdDaySkycon = domoticz_applyJsonPath(result, '.result.daily.skycon[2].value')

local forthDayTempDate =domoticz_applyJsonPath(result, '.result.daily.temperature[3].date')
local forthDayTempMin = domoticz_applyJsonPath(result, '.result.daily.temperature[3].min')
local forthDayTempMax = domoticz_applyJsonPath(result, '.result.daily.temperature[3].max')
local forthDaySkycon = domoticz_applyJsonPath(result, '.result.daily.skycon[3].value')

local fifthDayTempDate =domoticz_applyJsonPath(result, '.result.daily.temperature[4].date')
local fifthDayTempMin = domoticz_applyJsonPath(result, '.result.daily.temperature[4].min')
local fifthDayTempMax = domoticz_applyJsonPath(result, '.result.daily.temperature[4].max')
local fifthDaySkycon = domoticz_applyJsonPath(result, '.result.daily.skycon[4].value')






domoticz_updateDevice(729, '', '0;'..zeroHourRainfall)
domoticz_updateDevice(730, '', '0;'..oneHourRainfall)
domoticz_updateDevice(731, '', '0;'..twoHourRainfall)
domoticz_updateDevice(732, '', '0;'..threeHourRainfall)
domoticz_updateDevice(733, '', '0;'..fourHourRainfall)


domoticz_updateDevice(734, '', '0;'..todayRainfall)
domoticz_updateDevice(735, '', '0;'..tomorrowRainfall)
domoticz_updateDevice(736, '', '0;'..twoDaysRainfall)


local todayTempText = todayTempDate .. ':  ' .. todayTempMin .. ' ℃ ~ '.. todayTempMax ..' ℃ (' .. todaySkycon .. ')'
local tomorrowTempText = tomorrowTempDate .. ':  ' .. tomorrowTempMin ..' ℃ ~ '.. tomorrowTempMax ..' ℃ ('.. tomorrowSkycon .. ')'
local thirdDayTempText = thirdDayTempDate .. ':  ' .. thirdDayTempMin .. ' ℃ ~ '.. thirdDayTempMax..' ℃ ('..thirdDaySkycon .. ')'
local fourthDayTempText = forthDayTempDate .. ':  ' .. forthDayTempMin .. ' ℃ ~ '.. forthDayTempMax..' ℃ (' .. forthDaySkycon .. ')'
local fifthDayTempText = fifthDayTempDate .. ':  ' .. fifthDayTempMin .. ' ℃ ~ '.. fifthDayTempMax..' ℃ (' .. fifthDaySkycon .. ')'

domoticz_updateDevice(737,'',todayTempText)
domoticz_updateDevice(738,'',tomorrowTempText)
domoticz_updateDevice(739,'',thirdDayTempText)
domoticz_updateDevice(740,'',fourthDayTempText)
domoticz_updateDevice(741,'',fifthDayTempText)