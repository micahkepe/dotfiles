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

  -- Zola template tags
  s(
    { trig = "more", desc = "Add Zola Summary Separator" },
    { t { "<!-- more -->" } }
  ),

  -- Inline Math
  s({ trig = "im", desc = "Inline math" }, {
    t "$",
    i(1),
    t "$",
  }),

  -- Display Math
  s({ trig = "dm", desc = "Display math" }, {
    t { "$$", "\t" },
    i(1),
    t { "", "$$" },
  }),

  -- Zola Page Frontmatter
  -- Example:
  --
  -- +++
  -- title = "Page title"
  -- date = 2025-02-08
  -- draft = true
  --
  -- [taxonomies]
  -- categories = ["programming"]
  -- tags = ["tools", "cli"]
  --
  -- [extra]
  -- toc = true
  -- +++
  s({ trig = "frontmatter", desc = "Insert Basic Zola Page Frontmatter" }, {
    t { "+++", "" },
    t { 'title = "' },
    i(1, "Page Title"),
    t { '"', "" },
    t { "date = " },
    i(2, os.date "%Y-%m-%d"),
    t { "", "draft = " },
    i(3, "true"),
    t { "", "", "[taxonomies]", "" },
    t { "categories = [" },
    i(4, '"programming"'),
    t { "]", "" },
    t { "tags = [" },
    i(5, '"tools"'),
    t { "]", "" },
    t { "", "[extra]", "" },
    t { "toc = " },
    i(6, "true"),
    t { "", "+++" },
    i(0),
  }),
}
