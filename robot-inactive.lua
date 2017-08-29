--[[
Changes robot inactive alarm to information severity if server target is not reachable
--]]

--[[
pings the device trying retries number of times

Args:
    device (string) is the name or ip address of the target
    retries (integer) is the number of times to attempt the ping

Returns:
    true if the ping is successful
    false if the ping is not successful
--]]
function pingable(device, retries)
    local command = 'ping -n ' .. retries .. ' ' .. device .. '  >nul 2>&1'
    local result = os.execute(command)
    if result == 0 then
        -- ping was successful
        return true
    else
        -- ping failed
        return false
    end
end


-- main program
local retries = 2
if pingable(event.source, retries) then
    print(event.source .. ' is pingable.')
else
    print(event.source .. ' is not pingable.')
    -- set alarm to informational (1) or close/clear it (0)
    event.level = 1
end
return event
