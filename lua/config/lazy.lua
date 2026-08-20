local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- GraphQL Language Server (lê o graphql.config.cjs automaticamente)
-- Mesmo motor da extensão do VS Code: autocomplete / validação / hover.
-- Instalação automática via npm (inclui o `graphql` para não dar exit 1).
do
  local lsp_dir = vim.env.HOME .. "/.local/share/graphql-lsp"
  local bin = lsp_dir .. "/node_modules/.bin/graphql-lsp"

  vim.lsp.config("graphql", {
    cmd = { bin, "server", "-m", "stream" },
    filetypes = { "graphql", "typescript", "typescriptreact", "javascript", "javascriptreact" },
    root_markers = {
      "graphql.config.cjs", "graphql.config.js", "graphql.config.ts", "graphql.config.json",
      ".graphqlrc", ".graphqlrc.cjs", ".graphqlrc.json", "package.json",
    },
  })

  local function enable()
    vim.lsp.enable("graphql")
  end

  if vim.uv.fs_stat(bin) then
    enable() -- já instalado: só habilita
  else
    vim.notify("[graphql] Instalando GraphQL Language Server via npm...", vim.log.levels.INFO)
    vim.system(
      { "sh", "-c", "mkdir -p " .. lsp_dir .. " && cd " .. lsp_dir .. " && npm install graphql-language-service-cli graphql@16" },
      { text = true },
      function(res)
        if res.code == 0 and vim.uv.fs_stat(bin) then
          vim.schedule(enable)
          vim.notify("[graphql] Language Server instalado com sucesso.", vim.log.levels.INFO)
        else
          vim.notify("[graphql] Falha ao instalar o GraphQL LSP:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
        end
      end
    )
  end
end

-- garante que arquivos .gql abram com o filetype correto (graphql)
vim.filetype.add({ extension = { gql = "graphql" } })
