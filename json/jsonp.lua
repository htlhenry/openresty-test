local cj = require "cjson"
local ngx = ngx


--ngx.log(ngx.DEBUG, ngx.var.uri)

function say_exit(ret)
    ngx.header.content_type = "text/json"
    if ngx.var.arg_callback then
        ngx.say(ngx.var.arg_callback .. "(" .. cj.encode(ret) .. ")")
    else
        ngx.say(cj.encode(ret))
    end
    ngx.exit(200)
end
--拼接一个callback(),根据url上带的参数。

local t = {}
t.code = 0
t.data = {}
t.data.curtime = ngx.time()
say_exit(t)