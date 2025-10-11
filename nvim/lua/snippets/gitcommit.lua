-- Helpful snippets for Git commit buffers
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Co-authored-by
  s({ trig = "coauthor", desc = "Add co-authored-by line" }, {
    t { "Co-authored-by: " },
    i(1, "First Last"),
    t { " <" },
    i(2, "email@example.com"),
    t { ">" },
  }),
}
