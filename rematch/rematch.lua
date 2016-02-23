local keyword = ngx.var.http_user_agent
ngx.say(keyword)
--local ok, err = pcall(ngx.re.match(keyword,"(iphone)|(android)|(curl)","i"))
--ngx.say(" ok : ", ok, " err : ", err)
--ngx.say(capt[0])
--ngx.say(unpack(capt))
--ngx.say(type(capt))
local rematch
local capt
local capt_err

rematch = function(keyword)
   capt, capt_err =  ngx.re.match(keyword,"curl|/7","i") --匹配user_agent是curl/7.19.7(?=pattern)后置正向查询.
--PCRE 正则表达式的语法参考,https://yutuo.net/archives/0eaa312fc4ee7eeb.html
   return capt,capt_err
end
local ok, err = pcall(rematch,keyword)
ngx.say(capt[0])
ngx.say(unpack(capt))
ngx.say(type(capt))
