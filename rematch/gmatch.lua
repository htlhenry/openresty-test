local s = "hello=world"

for k, v in string.gmatch(s,"(%w+)=(%w+)") do
	ngx.say(" k : ", k, " v : ", v)
end

