return
{
    "kevinhwang91/nvim-ufo",

    event = { "BufReadPost", "InsertEnter" },

    dependencies =
    {
        "kevinhwang91/promise-async",
    },

    keys =
    {
       {"zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
       {"zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
       {"zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" },
       {"zm", function() require("ufo").closeFoldsWith() end, desc = "Fold more" },
       {"zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },

    opts =
    {
        preview =
        {
            mappings =
            {
                --在预览窗口中，模拟以下vim内置快捷键
                scrollB = "<C-b>", --向上滚动一页
                scrollF = "<C-f>", --向下滚动一页
                scrollU = "<C-u>", --向上滚动半页
                scrollD = "<C-d>", --向下滚动半页
             },
        },

        provider_selector = function(buffer_nr, filetype, buftype)

            local function handleFallbackException(bufnr, err, providerName)
                if type(err) == "string" and err:match "UfoFallbackException"
                then
                    return require("ufo").getFolds(bufnr, providerName)
                else
                    return require("promise").reject(err)
                end
            end

            return (filetype == "" or buftype == "nofile") and "indent"
            or
            function(bufnr)
                return require("ufo").getFolds(bufnr, "lsp")
                :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
                :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
            end
        end,
    },

    config = function(plugin, opts)
        vim.o.foldenable = true
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99

        require('ufo').setup(opts)
    end
}
