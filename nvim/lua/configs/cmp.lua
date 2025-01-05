dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"

local options = {
  completion = { completeopt = "menu,menuone" },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),

    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local completion_item = entry:get_completion_item()
      local highlights_info = require("colorful-menu").highlights(completion_item, vim.bo.filetype)

      -- error, such as missing parser, fallback to use raw label.
      if highlights_info == nil then
        vim_item.abbr = completion_item.label
      else
        vim_item.abbr_hl_group = highlights_info.highlights
        vim_item.abbr = highlights_info.text
      end

      local kind = require("lspkind").cmp_format {
        mode = "symbol_text",
      }(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      vim_item.kind = " " .. (strings[1] or "") .. " "
      vim_item.menu = ""

      return vim_item
    end,
  },
}

return vim.tbl_deep_extend("force", options, require "nvchad.cmp")
