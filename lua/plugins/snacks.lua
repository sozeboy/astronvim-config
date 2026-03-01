local builtin = require "telescope.builtin"

return {
  -- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- NOTE: Options
    opts = {
      -- Snacks Modules
      input = {
        enabled = true,
      },
      quickfile = {
        enabled = true,
        exclude = { "latex" },
      },
      -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      picker = {
        enabled = true,
        matchers = {
          frecency = true,
          cwd_bonus = false,
        },
        exclude = {
          ".git",
          "node_modules",
          "dist",
          "build",
        },
        formatters = {
          file = {
            filename_first = true,
            filename_only = false,
            icon_width = 2,
          },
        },
        layout = {
          -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
          -- override picker layout in keymaps function as a param below
          preset = "telescope", -- defaults to this layout unless overidden
          cycle = false,
        },
        layouts = {
          select = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.6,
              min_width = 80,
              height = 0.4,
              min_height = 10,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
            },
          },
          telescope = {
            reverse = true, -- set to false for search bar to be on top
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0.8,
              height = 0.9,
              border = "none",
              {
                box = "vertical",
                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.50,
                border = "rounded",
                title_pos = "center",
              },
            },
          },
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              width = 0,
              height = 0.4,
              position = "bottom",
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
        },
      },
      image = {
        enabled = function() return vim.bo.filetype == "markdown" end,
        doc = {
          float = false, -- show image on cursor hover
          inline = false, -- show image inline
          max_width = 50,
          max_height = 30,
          wo = {
            wrap = false,
          },
        },
        convert = {
          notify = true,
          command = "magick",
        },
      },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = "", key = "f", desc = "Find File", action = ":Telescope find_files" },
            { icon = "", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "", key = "g", desc = "Find Text", action = "<Leader>/" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
  ███████╗██████╗ ███████╗██╗  ██╗██╗███╗   ██╗███████╗
  ██╔════╝╚════██╗╚══███╔╝██║ ██╔╝██║████╗  ██║██╔════╝
  █████╗   █████╔╝  ███╔╝ █████╔╝ ██║██╔██╗ ██║███████╗
  ██╔══╝   ╚═══██╗ ███╔╝  ██╔═██╗ ██║██║╚██╗██║╚════██║
  ██║     ██████╔╝███████╗██║  ██╗██║██║ ╚████║███████║
  ╚═╝     ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝ ]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      diagnostics = {
        enabled = true,
      },
    },
    -- NOTE: keymaps
    keys = {
      { "<leader>lg", function() require("snacks").lazygit() end, desc = "Lazygit" },
      { "<leader>lgl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
      { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
      { "<leader>dB", function() require("snacks").bufdelete() end, desc = "Delete or Close Buffer  (Confirm)" },

      -- find
      {
        "<leader><space>",
        function() builtin.find_files() end,
        desc = "Find Files",
      },
      {
        "<leader>fc",
        function() builtin.find_files() { cwd = "~/.config/nvim/lua" } end,
        desc = "Find Config",
      },
      {
        "<leader>/",
        function() builtin.live_grep() end,
        desc = "Grep word",
      },
      {
        "<leader>fw",
        function() builtin.grep_string() end,
        desc = "Search Visual selection or Word",
        mode = { "n", "x" },
      },
      {
        "<leader>fk",
        function() builtin.keymaps() end,
        desc = "Search keymaps",
      },
      {
        "<leader>fp",
        function() require("snacks").picker.projects() end,
        desc = "Projects",
      },
      -- Git Stuff
      {
        "<leader>gbr",
        function() require("snacks").picker.git_branches { layout = "select" } end,
        desc = "Pick and Switch Git Branches",
      },

      -- colorschema
      {
        "<leader>uC",
        function() builtin.colorscheme() { layout = "select" } end,
        desc = "Pick Color Schemes",
      },
      { "<leader>vh", function() require("snacks").picker.help() end, desc = "Help Pages" },
      { "<leader>n", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
      { "<leader>:", function() builtin.command_history() end, desc = "Command History" },
    },
  },
  -- NOTE: todo comments w/ snacks
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    optional = true,
    keys = {
      { "<leader>pt", function() require("snacks").picker.todo_comments() end, desc = "All" },
      {
        "<leader>pT",
        function() require("snacks").picker.todo_comments { keywords = { "TODO", "FORGETNOT", "FIXME" } } end,
        desc = "mains",
      },
    },
  },
}
