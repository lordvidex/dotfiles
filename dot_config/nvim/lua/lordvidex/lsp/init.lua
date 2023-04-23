local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
require "lordvidex.lsp.mason"
require("lordvidex.lsp.handlers").setup()
require "lordvidex.lsp.null-ls"
require "lordvidex.lsp.saga"
require "lordvidex.lsp.signature"
require "lordvidex.lsp.flutter"
require 'lordvidex.lsp.go'
