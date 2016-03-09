local uri = ngx.var.uri
local req_uri = ngx.var.request_uri

ngx.say(" uri => ", uri)
ngx.say(" request_uri => ", req_uri)
