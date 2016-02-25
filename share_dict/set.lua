local dog = ngx.shared.dog
local log = ngx.log
local err = ngx.ERR


local val, err = dog:set(test,1)
     if val then
        ngx.say("set test : ", val)
     else
     	ngx.say("not set test : ", err)
     end
