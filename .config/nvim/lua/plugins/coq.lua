local coq_startup = "COQnow --shut-up"

local config = function()
    vim.opt.completeopt = {"menu", "menuone", "noselect"}
    -- Putting the string directly here breaks Treesitter ¯\_(ツ)_/¯
    vim.cmd(coq_startup)
    vim.keymap.set("n", "<leader>I", require("lspimport").import, { noremap = true })

end

local coq_artifacts = {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts'
}

return {
    "ms-jpq/coq_nvim",
    build = ":COQdeps",
    branch = "coq",
    dependencies = {
      coq_artifacts,
      "ms-jpq/coq.thirdparty",
      "stevanmilic/nvim-lspimport" ,

    },
    config = config,
}
