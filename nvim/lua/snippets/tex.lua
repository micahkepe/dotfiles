local ls = require "luasnip" -- Import LuaSnip
local s = ls.snippet -- Create snippets
local t = ls.text_node -- Text node
local i = ls.insert_node -- Insert node
local f = ls.function_node -- Function node
local c = ls.choice_node -- Choice node
local d = ls.dynamic_node -- Dynamic node
local fmt = require("luasnip.extras.fmt").fmt -- Formatter
local fmta = require("luasnip.extras.fmt").fmta -- Angle-bracket formatter
local rep = require("luasnip.extras").rep -- Repeat text

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
  s("mk", {
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

  -- Fraction
  s("//", {
    t "\\frac{",
    i(1),
    t "}{",
    i(2),
    t "}",
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
}
