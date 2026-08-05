return {
  "dlyongemallo/diffview.nvim",
  event = "VeryLazy",
  config = function()
    require("diffview").setup {
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      file_panel = {
        show_branch_name = true,
        always_show_sections = true,
      },
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff4_mixed",
          disable_diagnostics = true,
          winbar_info = true,
        },
        cycle_layouts = {
          merge_tool = {
            "diff4_mixed",
            "diff3_mixed",
            "diff3_horizontal",
            "diff1_plain",
          },
        },
      },
      diffopt = { algorithm = "histogram" },
    }
  end,
}
