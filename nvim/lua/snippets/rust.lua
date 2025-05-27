-- Helpful snippets for Rust files
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node

return {
  -- Turbofish notation
  s({ trig = "turbofish", desc = "Turbofish\n `::<_>`" }, {
    t { "::<" },
    i(1, "_"),
    t { ">" },
  }),
}
