local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- Rust code
  s("rust", {
    t { "```rust", "" },
    i(1),
    t { "", "```" },
  }),

  -- Bash code
  s("bash", {
    t { "```bash", "" },
    i(1),
    t { "", "```" },
  }),

  -- Inline code
  s("ic", {
    t { "`" },
    i(1),
    t { "`" },
  }),
}
