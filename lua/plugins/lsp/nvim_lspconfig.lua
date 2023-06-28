--neovim LSP客户端的配置文件
return
{
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },


}
