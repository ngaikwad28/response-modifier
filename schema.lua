local typedefs = require "kong.db.schema.typedefs"

return {
  name = "response-modifier",
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { sensitive_patterns = { type = "array", elements = { type = "string" } } },
          { replacement_text = { type = "string", required = true, default = "[REDACTED]" } },
        },
      },
    },
  },
}
