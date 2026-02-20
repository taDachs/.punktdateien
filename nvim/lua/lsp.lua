vim.pack.add {
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/j-hui/fidget.nvim" },
}

require("fidget").setup {}

local servers = {
  "lua_ls",
  "clangd",
  "ruff",
  "ty",
  "lemminx",
  "docker_language_server",
  "docker_compose_language_server",
  "dockerls",
  "copilot",
}

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("grd", vim.lsp.buf.definition, "Goto Definition")
    map("grr", vim.lsp.buf.references, "Goto References")
    map("gri", vim.lsp.buf.implementation, "Goto Implementation")
    map("grD", vim.lsp.buf.declaration, "Goto Declaration")
    map("grt", vim.lsp.buf.type_definition, "Type Definition")
    map("<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")
    map("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("config-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "config-lsp-highlight", buffer = event2.buf }
        end,
      })
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "Toggle Inlay Hints")
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, event.buf) then
      map("<leader>tc", function()
        vim.notify("Toggling inline completion: " .. (vim.lsp.inline_completion.is_enabled { bufnr = event.buf } and "off" or "on"))
        vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled { bufnr = event.buf })
      end, "Toggle Inlay Completion")

      vim.keymap.set(
        'i',
        '<C-F>',
        vim.lsp.inline_completion.get,
        { desc = 'LSP: accept inline completion', buffer = event.buf }
      )
      vim.keymap.set(
        'i',
        '<C-G>',
        vim.lsp.inline_completion.select,
        { desc = 'LSP: switch inline completion', buffer = event.buf }
      )
    end
  end,
})

-- prettier diagnostic signs
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  jump = {
    --- @param diagnostic? vim.Diagnostic
    --- @param bufnr integer
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = "cursor",
        focus = false,
      }
    end,
  },
}
