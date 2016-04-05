
local http = require "resty.http"
local httpc = http.new()

-- The generic form gives us more control. We must connect manually.
httpc:set_timeout(500)
httpc:connect("www.baidu.com", 80)

-- And request using a path, rather than a full URI.
local res, err = httpc:request{
    path = "/uri",
    headers = {
    ["Host"] = "www.baidu.com",
      },
      }

if not res then
  ngx.say("failed to request: ", err)
  return
end

-- Now we can use the body_reader iterator, to stream the body according to our desired chunk size.
local reader = res.body_reader

repeat
local chunk, err = reader(8192)
if err then
    ngx.log(ngx.ERR, err)
    break
end

if chunk then
   ngx.say(chunk)
end
until not chunk
local ok, err = httpc:set_keepalive()
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end
