return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = {
    require("telescope").setup {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    },
  },
}
