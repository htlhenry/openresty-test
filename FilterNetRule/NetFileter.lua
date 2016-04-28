
local _M = {}

function _M.CompareNet(ip, net, mask)
--转换ip为二进制数
    if type(ip) ~= "string" then
       ip = tostring(ip)
    end
    local ip_string = ""
    for num in string.gmatch(ip, "%d+") do
        local res = ""
        local num = tonumber(num)
        while num > 0 do
              res = math.fmod(num, 2) .. res
              num = math.floor(num / 2)
        end
        local val = 8 - string.len(res)
        if val ~= 0 then
            for i = 1, val do
                res = 0 .. res
            end
        end
        ip_string = ip_string .. res
    end

--转换net为二进制数
    if type(net) ~= "string" then
       net = tostring(net)
    end
    local net_string = ""
    for num in string.gmatch(net, "%d+") do
        local res = ""
        local num = tonumber(num)
        while num > 0 do
              res = math.fmod(num, 2) .. res
              num = math.floor(num / 2)
        end
        local val = 8 - string.len(res)
        if val ~= 0 then
            for i = 1, val do
                res = 0 .. res
            end
        end
        net_string = net_string .. res
    end

    local mask = mask
    local ip_network = string.sub(ip_string, 1, mask)
    local net_network =  string.sub(net_string, 1, mask)
    if ip_network == net_network then
       return 0
    else
       return 1
    end
end

return _M
