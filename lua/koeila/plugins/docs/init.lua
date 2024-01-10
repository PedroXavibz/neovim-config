local status_ok, docs = pcall(require, 'docs-view')

if not status_ok then
  return
end

docs.setup({
  position = "bottom",
  width = 30,
  height = 10,
  update_mode = 'auto'
})
