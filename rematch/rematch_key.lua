local keyword = ngx.var.arg_keyword

local capt, err = ngx.re.match(keyword,"(?<key>.*)") --(?<named>) 命名的标签
ngx.say(capt["key"])
ngx.say(unpack(capt))
ngx.say(type(capt))
