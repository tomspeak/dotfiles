---@type vim.lsp.Config
return {
  cmd = { "zls" },
  filetypes = { "zig" },
  root_markers = { "zls.json", "build.zig" },
  settings = {
    enable_build_on_save = true,
    build_on_save_args = "check",
  }
}
