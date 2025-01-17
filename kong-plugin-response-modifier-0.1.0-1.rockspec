package = "kong-plugin-response-modifier"
version = "1.0.0-1"
source = {
  url = "https://your-repository-url.tar.gz"
}
description = {
  summary = "A Kong plugin to modify sensitive data in response bodies",
  license = "Apache 2.0",
  homepage = "https://your-homepage-url"
}
dependencies = {
  "kong >= 3.0.0",
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.response-modifier.handler"] = "handler.lua",
    ["kong.plugins.response-modifier.schema"] = "schema.lua",
  },
}
