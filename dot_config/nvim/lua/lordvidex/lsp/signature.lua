local cfg = {}
local ok, sig = pcall(require, 'lsp_signature')
if not ok then
  return
end
sig.setup(cfg)
