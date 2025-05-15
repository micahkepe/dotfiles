-- Helpful snippets for Markdown files
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node

return {
  -- Rust code
  s({ trig = "rust", desc = "Insert Rust codeblock" }, {
    t { "```rust", "" },
    i(1),
    t { "", "```" },
  }),

  -- Bash code
  s({ trig = "bash", desc = "Insert Bash codeblock" }, {
    t { "```bash", "" },
    i(1),
    t { "", "```" },
  }),

  -- Inline code
  s({ trig = "ic", desc = "Inline code" }, {
    t { "`" },
    i(1),
    t { "`" },
  }),

  -- Right arrow
  s({ trig = "rarr", desc = "Right arrow" }, { t { "&rarr; " } }),

  -- Left arrow
  s({ trig = "larr", desc = "Left arrow" }, { t { "&larr; " } }),

  -- Checkbox
  s({ trig = "checkbox", desc = "Checkbox item" }, { t { "- [ ] " } }),
}
