local PLUGIN_NAME = "response-modifier"

describe(PLUGIN_NAME, function()
  local bp, db

  setup(function()
    bp, db = helpers.get_db_utils("postgres", {
      "routes",
      "services",
      "plugins",
    }, { PLUGIN_NAME })
  end)

  it("masks sensitive data in the response body", function()
    local route = bp.routes:insert({
      hosts = { "test.com" },
    })

    bp.plugins:insert({
      name = PLUGIN_NAME,
      route = { id = route.id },
      config = {
        sensitive_patterns = { "secret", "password" },
        replacement_text = "[REDACTED]",
      },
    })

    local res = assert(helpers.proxy_client():get("/test", {
      headers = { host = "test.com" },
    }))
    local body = assert.res_status(200, res)
    assert.not_matches("secret", body)
    assert.matches("[REDACTED]", body)
  end)
end)
