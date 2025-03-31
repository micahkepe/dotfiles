-- Helpful snippets for LaTeX documents
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

  -- Answer Box
  s({ trig = "box", desc = "Centered box for answer" }, {
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

  -- Vertical space (in centimeters)
  s("vs", {
    t { "\\vspace{" },
    i(1),
    t { "cm}" },
  }),
}
