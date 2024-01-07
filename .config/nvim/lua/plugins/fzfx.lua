local M = {
    -- mandatory
    { "junegunn/fzf", build = ":call fzf#install()" },
    {
        "linrongbin16/fzfx.nvim",
        dependencies = { "junegunn/fzf" },
        config = function()
            require("fzfx").setup()
        end
    },

}
return M
