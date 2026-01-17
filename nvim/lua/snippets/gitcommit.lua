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

  -- that's a me
  s({ trig = "me", desc = "well, of course i know him. he's me." }, {
    t { "micahkepe <micahkepe@gmail.com>" },
  }),
}
