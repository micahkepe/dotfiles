-- Helpful snippets for LaTeX documents
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node

return {
  -- Answer Box
  s({ trig = "box", desc = "Centered box for answer", priority = 1001 }, {
    t { "\\[", "" },
    t "\t\\boxed{",
    i(1, "answer"),
    t { "}", "" },
    t { "\\]" },
  }),

  -- Inline Math
  s({ trig = "im", desc = "Inline math" }, {
    t "$",
    i(1),
    t "$",
  }),

  -- Display Math
  s({ trig = "dm", desc = "Display math" }, {
    t { "\\[", "\t" },
    i(1),
    t { "", "\\]" },
  }),

  -- Subscript
  s({ trig = "sub", desc = "Subscript" }, {
    t "_{",
    i(1),
    t "}",
  }),

  -- Superscript
  s({ trig = "sup", desc = "Superscript" }, {
    t "^{",
    i(1),
    t "}",
  }),

  -- Solution subsection
  s({ trig = "solsub", desc = "Solution subsection" }, {
    t { "\\subsection*{Solution}", "" },
    i(1),
  }),

  -- Vertical space (in centimeters)
  s({ trig = "vs", desc = "Insert vertical space (in cm.)" }, {
    t { "\\vspace{" },
    i(1),
    t { "cm}" },
  }),
}
