local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- Begin-End Environment
  s("beg", {
    t "\\begin{",
    i(1, "environment"),
    t "}",
    t { "", "" },
    i(2),
    t { "", "\\end{" },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t "}",
  }),

  -- Inline Math
  s("im", {
    t "$",
    i(1),
    t "$",
  }),

  -- Display Math
  s("dm", {
    t { "\\[", "\t" },
    i(1),
    t { "", "\\]" },
  }),

  -- Subscript
  s("sub", {
    t "_{",
    i(1),
    t "}",
  }),

  -- Superscript
  s("sup", {
    t "^{",
    i(1),
    t "}",
  }),

  -- Solution subsection
  s("solsub", {
    t { "\\subsection*{Solution}", "" },
    i(1),
  }),
}
