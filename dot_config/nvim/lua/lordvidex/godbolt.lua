local ok, godbolt = pcall(require, "godbolt")
if not ok then
  return
end

godbolt.setup({
  languages = {
    go = { compiler = "gltip", options = {} }
  }
})
