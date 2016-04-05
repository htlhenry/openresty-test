local log = ngx.log
local ERR = ngx.ERR


local redis = require("resty.redis")
local red = redis:new()

red:set_timeout(1000)  -- 1 sec

local ok, err = red:connect("ipaddress", "port")
    if not ok then
        log(ERR, "redis connect error  =>  ", err)
        return
    end

--- do something

-- 将连接放到连接池，（size， idletime）
local ok, err = red:set_keepalive(6000, 300)
    if not ok then
        log(ERR, "redis set_keepalive error =>  ", err)
        return
    end

