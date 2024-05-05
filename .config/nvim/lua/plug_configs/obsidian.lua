local M = {

  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
--- short cmd func
---@param command string
local cmd = function(command)
  return function()
    vim.cmd(command)
  end
end
M.keys = {
  { ",os", cmd("ObsidianSearch"), desc = "[O]bisidian [S]earch" },
  { ",od", cmd("ObsidianDailies"), desc = "[O]bisidian [D]ailies" },
  { ",oq", cmd("ObsidianQuickSwitch"), desc = "[O]bisidian [Q]uickSwitch" },
  { ",oL", cmd("ObsidianLinks"), desc = "[O]bisidian [L]inks" },
  { ",oln", cmd("ObsidianLinkNew"), desc = "[O]bisidian [L]ink [N]ew" },
  { ",olb", cmd("ObsidianBacklinks"), desc = "[O]bisidian [L]ink [B]acklinks" },
  { ",olf", cmd("ObsidianFollowLink"), desc = "[O]bisidian [L]ink [F]ollow" },
  { ",of", cmd("ObsidianFollowLink"), desc = "[O]bisidian [F]ollowLink" },
  { ",oo", cmd("ObsidianOpen"), desc = "[O]bisidian [O]pen" },
  { ",ot", cmd("ObsidianToday"), desc = "[O]bisidian [T]oday" },
  { ",om", cmd("ObsidianTomorrow"), desc = "[O]bisidian To[m]orrow" },
  { ",oy", cmd("ObsidianYesterday"), desc = "[O]bisidian [Y]esterday" },
  { ",oc", cmd("ObsidianToggleCheckbox"), desc = "[O]bisidian Toggle [C]heckbox" },
}

M.config = function()
  vim.opt.conceallevel = 1
  require("obsidian").setup({
    workspaces = {
      {
        name = "personal",
        path = "~/YAD/0obsidian",
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "worklog/",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "daily.md",
    },
    templates = {
      folder = "Templates",
    },
  })
end

return M
