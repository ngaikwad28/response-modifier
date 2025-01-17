-- handler.lua
local kong = kong

local ResponseModifierHandler = {
  PRIORITY = 10,
  VERSION = "1.0.0",
}

function ResponseModifierHandler:body_filter(conf)
  local body, err = kong.response.get_raw_body()
  if err then
    kong.log.err("Error retrieving response body: ", err)
    return
  end

  if body then
    for _, pattern in ipairs(conf.sensitive_patterns) do
      body = body:gsub(pattern, conf.replacement_text)
    end
    kong.response.set_raw_body(body)
  end
end

return ResponseModifierHandler
