--https://www.youtube.com/watch?v=bTWWFQZqzyI&ab_channel=TJDeVries
--
-- :h lspconfig-all
-- and then search for the install instructions
--
-- echo executable('<name of lsp>')
-- echo executable('tailwindcss-language-server')

-- :LazyDev lsp
-- will show which lsps are running, which is helpful for
-- checking things are working as expected!

-- commands like the below allow communication between the lsp and blink
-- require("lspconfig").lua_ls.setup({ capabilites = capabilities })

--
-- if returns 1 nvim can access the lsp

-------------------------------------------------------------------------------
--- UPDATE - not quite functional
-------------------------------------------------------------------------------
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "L3MON4D3/LuaSnip",
            "j-hui/fidget.nvim",
            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- require("fidget").setup({})
            -- require("luasnip.loaders.from_vscode").lazy_load()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            --------------------------------------------------------------
            -- 1. Install the lsp
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "tailwindcss",
                    "templ",
                    "terraformls",
                    "html",
                    "htmx",
                    "pyright",
                },
                automatic_installation = true,
            })

            --------------------------------------------------------------
            -- 2. attach and config

            --lua
            lspconfig.lua_ls.setup({ capabilites = capabilities })

            --go
            lspconfig.gopls.setup({ capabilites = capabilities })

            -- tailwind
            lspconfig.tailwindcss.setup({ capabilites = capabilities })

            -- templ
            lspconfig.templ.setup({ capabilites = capabilities })

            --terraform
            lspconfig.terraformls.setup({ capabilites = capabilities })
            --TODO: terraform-lsp might be also a good one to install?

            --html
            lspconfig.html.setup({ capabilites = capabilities })

            --htmx
            lspconfig.htmx.setup({ capabilites = capabilities })

            --python
            lspconfig.pyright.setup({ capabilites = capabilities })

            --------------------------------------------------------------
            --attaching the lsp
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local c = vim.lsp.get_client_by_id(args.data.client_id)
                    if not c then
                        return
                    end

                    if vim.bo.filetype == "lua" then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
