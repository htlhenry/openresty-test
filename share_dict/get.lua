local dog = ngx.shared.dog
local log = ngx.log
local err = ngx.ERR


local val, err = dog:get(test)
     if val then
        ngx.say("get test : ", val)
     else
     	ngx.say("not get test : ", err)
     end
