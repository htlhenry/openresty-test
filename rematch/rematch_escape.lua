-- 当ngx.re.match中使用\w这样的元字符时，需要加上转义字符\。下面是一个简单的demo

local s = "hello=world"
local capture, err = ngx.re.match(s, "(\\w+)=(\\w+)","x")
    if not capture then
       ngx.say(" not match : ", err)
    end
ngx.say("type(capture) : ", type(capture))
ngx.say(" hello world : ", capture[0])
ngx.say(" hello : ", capture[1])
ngx.say(" world : ", capture[2])


-- 官方样例：
-- syntax: captures, err = ngx.re.match(subject, regex, options?, ctx?, res_table?)

-- context: init_worker_by_lua*, set_by_lua*, rewrite_by_lua*, access_by_lua*, content_by_lua*, header_filter_by_lua*, body_filter_by_lua*, log_by_lua*, ngx.timer.*, balancer_by_lua*, ssl_certificate_by_lua*

-- Matches the subject string using the Perl compatible regular expression regex with the optional options.

-- Only the first occurrence of the match is returned, or nil if no match is found. In case of errors, like seeing a bad regular expression or exceeding the PCRE stack limit, nil and a string describing the error will be returned.

-- When a match is found, a Lua table captures is returned, where captures[0] holds the whole substring being matched, and captures[1] holds the first parenthesized sub-pattern's capturing, captures[2] the second, and so on.
-- ```
--  local m, err = ngx.re.match("hello, 1234", "[0-9]+")
--  if m then
--      -- m[0] == "1234"

--  else
--      if err then
--          ngx.log(ngx.ERR, "error: ", err)
--          return
--      end

--      ngx.say("match not found")
--  end
--  ```
--  ```
--  local m, err = ngx.re.match("hello, 1234", "([0-9])[0-9]+")
--  -- m[0] == "1234"
--  -- m[1] == "1"
--  ```
-- ```
-- Specify options to control how the match operation will be performed. The following option characters are supported:

-- a             anchored mode (only match from the beginning)

-- d             enable the DFA mode (or the longest token match semantics).
--               this requires PCRE 6.0+ or else a Lua exception will be thrown.
--               first introduced in ngx_lua v0.3.1rc30.

-- D             enable duplicate named pattern support. This allows named
--               subpattern names to be repeated, returning the captures in
--               an array-like Lua table. for example,
--                 local m = ngx.re.match("hello, world",
--                                        "(?<named>\w+), (?<named>\w+)",
--                                        "D")
--                 -- m["named"] == {"hello", "world"}
--               this option was first introduced in the v0.7.14 release.
--               this option requires at least PCRE 8.12.

-- i             case insensitive mode (similar to Perl's /i modifier)

-- j             enable PCRE JIT compilation, this requires PCRE 8.21+ which
--               must be built with the --enable-jit option. for optimum performance,
--               this option should always be used together with the 'o' option.
--               first introduced in ngx_lua v0.3.1rc30.

-- J             enable the PCRE Javascript compatible mode. this option was
--               first introduced in the v0.7.14 release. this option requires
--               at least PCRE 8.12.

-- m             multi-line mode (similar to Perl's /m modifier)

-- o             compile-once mode (similar to Perl's /o modifier),
--               to enable the worker-process-level compiled-regex cache

-- s             single-line mode (similar to Perl's /s modifier)

-- u             UTF-8 mode. this requires PCRE to be built with
--               the --enable-utf8 option or else a Lua exception will be thrown.

-- U             similar to "u" but disables PCRE's UTF-8 validity check on
--               the subject string. first introduced in ngx_lua v0.8.1.

-- x             extended mode (similar to Perl's /x modifier)
-- ```
