-- regluar expression that matches all power meter devices, BUT NOT the virtual power meter
powerMeterRegex = "^.*%(watt%)$"
-- find the idx property of your virtual power meter at /json.htm?type=devices
totalConsumptionMeterId = 310
commandArray = {}

tc=next(devicechanged)
deviceChangedName=tostring(tc)

if not deviceChangedName:match(powerMeterRegex) then
    -- not matching our power meter devices
    return commandArray
end

totalConsumption = 0
-- loop through all the devices
for deviceName,deviceValue in pairs(otherdevices) do
    if deviceName:match(powerMeterRegex) then
        totalConsumption = totalConsumption + tonumber(otherdevices_svalues[deviceName])
    end
end

commandArray['UpdateDevice'] = totalConsumptionMeterId .. "|0|" .. totalConsumption

return commandArray

